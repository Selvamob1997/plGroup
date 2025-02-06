// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pl_groups/app/data/model/QualityModel.dart';
import 'package:pl_groups/app/data/model/WarehouseModel.dart';
import 'package:pl_groups/app/data/model/dispatch_bundle_model.dart';
import 'package:pl_groups/app/data/model/dispatch_detail_model.dart';
import 'package:pl_groups/app/data/repository/api_call.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../utils/utility.dart';
import '../splash_screen_module/splash_screen_controller.dart';
import 'packing_screen_page.dart';
import 'package:intl/intl.dart';


class packingScreenController extends GetxController {


  List<dispatch_model> dispatch_table_list = [];

  List<dispatch_bundle_model> dispatch_bundle_table_list = [];

  TextEditingController qty_edt_cntrlr = TextEditingController();

  dispatch_detail_model_List dispatchdetail_list = dispatch_detail_model_List(
      details: []);

  dispatch_detail_model_List dispatch_detail_list = dispatch_detail_model_List(details: []);
  bool is_dispatch_detaildata = false;

  List<BundalScreen> secBundalScreen = [];
  List<QualityModelList> secQualityModelList = [];


  late QrScan rawQrScan;



  // late ScenList secScenList;


  var ImagePath = '';
  late FilePickerResult result;
  final picker = ImagePicker();

  late QualityModel rawQualityModel;
  QRViewController? controller;

  late WarehouseModel rawWarehouseModel;
  List<WhsList> secWhsList=[];

  var lableproductCode;
  var lableitemCode;
  var labledate;

  var lablevarible1;
  var lablevarible2;
  var lablevarible3;
  var lablevarible4;
  var lablevarible5;
  var lablevarible6;
  var lablevarible7;
  var lablevarible8;
  var lablevarible9;
  var lablevarible10;
  var lablevarible11;

  var lablestoragePayNo;
  var lableqrdocEntry;
  var lablelineID;
  var lablebundle;
  var formatter;


  @override
  void onInit() {
    super.onInit();
    //print("dispatch scrn inside oninit");

    formatter = DateFormat('yyyyMMdd').format(DateTime.now());
    //print(formatter.toString());
    splashScreenController().dispose();
    packingScreenController().initialized;
    packingScreenController().
    update();
  }

  void update_state() {
    update();
  }

  Future<void> scanBarcode() async {

     String barcodeScanRes='';
     int count=0;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      //print(barcodeScanRes);

      update();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
     //barcodeScanRes = 'eyJIZWFkZXIgSXRlbSI6IjAwMDA0MiIsIlFSRG9jRW50cnkiOiIxMyIsIkxpbmVJRCI6IjEiLCJCdW5kbGUiOiJXQUwvUkVYNjkifQ==';

    String jsonString = utf8.decode(base64Decode(barcodeScanRes));
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    var s = '';
     s = jsonMap.toString();

     var kv = s.substring(0, s.length - 1).substring(1).split(",");
     final Map<String, String> pairs = {};
     for (int i = 0; i < kv.length; i++) {
       var thisKV = kv[i].split(":");
       pairs[thisKV[0]] = thisKV[1].trim();
     }
     var encoded = json.encode(pairs);
     log(encoded);
     final newdecode = jsonDecode(encoded);
     rawQrScan = QrScan.fromJson(newdecode);
     //print(decode["QRDocEntry"].toString());
    update();
     var decode;
     api_call.getQrDetiles("O", rawQrScan.headerItem, rawQrScan.qRDocEntry, rawQrScan.bundle, rawQrScan.lineID, true).then((value) => {
       if(value.statusCode==200){

         decode= jsonDecode(value.body),

         print(value.body),
         //print(decode[0]["Header Item"].toString()),
         //print(decode[0]['ItemCode'],),
         update(),
         for(int j=0;j<secBundalScreen.length;j++){
           if(secBundalScreen[j].productCode ==decode[0]["Header Item"].toString()){
             count++,
           }
         },

         if(count==0){
           if(decode[0]["Header Item"].toString()=="000001"){
             secBundalScreen.add(
               BundalScreen(
                   decode[0]["Header Item"].toString(),//productCode,
                   decode[0]["ItemCode"].toString(),//itemCode,
                   formatter.toString(),//date,
                   decode[0]["No of Sheets"].toString(),//varible1,
                   "No of Sheets",//varible1Name,
                   decode[0]["Quality"].toString(),//varible2,
                   "Quality",//varible2Name,
                   decode[0]["Density"].toString(),//varible3,
                   "Density",//varible3Name,
                   decode[0]["Length"].toString(),//varible4,
                   "Length",//varible4Name,
                   decode[0]["Width"].toString(),//varible5,
                   "Width",//varible5Name,
                   decode[0]["Thickness"].toString(),//varible6,
                   "Thickness",//varible6Name,
                   decode[0]["Weight"].toString(),//varible7,
                   "Weight",//varible7Name,
                   "",//varible8,
                   "",//varible8Name,
                   "",//varible9,
                   "",// varible9Name,
                   "",// varible10,
                   "",//varible10Name,
                   "",// varible11,
                   "",//varible11Name,
                   decode[0]["StorageBayNo"].toString(),//storagePayNo,
                   decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                   decode[0]["LineID"].toString(),//lineID,
                   decode[0]["Bundle"].toString(),//bundle,
                   0
               ),
             ),


           }
           else if(decode[0]["Header Item"].toString()=="000002"){}
           else if(decode[0]["Header Item"].toString()=="000003"){}
           else if(decode[0]["Header Item"].toString()=="000004"){
                 secBundalScreen.add(
                   BundalScreen(
                       decode[0]["Header Item"].toString(),//productCode,
                       decode[0]["ItemCode"].toString(),//itemCode,
                       formatter.toString(),//date,
                       decode[0]["GSM"].toString(),//varible1,
                       "GSM",//varible1Name,
                       decode[0]["Width"].toString(),//varible2,
                       "Width",//varible2Name,
                       decode[0]["Length"].toString(),//varible3,
                       "Length",//varible3Name,
                       decode[0]["Colour"].toString(),//varible4,
                       "Colour",//varible4Name,
                       decode[0]["Grade"].toString(),//varible5,
                       "Grade",//varible5Name,
                       decode[0]["Lamination"].toString(),//varible6,
                       "Lamination",//varible6Name,
                       decode[0]["Weight"].toString(),//varible7,
                       "Weight",//varible7Name,
                       "",//varible8,
                       "",//varible8Name,
                       "",//varible9,
                       "",// varible9Name,
                       "",// varible10,
                       "",//varible10Name,
                       "",// varible11,
                       "",//varible11Name,
                       decode[0]["StorageBayNo"].toString(),//storagePayNo,
                       decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                       decode[0]["LineID"].toString(),//lineID,
                       decode[0]["Bundle"].toString(),//bundle
                       0
                   ),
                 ),

               }
           else if(decode[0]["Header Item"].toString()=="000005"){
                   secBundalScreen.add(
                     BundalScreen(
                         decode[0]["Header Item"].toString(),//productCode,
                         decode[0]["ItemCode"].toString(),//itemCode,
                         formatter.toString(),//date,
                         decode[0]["Micron"].toString(),//varible1,
                         "Micron",//varible1Name,
                         decode[0]["Width"].toString(),//varible2,
                         "Width",//varible2Name,
                         decode[0]["Length"].toString(),//varible3,
                         "Length",//varible3Name,
                         decode[0]["Colour"].toString(),//varible4,
                         "Colour",//varible4Name,
                         decode[0]["Weight"].toString(),//varible5,
                         "Weight",//varible5Name,
                         "",//varible6,
                         "",//varible6Name,
                         "",//varible7,
                         "",//varible7Name,
                         "",//varible8,
                         "",//varible8Name,
                         "",//varible9,
                         "",// varible9Name,
                         "",// varible10,
                         "",//varible10Name,
                         "",// varible11,
                         "",//varible11Name,
                         decode[0]["StorageBayNo"].toString(),//storagePayNo,
                         decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                         decode[0]["LineID"].toString(),//lineID,
                         decode[0]["Bundle"].toString(),//bundle
                         0
                     ),
                   ),
                 }
           else if(decode[0]["Header Item"].toString()=="000006"){
                     secBundalScreen.add(
                       BundalScreen(
                           decode[0]["Header Item"].toString(),//productCode,
                           decode[0]["ItemCode"].toString(),//itemCode,
                           formatter.toString(),//date,
                           decode[0]["Quality"].toString(),//varible1,
                           "Quality",//varible1Name,
                           decode[0]["Length"].toString(),//varible2,
                           "Length",//varible2Name,
                           decode[0]["Width"].toString(),//varible3,
                           "Width",//varible3Name,
                           decode[0]["Thickness"].toString(),//varible4,
                           "Thickness",//varible4Name,
                           decode[0]["Weight"].toString(),//varible5,
                           "Weight",//varible5Name,
                           "",//varible6,
                           "",//varible6Name,
                           "",//varible7,
                           "",//varible7Name,
                           "",//varible8,
                           "",//varible8Name,
                           "",//varible9,
                           "",// varible9Name,
                           "",// varible10,
                           "",//varible10Name,
                           "",// varible11,
                           "",//varible11Name,
                           decode[0]["StorageBayNo"].toString(),//storagePayNo,
                           decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                           decode[0]["LineID"].toString(),//lineID,
                           decode[0]["Bundle"].toString(),//bundle
                           0
                       ),
                     ),

                   }
           else if(decode[0]["Header Item"].toString()=="000007"){
                       secBundalScreen.add(
                         BundalScreen(
                           decode[0]["Header Item"].toString(),//productCode,
                           decode[0]["ItemCode"].toString(),//itemCode,
                           formatter.toString(),//date,
                           decode[0]["Quality"].toString(),//varible1,
                           "Quality",//varible1Name,
                           decode[0]["Length"].toString(),//varible2,
                           "Length",//varible2Name,
                           decode[0]["Width"].toString(),//varible3,
                           "Width",//varible3Name,
                           decode[0]["Thickness"].toString(),//varible4,
                           "Thickness",//varible4Name,
                           decode[0]["Weight"].toString(),//varible5,
                           "Weight",//varible5Name,
                           "",//varible6,
                           "",//varible6Name,
                           "",//varible7,
                           "",//varible7Name,
                           "",//varible8,
                           "",//varible8Name,
                           "",//varible9,
                           "",// varible9Name,
                           "",// varible10,
                           "",//varible10Name,
                           "",// varible11,
                           "",//varible11Name,
                           decode[0]["StorageBayNo"].toString(),//storagePayNo,
                           decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                           decode[0]["LineID"].toString(),//lineID,
                           decode[0]["Bundle"].toString(),//bundle
                           0,
                         ),
                       ),

                     }
           else if(decode[0]["Header Item"].toString()=="000008"){
                         secBundalScreen.add(
                           BundalScreen(
                             decode[0]["Header Item"].toString(),//productCode,
                             decode[0]["ItemCode"].toString(),//itemCode,
                             formatter.toString(),//date,
                             decode[0]["Quality"].toString(),//varible1,
                             "Quality",//varible1Name,
                             decode[0]["Length"].toString(),//varible2,
                             "Length",//varible2Name,
                             decode[0]["Width"].toString(),//varible3,
                             "Width",//varible3Name,
                             decode[0]["Thickness"].toString(),//varible4,
                             "Thickness",//varible4Name,
                             decode[0]["Weight"].toString(),//varible5,
                             "Weight",//varible5Name,
                             "",//varible6,
                             "",//varible6Name,
                             "",//varible7,
                             "",//varible7Name,
                             "",//varible8,
                             "",//varible8Name,
                             "",//varible9,
                             "",// varible9Name,
                             "",// varible10,
                             "",//varible10Name,
                             "",// varible11,
                             "",//varible11Name,
                             decode[0]["StorageBayNo"].toString(),//storagePayNo,
                             decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                             decode[0]["LineID"].toString(),//lineID,
                             decode[0]["Bundle"].toString(),//bundle
                             0,
                           ),
                         ),

                       }
           else if(decode[0]["Header Item"].toString()=="000009"){
                           secBundalScreen.add(
                             BundalScreen(
                               decode[0]["Header Item"].toString(),//productCode,
                               decode[0]["ItemCode"].toString(),//itemCode,
                               formatter.toString(),//date,
                               decode[0]["Quality"].toString(),//varible1,
                               "Quality",//varible1Name,
                               decode[0]["Quantity"].toString(),//varible2,
                               "Quantity",//varible2Name,
                               decode[0]["Weight"].toString(),//varible3,
                               "Weight",//varible3Name,
                               "",//varible4,
                               "",//varible4Name,
                               "",//varible5,
                               "",//varible5Name,
                               "",//varible6,
                               "",//varible6Name,
                               "",//varible7,
                               "",//varible7Name,
                               "",//varible8,
                               "",//varible8Name,
                               "",//varible9,
                               "",// varible9Name,
                               "",// varible10,
                               "",//varible10Name,
                               "",// varible11,
                               "",//varible11Name,
                               decode[0]["StorageBayNo"].toString(),//storagePayNo,
                               decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                               decode[0]["LineID"].toString(),//lineID,
                               decode[0]["Bundle"].toString(),//bundle
                               0,
                             ),
                           ),

                         }
           else if(decode[0]["Header Item"].toString()=="000010"){
                             secBundalScreen.add(
                               BundalScreen(
                                 decode[0]["Header Item"].toString(),//productCode,
                                 decode[0]["ItemCode"].toString(),//itemCode,
                                 formatter.toString(),//date,
                                 decode[0]["Quality"].toString(),//varible1,
                                 "Quality",//varible1Name,
                                 decode[0]["Colour"].toString(),//varible2,
                                 "Colour",//varible2Name,
                                 decode[0]["Quantity"].toString(),//varible3,
                                 "Quantity",//varible3Name,
                                 decode[0]["Weight"].toString(),//varible4,
                                 "Weight",//varible4Name,
                                 "",//varible5,
                                 "",//varible5Name,
                                 "",//varible6,
                                 "",//varible6Name,
                                 "",//varible7,
                                 "",//varible7Name,
                                 "",//varible8,
                                 "",//varible8Name,
                                 "",//varible9,
                                 "",// varible9Name,
                                 "",// varible10,
                                 "",//varible10Name,
                                 "",// varible11,
                                 "",//varible11Name,
                                 decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                 decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                 decode[0]["LineID"].toString(),//lineID,
                                 decode[0]["Bundle"].toString(),//bundle
                                 0,
                               ),
                             ),
                           }
           else if(decode[0]["Header Item"].toString()=="000011"){
                               secBundalScreen.add(
                                 BundalScreen(
                                   decode[0]["Header Item"].toString(),//productCode,
                                   decode[0]["ItemCode"].toString(),//itemCode,
                                   formatter.toString(),//date,
                                   decode[0]["Quality"].toString(),//varible1,
                                   "Quality",//varible1Name,
                                   decode[0]["Quantity"].toString(),//varible2,
                                   "Quantity",//varible2Name,
                                   decode[0]["Weight"].toString(),//varible3,
                                   "Weight",//varible3Name,
                                   "",//varible4,
                                   "",//varible4Name,
                                   "",//varible5,
                                   "",//varible5Name,
                                   "",//varible6,
                                   "",//varible6Name,
                                   "",//varible7,
                                   "",//varible7Name,
                                   "",//varible8,
                                   "",//varible8Name,
                                   "",//varible9,
                                   "",// varible9Name,
                                   "",// varible10,
                                   "",//varible10Name,
                                   "",// varible11,
                                   "",//varible11Name,
                                   decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                   decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                   decode[0]["LineID"].toString(),//lineID,
                                   decode[0]["Bundle"].toString(),//bundle
                                   0,
                                 ),
                               ),

                             }
           else if(decode[0]["Header Item"].toString()=="000012"){
                                 secBundalScreen.add(
                                   BundalScreen(
                                     decode[0]["Header Item"].toString(),//productCode,
                                     decode[0]["ItemCode"].toString(),//itemCode,
                                     formatter.toString(),//date,
                                     decode[0]["Quality"].toString(),//varible1,
                                     "Quality",//varible1Name,
                                     decode[0]["Quantity"].toString(),//varible2,
                                     "Quantity",//varible2Name,
                                     decode[0]["TypeOfCan"].toString(),//varible3,
                                     "TypeOfCan",//varible3Name,
                                     decode[0]["Weight"].toString(),//varible4,
                                     "Weight",//varible4Name,
                                     "",//varible5,
                                     "",//varible5Name,
                                     "",//varible6,
                                     "",//varible6Name,
                                     "",//varible7,
                                     "",//varible7Name,
                                     "",//varible8,
                                     "",//varible8Name,
                                     "",//varible9,
                                     "",// varible9Name,
                                     "",// varible10,
                                     "",//varible10Name,
                                     "",// varible11,
                                     "",//varible11Name,
                                     decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                     decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                     decode[0]["LineID"].toString(),//lineID,
                                     decode[0]["Bundle"].toString(),//bundle
                                     0,
                                   ),
                                 ),
                               }
           else if(decode[0]["Header Item"].toString()=="000013"){
                                   secBundalScreen.add(
                                     BundalScreen(
                                       decode[0]["Header Item"].toString(),//productCode,
                                       decode[0]["ItemCode"].toString(),//itemCode,
                                       formatter.toString(),//date,
                                       decode[0]["Density"].toString(),//varible1,
                                       "Density",//varible1Name,
                                       decode[0]["Quality"].toString(),//varible2,
                                       "Quality",//varible2Name,
                                       decode[0]["Length"].toString(),//varible3,
                                       "Length",//varible3Name,
                                       decode[0]["Width"].toString(),//varible4,
                                       "Width",//varible4Name,
                                       decode[0]["Thickness"].toString(),//varible5,
                                       "Thickness",//varible5Name,
                                       decode[0]["Walling"].toString(),//varible6,
                                       "Walling",//varible6Name,
                                       decode[0]["Hessain"].toString(),//varible7,
                                       "Hessain",//varible7Name,
                                       decode[0]["Quantity"].toString(),//varible8,
                                       "Quantity",//varible8Name,
                                       decode[0]["Weight"].toString(),//varible9,
                                       "Weight",// varible9Name,
                                       "",// varible10,
                                       "",//varible10Name,
                                       "",// varible11,
                                       "",//varible11Name,
                                       decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                       decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                       decode[0]["LineID"].toString(),//lineID,
                                       decode[0]["Bundle"].toString(),//bundle
                                       0,
                                     ),
                                   ),
                                 }
           else if(decode[0]["Header Item"].toString()=="000014"){
                                     secBundalScreen.add(
                                       BundalScreen(
                                         decode[0]["Header Item"].toString(),//productCode,
                                         decode[0]["ItemCode"].toString(),//itemCode,
                                         formatter.toString(),//date,
                                         decode[0]["Density"].toString(),//varible1,
                                         "Density",//varible1Name,
                                         decode[0]["Quality"].toString(),//varible2,
                                         "Quality",//varible2Name,
                                         decode[0]["Length"].toString(),//varible3,
                                         "Length",//varible3Name,
                                         decode[0]["Width"].toString(),//varible4,
                                         "Width",//varible4Name,
                                         decode[0]["Thickness"].toString(),//varible5,
                                         "Thickness",//varible5Name,
                                         decode[0]["Walling"].toString(),//varible6,
                                         "Walling",//varible6Name,
                                         decode[0]["Hessain"].toString(),//varible7,
                                         "Hessain",//varible7Name,
                                         decode[0]["Quantity"].toString(),//varible8,
                                         "Quantity",//varible8Name,
                                         decode[0]["Weight"].toString(),//varible9,
                                         "Weight",// varible9Name,
                                         "",// varible10,
                                         "",//varible10Name,
                                         "",// varible11,
                                         "",//varible11Name,
                                         decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                         decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                         decode[0]["LineID"].toString(),//lineID,
                                         decode[0]["Bundle"].toString(),//bundle
                                         0,
                                       ),
                                     ),
                                   }
           else if(decode[0]["Header Item"].toString()=="000015"){
                                       secBundalScreen.add(
                                         BundalScreen(
                                           decode[0]["Header Item"].toString(),//productCode,
                                           decode[0]["ItemCode"].toString(),//itemCode,
                                           formatter.toString(),//date,
                                           decode[0]["Quality"].toString(),//varible1,
                                           "Quality",//varible1Name,
                                           decode[0]["GSM"].toString(),//varible2,
                                           "GSM",//varible2Name,
                                           decode[0]["Width"].toString(),//varible3,
                                           "Width",//varible3Name,
                                           decode[0]["Length"].toString(),//varible4,
                                           "Length",//varible4Name,
                                           decode[0]["Quantity"].toString(),//varible5,
                                           "Quantity",//varible5Name,
                                           decode[0]["Weight"].toString(),//varible6,
                                           "Weight",//varible6Name,
                                           "",//varible7,
                                           "",//varible7Name,
                                           "",//varible8,
                                           "",//varible8Name,
                                           "",//varible9,
                                           "",// varible9Name,
                                           "",// varible10,
                                           "",//varible10Name,
                                           "",// varible11,
                                           "",//varible11Name,
                                           decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                           decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                           decode[0]["LineID"].toString(),//lineID,
                                           decode[0]["Bundle"].toString(),//bundle
                                           0,
                                         ),
                                       ),
                                     }
           else if(decode[0]["Header Item"].toString()=="000016"){
                                         secBundalScreen.add(
                                           BundalScreen(
                                             decode[0]["Header Item"].toString(),//productCode,
                                             decode[0]["ItemCode"].toString(),//itemCode,
                                             formatter.toString(),//date,
                                             decode[0]["Quality"].toString(),//varible1,
                                             "Quality",//varible1Name,
                                             decode[0]["GSM"].toString(),//varible2,
                                             "GSM",//varible2Name,
                                             decode[0]["Width"].toString(),//varible3,
                                             "Width",//varible3Name,
                                             decode[0]["Length"].toString(),//varible4,
                                             "Length",//varible4Name,
                                             decode[0]["Quantity"].toString(),//varible5,
                                             "Quantity",//varible5Name,
                                             decode[0]["Weight"].toString(),//varible6,
                                             "Weight",//varible6Name,
                                             "",//varible7,
                                             "",//varible7Name,
                                             "",//varible8,
                                             "",//varible8Name,
                                             "",//varible9,
                                             "",// varible9Name,
                                             "",// varible10,
                                             "",//varible10Name,
                                             "",// varible11,
                                             "",//varible11Name,
                                             decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                             decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                             decode[0]["LineID"].toString(),//lineID,
                                             decode[0]["Bundle"].toString(),//bundle
                                             0,
                                           ),
                                         ),
                                       }
           else if(decode[0]["Header Item"].toString()=="000017"){

                                           secBundalScreen.add(
                                             BundalScreen(
                                               decode[0]["Header Item"].toString(),//productCode,
                                               decode[0]["ItemCode"].toString(),//itemCode,
                                               formatter.toString(),//date,
                                               decode[0]["Quality"].toString(),//varible1,
                                               "Quality",//varible1Name,
                                               decode[0]["Length"].toString(),//varible2,
                                               "Length",//varible2Name,
                                               decode[0]["Width"].toString(),//varible3,
                                               "Width",//varible3Name,
                                               decode[0]["PVCpillow"].toString(),//varible4,
                                               "PVCpillow",//varible4Name,
                                               decode[0]["PillowCover"].toString(),//varible5,
                                               "PillowCover",//varible5Name,
                                               decode[0]["Weight"].toString(),//varible6,
                                               "Weight",//varible6Name,
                                               "",//varible7,
                                               "",//varible7Name,
                                               "",//varible8,
                                               "",//varible8Name,
                                               "",//varible9,
                                               "",// varible9Name,
                                               "",// varible10,
                                               "",//varible10Name,
                                               "",// varible11,
                                               "",//varible11Name,
                                               decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                               decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                               decode[0]["LineID"].toString(),//lineID,
                                               decode[0]["Bundle"].toString(),//bundle
                                               0,
                                             ),
                                           ),

                                         }
           else if(decode[0]["Header Item"].toString()=="000018"){}
           else if(decode[0]["Header Item"].toString()=="000019"){}
           else if(decode[0]["Header Item"].toString()=="000020"){}
           else if(decode[0]["Header Item"].toString()=="000021"){
                                                   secBundalScreen.add(
                                                     BundalScreen(
                                                       decode[0]["Header Item"].toString(),//productCode,
                                                       decode[0]["ItemCode"].toString(),//itemCode,
                                                       formatter.toString(),//date,
                                                       decode[0]["Quality"].toString(),//varible1,
                                                       "Quality",//varible1Name,
                                                       decode[0]["Length"].toString(),//varible2,
                                                       "Length",//varible2Name,
                                                       decode[0]["Width"].toString(),//varible3,
                                                       "Width",//varible3Name,
                                                       decode[0]["Thickness"].toString(),//varible4,
                                                       "Thickness",//varible4Name,
                                                       decode[0]["MRP"].toString(),//varible5,
                                                       "MRP",//varible5Name,
                                                       decode[0]["Weight"].toString(),//varible6,
                                                       "Weight",//varible6Name,
                                                       "",//varible7,
                                                       "",//varible7Name,
                                                       "",//varible8,
                                                       "",//varible8Name,
                                                       "",//varible9,
                                                       "",// varible9Name,
                                                       "",// varible10,
                                                       "",//varible10Name,
                                                       "",// varible11,
                                                       "",//varible11Name,
                                                       decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                                       decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                                       decode[0]["LineID"].toString(),//lineID,
                                                       decode[0]["Bundle"].toString(),//bundle
                                                       0,
                                                     ),
                                                   ),
                                                 }
           else if(decode[0]["Header Item"].toString()=="000022"){
                                                     secBundalScreen.add(
                                                       BundalScreen(
                                                         decode[0]["Header Item"].toString(),//productCode,
                                                         decode[0]["ItemCode"].toString(),//itemCode,
                                                         formatter.toString(),//date,
                                                         decode[0]["Quality"].toString(),//varible1,
                                                         "Quality",//varible1Name,
                                                         decode[0]["Length"].toString(),//varible2,
                                                         "Length",//varible2Name,
                                                         decode[0]["Width"].toString(),//varible3,
                                                         "Width",//varible3Name,
                                                         decode[0]["Thickness"].toString(),//varible4,
                                                         "Thickness",//varible4Name,
                                                         decode[0]["MRP"].toString(),//varible5,
                                                         "MRP",//varible5Name,
                                                         decode[0]["Weight"].toString(),//varible6,
                                                         "Weight",//varible6Name,
                                                         "",//varible7,
                                                         "",//varible7Name,
                                                         "",//varible8,
                                                         "",//varible8Name,
                                                         "",//varible9,
                                                         "",// varible9Name,
                                                         "",// varible10,
                                                         "",//varible10Name,
                                                         "",// varible11,
                                                         "",//varible11Name,
                                                         decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                                         decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                                         decode[0]["LineID"].toString(),//lineID,
                                                         decode[0]["Bundle"].toString(),//bundle
                                                         0,
                                                       ),
                                                     ),
                                                   }
           else if(decode[0]["Header Item"].toString()=="000023"){
                                                       secBundalScreen.add(
                                                         BundalScreen(
                                                           decode[0]["Header Item"].toString(),//productCode,
                                                           decode[0]["ItemCode"].toString(),//itemCode,
                                                           formatter.toString(),//date,
                                                           decode[0]["Quality"].toString(),//varible1,
                                                           "Quality",//varible1Name,
                                                           decode[0]["Density"].toString(),//varible2,
                                                           "Density",//varible2Name,
                                                           decode[0]["Length"].toString(),//varible3,
                                                           "Length",//varible3Name,
                                                           decode[0]["Width"].toString(),//varible4,
                                                           "Width",//varible4Name,
                                                           decode[0]["Weight"].toString(),//varible5,
                                                           "Weight",//varible5Name,
                                                           "",//varible6,
                                                           "",//varible6Name,
                                                           "",//varible7,
                                                           "",//varible7Name,
                                                           "",//varible8,
                                                           "",//varible8Name,
                                                           "",//varible9,
                                                           "",// varible9Name,
                                                           "",// varible10,
                                                           "",//varible10Name,
                                                           "",// varible11,
                                                           "",//varible11Name,
                                                           decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                                           decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                                           decode[0]["LineID"].toString(),//lineID,
                                                           decode[0]["Bundle"].toString(),//bundle
                                                           0,
                                                         ),
                                                       ),
                                                     }
           else if(decode[0]["Header Item"].toString()=="000024"){
                                                         secBundalScreen.add(
                                                           BundalScreen(
                                                             decode[0]["Header Item"].toString(),//productCode,
                                                             decode[0]["ItemCode"].toString(),//itemCode,
                                                             formatter.toString(),//date,
                                                             decode[0]["Quality"].toString(),//varible1,
                                                             "Quality",//varible1Name,
                                                             decode[0]["Density"].toString(),//varible2,
                                                             "Density",//varible2Name,
                                                             decode[0]["Width"].toString(),//varible3,
                                                             "Width",//varible3Name,
                                                             decode[0]["Weight"].toString(),//varible4,
                                                             "Weight",//varible4Name,
                                                             "",//varible5,
                                                             "",//varible5Name,
                                                             "",//varible6,
                                                             "",//varible6Name,
                                                             "",//varible7,
                                                             "",//varible7Name,
                                                             "",//varible8,
                                                             "",//varible8Name,
                                                             "",//varible9,
                                                             "",// varible9Name,
                                                             "",// varible10,
                                                             "",//varible10Name,
                                                             "",// varible11,
                                                             "",//varible11Name,
                                                             decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                                             decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                                             decode[0]["LineID"].toString(),//lineID,
                                                             decode[0]["Bundle"].toString(),//bundle
                                                             0,
                                                           ),
                                                         ),
                                                       }
           else if(decode[0]["Header Item"].toString()=="000025"){}
           else if(decode[0]["Header Item"].toString()=="000026"){}
           else if(decode[0]["Header Item"].toString()=="000027"){
                                                               secBundalScreen.add(
                                                                 BundalScreen(
                                                                   decode[0]["Header Item"].toString(),//productCode,
                                                                   decode[0]["ItemCode"].toString(),//itemCode,
                                                                   formatter.toString(),//date,
                                                                   decode[0]["Thickness"].toString(),//varible1,
                                                                   "Thickness",//varible1Name,
                                                                   decode[0]["Height"].toString(),//varible2,
                                                                   "Height",//varible2Name,
                                                                   decode[0]["Turns"].toString(),//varible3,
                                                                   "Turns",//varible3Name,
                                                                   decode[0]["CoilStructure"].toString(),//varible4,
                                                                   "CoilStructure",//varible4Name,
                                                                   decode[0]["Length"].toString(),//varible5,
                                                                   "Length",//varible5Name,
                                                                   decode[0]["Width"].toString(),//varible6,
                                                                   "Width",//varible6Name,
                                                                   decode[0]["Weight"].toString(),//varible7,
                                                                   "Weight",//varible7Name,
                                                                   "",//varible8,
                                                                   "",//varible8Name,
                                                                   "",//varible9,
                                                                   "",// varible9Name,
                                                                   "",// varible10,
                                                                   "",//varible10Name,
                                                                   "",// varible11,
                                                                   "",//varible11Name,
                                                                   decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                                                   decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                                                   decode[0]["LineID"].toString(),//lineID,
                                                                   decode[0]["Bundle"].toString(),//bundle
                                                                   0,
                                                                 ),
                                                               ),
                                                             }
           else if(decode[0]["Header Item"].toString()=="000028"){
                                                                 secBundalScreen.add(
                                                                   BundalScreen(
                                                                     decode[0]["Header Item"].toString(),//productCode,
                                                                     decode[0]["ItemCode"].toString(),//itemCode,
                                                                     formatter.toString(),//date,
                                                                     decode[0]["Thickness"].toString(),//varible1,
                                                                     "Thickness",//varible1Name,
                                                                     decode[0]["Height"].toString(),//varible2,
                                                                     "Height",//varible2Name,
                                                                     decode[0]["Turns"].toString(),//varible3,
                                                                     "Turns",//varible3Name,
                                                                     decode[0]["CoilStructure"].toString(),//varible4,
                                                                     "CoilStructure",//varible4Name,
                                                                     decode[0]["Length"].toString(),//varible5,
                                                                     "Length",//varible5Name,
                                                                     decode[0]["Width"].toString(),//varible6,
                                                                     "Width",//varible6Name,
                                                                     decode[0]["Weight"].toString(),//varible7,
                                                                     "Weight",//varible7Name,
                                                                     "",//varible8,
                                                                     "",//varible8Name,
                                                                     "",//varible9,
                                                                     "",// varible9Name,
                                                                     "",// varible10,
                                                                     "",//varible10Name,
                                                                     "",// varible11,
                                                                     "",//varible11Name,
                                                                     decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                                                     decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                                                     decode[0]["LineID"].toString(),//lineID,
                                                                     decode[0]["Bundle"].toString(),//bundle
                                                                     0,
                                                                   ),
                                                                 ),
                                                               }
           else if(decode[0]["Header Item"].toString()=="000029"){
                                                                   secBundalScreen.add(
                                                                     BundalScreen(
                                                                       decode[0]["Header Item"].toString(),//productCode,
                                                                       decode[0]["ItemCode"].toString(),//itemCode,
                                                                       formatter.toString(),//date,
                                                                       decode[0]["Thickness"].toString(),//varible1,
                                                                       "Thickness",//varible1Name,
                                                                       decode[0]["Height"].toString(),//varible2,
                                                                       "Height",//varible2Name,
                                                                       decode[0]["Turns"].toString(),//varible3,
                                                                       "Turns",//varible3Name,
                                                                       decode[0]["CoilStructure"].toString(),//varible4,
                                                                       "CoilStructure",//varible4Name,
                                                                       decode[0]["Length"].toString(),//varible5,
                                                                       "Length",//varible5Name,
                                                                       decode[0]["Width"].toString(),//varible6,
                                                                       "Width",//varible6Name,
                                                                       decode[0]["Weight"].toString(),//varible7,
                                                                       "Weight",//varible7Name,
                                                                       "",//varible8,
                                                                       "",//varible8Name,
                                                                       "",//varible9,
                                                                       "",// varible9Name,
                                                                       "",// varible10,
                                                                       "",//varible10Name,
                                                                       "",// varible11,
                                                                       "",//varible11Name,
                                                                       decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                                                       decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                                                       decode[0]["LineID"].toString(),//lineID,
                                                                       decode[0]["Bundle"].toString(),//bundle
                                                                       0,
                                                                     ),
                                                                   ),
                                                                 }
           else if(decode[0]["Header Item"].toString()=="000030"){
                                                                     secBundalScreen.add(
                                                                       BundalScreen(
                                                                         decode[0]["Header Item"].toString(),//productCode,
                                                                         decode[0]["ItemCode"].toString(),//itemCode,
                                                                         formatter.toString(),//date,
                                                                         decode[0]["Thickness"].toString(),//varible1,
                                                                         "Thickness",//varible1Name,
                                                                         decode[0]["Height"].toString(),//varible2,
                                                                         "Height",//varible2Name,
                                                                         decode[0]["Turns"].toString(),//varible3,
                                                                         "Turns",//varible3Name,
                                                                         decode[0]["CoilStructure"].toString(),//varible4,
                                                                         "CoilStructure",//varible4Name,
                                                                         decode[0]["Length"].toString(),//varible5,
                                                                         "Length",//varible5Name,
                                                                         decode[0]["Width"].toString(),//varible6,
                                                                         "Width",//varible6Name,
                                                                         decode[0]["Weight"].toString(),//varible7,
                                                                         "Weight",//varible7Name,
                                                                         "",//varible8,
                                                                         "",//varible8Name,
                                                                         "",//varible9,
                                                                         "",// varible9Name,
                                                                         "",// varible10,
                                                                         "",//varible10Name,
                                                                         "",// varible11,
                                                                         "",//varible11Name,
                                                                         decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                                                         decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                                                         decode[0]["LineID"].toString(),//lineID,
                                                                         decode[0]["Bundle"].toString(),//bundle
                                                                         0,
                                                                       ),
                                                                     ),
                                                                   }
           else if(decode[0]["Header Item"].toString()=="000031"){
                                                                       secBundalScreen.add(
                                                                         BundalScreen(
                                                                           decode[0]["Header Item"].toString(),//productCode,
                                                                           decode[0]["ItemCode"].toString(),//itemCode,
                                                                           formatter.toString(),//date,
                                                                           decode[0]["Thickness"].toString(),//varible1,
                                                                           "Thickness",//varible1Name,
                                                                           decode[0]["Height"].toString(),//varible2,
                                                                           "Height",//varible2Name,
                                                                           decode[0]["Turns"].toString(),//varible3,
                                                                           "Turns",//varible3Name,
                                                                           decode[0]["CoilStructure"].toString(),//varible4,
                                                                           "CoilStructure",//varible4Name,
                                                                           decode[0]["Length"].toString(),//varible5,
                                                                           "Length",//varible5Name,
                                                                           decode[0]["Width"].toString(),//varible6,
                                                                           "Width",//varible6Name,
                                                                           decode[0]["Weight"].toString(),//varible7,
                                                                           "Weight",//varible7Name,
                                                                           "",//varible8,
                                                                           "",//varible8Name,
                                                                           "",//varible9,
                                                                           "",// varible9Name,
                                                                           "",// varible10,
                                                                           "",//varible10Name,
                                                                           "",// varible11,
                                                                           "",//varible11Name,
                                                                           decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                                                           decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                                                           decode[0]["LineID"].toString(),//lineID,
                                                                           decode[0]["Bundle"].toString(),//bundle
                                                                           0,
                                                                         ),
                                                                       ),
                                                                     }
           else if(decode[0]["Header Item"].toString()=="000042"){
                                                                         secBundalScreen.add(
                                                                           BundalScreen(
                                                                             decode[0]["Header Item"].toString(),//productCode,
                                                                             decode[0]["ItemCode"].toString(),//itemCode,
                                                                             formatter.toString(),//date,
                                                                             decode[0]["Quality"].toString(),//varible1,
                                                                             "Quality",//varible1Name,
                                                                             decode[0]["Emboss"].toString(),//varible2,
                                                                             "Emboss",//varible2Name,
                                                                             decode[0]["Cloth"].toString(),//varible3,
                                                                             "Cloth",//varible3Name,
                                                                             decode[0]["Finish"].toString(),//varible4,
                                                                             "Finish",//varible4Name,
                                                                             decode[0]["Color"].toString(),//varible5,
                                                                             "Color",//varible5Name,
                                                                             decode[0]["Thickness"].toString(),//varible6,
                                                                             "Thickness",//varible6Name,
                                                                             decode[0]["Tone"].toString(),//varible7,
                                                                             "Tone",//varible7Name,
                                                                             decode[0]["Width"].toString(),//varible8,
                                                                             "Width",//varible8Name,
                                                                             decode[0]["Quantity"].toString(),//varible9,
                                                                             "Quantity",// varible9Name,
                                                                             decode[0]["Grade"].toString(),// varible10,
                                                                             "Grade",//varible10Name,
                                                                             decode[0]["Weight"].toString(),// varible11,
                                                                             "Weight",//varible11Name,
                                                                             decode[0]["StorageBayNo"].toString(),//storagePayNo,
                                                                             decode[0]["QRDocEntry"].toString(),//qrdocEntry,
                                                                             decode[0]["LineID"].toString(),//lineID,
                                                                             decode[0]["Bundle"].toString(),//bundle
                                                                             0,
                                                                           ),
                                                                         ),
                                                                       },
           Utility.closeLoader(),
           update(),
         }else{
           Utility.closeLoader(),
           update(),
           Utility.showDialaogboxWarning(Get.context, "This ItemCode Already Added..", "Warning")

         },



       }else{
         Utility.closeLoader(),
         update(),
       }
     });



    update();
  }

  getItemCode(soNo, docEntry, userId, cardCode, status,index){
    secBundalScreen[index].itemCode="";
        api_call.getAllMaster(4, soNo, docEntry, userId, cardCode, status, true).then((value) => {
      if(value.statusCode==200){
        Utility.closeLoader(),
        update(),
        secBundalScreen[index].itemCode= jsonDecode(value.body)["result"][0]["ItemCode"].toString(),
        //jsonDecode(value.body)["result"][0]["ItemName"].toString(),
        log(value.body),

        update(),

      }else {
        Utility.closeLoader(),
        update(),
      }
    });
  }

  getItemCode1(productCode, quality, emboss, finish, grade,clothrex,thicks,color,width,index){
    secBundalScreen[index].itemCode="";
    api_call.getItemMaster(1, productCode, quality, emboss, finish, grade, clothrex, thicks, color,width, true).then((value) => {
      if(value.statusCode==200){
        Utility.closeLoader(),
        update(),
        secBundalScreen[index].itemCode= jsonDecode(value.body)["result"][0]["ItemCode"].toString(),
        //jsonDecode(value.body)["result"][0]["ItemName"].toString(),
        log(value.body),

        update(),

      }else {
        Utility.closeLoader(),
        update(),
      }
    });
  }



  showQty(int index, String tittle, fromId) {
    var typeController = TextEditingController();
    Get.dialog(
      AlertDialog(
        content: SizedBox(
            width: double.minPositive,
            height: 100,
            child: Column(
              children: [
                TextField(
                  controller: typeController,
                  keyboardType: fromId == 1
                      ? TextInputType.number
                      : TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: tittle,
                    border: InputBorder.none,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {
                      if (fromId == 1) {
                        //secBundalScreen[index].Weight = double.parse(typeController.text.toString());
                      }
                      update();

                      Get.back();
                    }, child: const Text("Ok")),
                    const SizedBox(width: 5,),
                    TextButton(
                        onPressed: () {
                          Get.back();
                          update();
                        },
                        child: const Text("Cancel")),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }

  screenListRemove(int index) {
    secBundalScreen.removeAt(index);
    update();
  }

  postSave() {
    Utility.showLoader();
    update();

    for(int k=0;k<secBundalScreen.length;k++){
      api_call.insertPicking(
          1,
          0,
          secBundalScreen[k].productCode,// productCode,
          secBundalScreen[k].itemCode,//itemCode,
          secBundalScreen[k].varible1,//varible1,
          secBundalScreen[k].varible2,//varible2,
          secBundalScreen[k].varible3,//varible3,
          secBundalScreen[k].varible4,//varible4,
          secBundalScreen[k].varible5,//varible5,
          secBundalScreen[k].varible6,//varible6,
          secBundalScreen[k].varible7,//varible7,
          secBundalScreen[k].varible8,//varible8,
          secBundalScreen[k].varible9,//varible9,
          secBundalScreen[k].varible10,//varible10,
          secBundalScreen[k].varible11,//varible11,
          secBundalScreen[k].storagePayNo,//storagePayNo,
          secBundalScreen[k].qrdocEntry,//qrdocEntry,
          secBundalScreen[k].lineID,//lineID,
          secBundalScreen[k].bundle,//bundle,
          false).then((value) => {

      });
    }
    Utility.closeLoader();
    update();
    Utility.showDialaogboxSaved(Get.context, "Saved Successfully..", "Saved");


  }

  void pageRefresh(){

    Get.delete<packingScreenController>();
    Get.put(packingScreenController());
    Get.back();
    Get.to(()=>const packingScreenPage(),arguments: <String,dynamic>{});
    Get.back();
    update();
  }

  myListselect(int index) {
    secBundalScreen[index].selected=1;
    update();
   }

  selectDelete() {
    for(int i=0;i<secBundalScreen.length;i++){
    if(secBundalScreen[i].selected==1){
      secBundalScreen.removeAt(i);
    }}
    update();
   }

  getData(index) {
    //print(secBundalScreen[index].productCode);
    if(secBundalScreen[index].productCode=="000001") {
      getItemCode(
         "000001",
         "docEntry",
         secBundalScreen[index].varible2,//userId, Quality
         secBundalScreen[index].varible3, // CradCode, Density
         "",index);
    }
    else if(secBundalScreen[index].productCode=="000004") {
      getItemCode(
          "000004",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Grade
          secBundalScreen[index].varible3, // CradCode, Density
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000005") {
      getItemCode(
          "000005",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Micron
          secBundalScreen[index].varible3, // CradCode, Density
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000006") {
      getItemCode(
          "000006",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Quality
          secBundalScreen[index].varible4, // CradCode, thickness
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000007") {
      getItemCode(
          "000007",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Quality
          secBundalScreen[index].varible4, // CradCode, thickness
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000008") {
      getItemCode(
          "000008",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Quality
          secBundalScreen[index].varible4, // CradCode, thickness
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000009") {
      getItemCode(
          "000009",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Quality
          secBundalScreen[index].varible4, // CradCode, thickness
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000010") {
      getItemCode(
          "000010",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Quality
          secBundalScreen[index].varible4, // CradCode, thickness
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000011") {
      getItemCode(
          "000011",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Quality
          secBundalScreen[index].varible4, // CradCode, thickness
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000012") {
      getItemCode(
          "000012",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Quality
          secBundalScreen[index].varible3, // CradCode, typeofcan
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000013") {
      getItemCode(
          "000013",
          secBundalScreen[index].varible1,
          secBundalScreen[index].varible2,//userId, Quality
          secBundalScreen[index].varible6, // CradCode, typeofcan
          secBundalScreen[index].varible7,index);
    }
    else if(secBundalScreen[index].productCode=="000014") {
      getItemCode(
          "000014",
          secBundalScreen[index].varible1,
          secBundalScreen[index].varible2,//userId, Quality
          secBundalScreen[index].varible6, // CradCode, typeofcan
          secBundalScreen[index].varible7,index);
    }
    else if(secBundalScreen[index].productCode=="000015") {
      getItemCode(
          "000015",
          secBundalScreen[index].varible1,
          secBundalScreen[index].varible2,//userId, Quality
          secBundalScreen[index].varible6, // CradCode, typeofcan
          secBundalScreen[index].varible7,index);
    }
    else if(secBundalScreen[index].productCode=="000016") {
      getItemCode(
          "000016",
          secBundalScreen[index].varible1,
          secBundalScreen[index].varible2,//userId, Quality
          secBundalScreen[index].varible6, // CradCode, typeofcan
          secBundalScreen[index].varible7,index);
    }
    else if(secBundalScreen[index].productCode=="000017") {
      getItemCode(
          "000017",
          secBundalScreen[index].varible1,
          secBundalScreen[index].varible4,//userId, Quality
          secBundalScreen[index].varible5, // CradCode, typeofcan
          secBundalScreen[index].varible7,index);
    }
    else if(secBundalScreen[index].productCode=="000021") {
      getItemCode(
          "000021",
          secBundalScreen[index].varible1,//"docEntry",Quality
          secBundalScreen[index].varible2,//userId, lenght
          secBundalScreen[index].varible3, // CradCode, widht
          secBundalScreen[index].varible4, // status ,thikness
          index);
    }
    else if(secBundalScreen[index].productCode=="000022") {
      getItemCode(
          "000022",
          secBundalScreen[index].varible1,//"docEntry",Quality
          secBundalScreen[index].varible2,//userId, lenght
          secBundalScreen[index].varible3, // CradCode, widht
          secBundalScreen[index].varible4, // status ,thikness
          index);
    }
    else if(secBundalScreen[index].productCode=="000023" || secBundalScreen[index].productCode=="000024") {
      getItemCode(
          secBundalScreen[index].productCode,
          secBundalScreen[index].varible1,//"docEntry",Quality
          secBundalScreen[index].varible1,//userId, lenght
          secBundalScreen[index].varible2, // CradCode, widht
          secBundalScreen[index].varible4, // status ,thikness
          index);
    }
    else if(secBundalScreen[index].productCode=="000027") {
      getItemCode(
          "000027",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Thickness
          secBundalScreen[index].varible2, // CradCode, Height
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000028") {
      getItemCode(
          "000028",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Thickness
          secBundalScreen[index].varible2, // CradCode, Height
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000029") {
      getItemCode(
          "000029",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Thickness
          secBundalScreen[index].varible2, // CradCode, Height
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000030") {
      getItemCode(
          "000030",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Thickness
          secBundalScreen[index].varible2, // CradCode, Height
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000031") {
      getItemCode(
          "000031",
          "docEntry",
          secBundalScreen[index].varible1,//userId, Thickness
          secBundalScreen[index].varible2, // CradCode, Height
          "",index);
    }
    else if(secBundalScreen[index].productCode=="000042") {
      getItemCode1(
          secBundalScreen[index].productCode,//productCode,
          secBundalScreen[index].varible1,//quality,
          secBundalScreen[index].varible2,//emboss,
          secBundalScreen[index].varible4,//finish,
          secBundalScreen[index].varible10,//grade,
          secBundalScreen[index].varible3,//clothrex,
          secBundalScreen[index].varible6,//thicks,
          secBundalScreen[index].varible5,//color,
          secBundalScreen[index].varible8,//width,
          index);
    }

   }

  showenterinput(productCode,varibleName,int index,setvaribleName) {
    //log("varibleName"+varibleName);
    var typeController = TextEditingController();
    if(varibleName=="No of Sheets"){
      Get.dialog(
        AlertDialog(
          title:  Text("Enter$varibleName"),
          content: SizedBox(
              width: double.minPositive,
              height: 100,
              child: Column(
                children: [
                  TextField(
                    controller: typeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter$varibleName",
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.input,color: Colors.black38,),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = typeController.text;
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = typeController.text;
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = typeController.text;
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = typeController.text;
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = typeController.text;
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = typeController.text;
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = typeController.text;
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = typeController.text;
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = typeController.text;
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = typeController.text;
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }

                        Get.back();
                        update();
                      }, child: const Text("Ok")),
                      const SizedBox(width: 5,),
                      TextButton(
                          onPressed: (){
                            Get.back();
                            update();
                          },
                          child: const Text("Cancel")),
                    ],
                  )
                ],
              )
          ),
        ),
      );
    }
    else if(varibleName=="Quality"){
      secQualityModelList.clear();
      api_call.getgetAllList(1, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
                QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){

                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }

                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Density"){
      secQualityModelList.clear();
      api_call.getgetAllList(2, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){

                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Length"){
      secQualityModelList.clear();
      api_call.getgetAllList(3, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
     }
    else if(varibleName=="Width"){
      secQualityModelList.clear();
      api_call.getgetAllList(4, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Thickness"){
      secQualityModelList.clear();
      api_call.getgetAllList(5, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Weight"){
      Get.dialog(
        AlertDialog(
          title:  Text("Enter$varibleName"),
          content: SizedBox(
              width: double.minPositive,
              height: 100,
              child: Column(
                children: [
                  TextField(
                    controller: typeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter$varibleName",
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.input,color: Colors.black38,),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                       // secBundalScreen[index].varible7 = typeController.text;
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = typeController.text;
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = typeController.text;
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = typeController.text;
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = typeController.text;
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = typeController.text;
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = typeController.text;
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = typeController.text;
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = typeController.text;
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = typeController.text;
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = typeController.text;
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }
                        Get.back();
                        update();
                      }, child: const Text("Ok")),
                      const SizedBox(width: 5,),
                      TextButton(
                          onPressed: (){
                            Get.back();
                            update();
                          },
                          child: const Text("Cancel")),
                    ],
                  )
                ],
              )
          ),
        ),
      );

    }
    else if(varibleName=="GSM"){
      secQualityModelList.clear();
      update();
      api_call.getgetAllList(6, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName =="Colour"){
      secQualityModelList.clear();
      api_call.getgetAllList(7, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName =="Color"){
      secQualityModelList.clear();
      api_call.getgetAllList(7, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName =="Grade"){
      secQualityModelList.clear();
      api_call.getgetAllList(8, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName =="Lamination"){
      secQualityModelList.clear();
      api_call.getgetAllList(9, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="StorageBayNo"){
      api_call.getgetAllList(10, productCode, "type", true).then((value) => {
        if(value.statusCode==200){

          rawWarehouseModel = WarehouseModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawWarehouseModel.result!.length;j++){
            secWhsList.add(WhsList(
              rawWarehouseModel.result![j].whsCode.toString(),
              rawWarehouseModel.result![j].whsName.toString(),
            )),
          },
          Utility.closeLoader(),
          update(),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secWhsList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        secBundalScreen[index].storagePayNo = secWhsList[index1].whsCode.toString();
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secWhsList[index1].whsName,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
          log(value.body),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Micron"){
      secQualityModelList.clear();
      update();
      api_call.getgetAllList(11, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="TypeOfCan"){
      secQualityModelList.clear();
      update();
      api_call.getgetAllList(12, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Quantity"){
      Get.dialog(
        AlertDialog(
          title:  Text("Enter$varibleName"),
          content: SizedBox(
              width: double.minPositive,
              height: 100,
              child: Column(
                children: [
                  TextField(
                    controller: typeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter$varibleName",
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.input,color: Colors.black38,),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = typeController.text;
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = typeController.text;
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = typeController.text;
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = typeController.text;
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = typeController.text;
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = typeController.text;
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = typeController.text;
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = typeController.text;
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = typeController.text;
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = typeController.text;
                        }

                        Get.back();
                        update();
                      }, child: const Text("Ok")),
                      const SizedBox(width: 5,),
                      TextButton(
                          onPressed: (){
                            Get.back();
                            update();
                          },
                          child: const Text("Cancel")),
                    ],
                  )
                ],
              )
          ),
        ),
      );
    }
    else if(varibleName=="Height"){
      secQualityModelList.clear();
      api_call.getgetAllList(13, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Walling"){
      secQualityModelList.clear();
      api_call.getgetAllList(15, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Hessain"){
      secQualityModelList.clear();
      api_call.getgetAllList(16, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="PVCpillow"){
      secQualityModelList.clear();
      api_call.getgetAllList(17, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="PillowCover"){
      secQualityModelList.clear();
      api_call.getgetAllList(18, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){
                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }
                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Emboss"){
      secQualityModelList.clear();
      api_call.getgetAllList(19, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){

                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }

                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Cloth"){
      secQualityModelList.clear();
      api_call.getgetAllList(20, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){

                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }

                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Finish"){
      secQualityModelList.clear();
      api_call.getgetAllList(21, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){

                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }

                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }
    else if(varibleName=="Tone"){
      secQualityModelList.clear();
      api_call.getgetAllList(22, productCode, "type", true).then((value) => {
        if(value.statusCode==200){
          rawQualityModel = QualityModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawQualityModel.result!.length;j++){
            secQualityModelList.add(
              QualityModelList(rawQualityModel.result![j].uSpcation.toString()),
            )
          },
          Utility.closeLoader(),
          log(value.body),
          update(),
          //print(secQualityModelList.length),
          Get.dialog(AlertDialog(
            title:  Text("choose $varibleName"),
            content: SizedBox(
                width: double.minPositive,
                //height: double.maPositive,
                child: ListView.builder(
                  itemCount: secQualityModelList.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return InkWell(
                      onTap: (){

                        if(setvaribleName=="varible1Name"){
                          secBundalScreen[index].varible1 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible2Name"){
                          secBundalScreen[index].varible2 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible3Name"){
                          secBundalScreen[index].varible3 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible4Name"){
                          secBundalScreen[index].varible4 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible5Name"){
                          secBundalScreen[index].varible5 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible6Name"){
                          secBundalScreen[index].varible6 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible7Name"){
                          secBundalScreen[index].varible7 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible8Name"){
                          secBundalScreen[index].varible8 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible9Name"){
                          secBundalScreen[index].varible9 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible10Name"){
                          secBundalScreen[index].varible10 = secQualityModelList[index1].uSpcation.toString();
                        }else if(setvaribleName=="varible11Name"){
                          secBundalScreen[index].varible11 = typeController.text;
                        }

                        Get.back();
                        update();

                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: Text(secQualityModelList[index1].uSpcation,style: const TextStyle(color: Colors.black87),),
                      ),
                    );
                  },
                )
            ),
          ),),
        }else{
          Utility.closeLoader(),
          update(),
        }
      });
    }

   }
}

class BundalScreen{
  var productCode;
  var itemCode;
  var date;

  var varible1;
  var varible1Name;
  var varible2;
  var varible2Name;
  var varible3;
  var varible3Name;
  var varible4;
  var varible4Name;
  var varible5;
  var varible5Name;
  var varible6;
  var varible6Name;
  var varible7;
  var varible7Name;
  var varible8;
  var varible8Name;
  var varible9;
  var varible9Name;
  var varible10;
  var varible10Name;
  var varible11;
  var varible11Name;

  var storagePayNo;
  var qrdocEntry;
  var lineID;
  var bundle;
  int? selected;


  BundalScreen(
      this.productCode,
      this.itemCode,this.date,
      this.varible1,
      this.varible1Name,
      this.varible2,
      this.varible2Name,
      this.varible3,
      this.varible3Name,
      this.varible4,
      this.varible4Name,
      this.varible5,
      this.varible5Name,
      this.varible6,
      this.varible6Name,
      this.varible7,
      this.varible7Name,
      this.varible8,
      this.varible8Name,
      this.varible9,
      this.varible9Name,
      this.varible10,
      this.varible10Name,
      this.varible11,
      this.varible11Name,
      this.storagePayNo,this.qrdocEntry,this.lineID,this.bundle,this.selected);
}

class ScenList {
  String? saleOrderNo;
  String? date;
  String? quality;
  String? length;
  String? width;
  String? thickness;
  String? noOfSheets;
  String? weight;
  String? bundles;

  ScenList(
      this.saleOrderNo,
        this.date,
        this.quality,
        this.length,
        this.width,
        this.thickness,
        this.noOfSheets,
        this.weight,
        this.bundles);

  ScenList.fromJson(Map<String, dynamic> json) {
    saleOrderNo = json['Sale Order No'];
    date = json['Date'];
    quality = json['Quality'];
    length = json['Length'];
    width = json['Width'];
    thickness = json['Thickness'];
    noOfSheets = json['No of Sheets'];
    weight = json['Weight'];
    bundles = json['Bundles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Sale Order No'] = saleOrderNo;
    data['Date'] = date;
    data['Quality'] = quality;
    data['Length'] = length;
    data['Width'] = width;
    data['Thickness'] = thickness;
    data['No of Sheets'] = noOfSheets;
    data['Weight'] = weight;
    data['Bundles'] = bundles;
    return data;
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

class QualityModelList{
  String uSpcation;
  QualityModelList(this.uSpcation);
}

class WhsList {
  String whsCode;
  String whsName;
  WhsList(this.whsCode,this.whsName);
}

class QrScan {
  String? headerItem;
  String? qRDocEntry;
  String? lineID;
  String? bundle;

  QrScan({this.headerItem, this.qRDocEntry, this.lineID, this.bundle});

  QrScan.fromJson(Map<String, dynamic> json) {
    headerItem = json['Header Item'];
    qRDocEntry = json[' QRDocEntry'];
    lineID = json[' LineID'];
    bundle = json[' Bundle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Header Item'] = headerItem;
    data[' QRDocEntry'] = qRDocEntry;
    data[' LineID'] = lineID;
    data[' Bundle'] = bundle;
    return data;
  }
}




