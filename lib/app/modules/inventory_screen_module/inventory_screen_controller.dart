import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pl_groups/app/data/model/WhsCodeModel.dart';
import 'package:pl_groups/app/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pl_groups/app/data/repository/api_call.dart';

class InventoryScreenController extends GetxController{
  var formatter;

  var orderType = TextEditingController();
  var orderTypeCode = TextEditingController();
  var cardName  = TextEditingController();
  var cardCode = TextEditingController();
  var branchName = TextEditingController();
  var productCode = TextEditingController();
  var sessionBranchCode ='';
  var sessionbranchSubCode ='';
  var sessionCode ='';
  var sessionDBName ='';
  var sessionUserName ='';
  var sessionPassword ='';

  String? whsCode = '';
  var whsName = TextEditingController();


  late ScanInventoryModel rawScanInventoryModel;

  List<ScanInventoryModel> secScanInventoryModel=[];

  List<WhsCode>secWhsCode=[];
  late WhsCodeModel rawWhsCodeModel;




  @override
  void onInit() {
    super.onInit();
    //print("dispatch scrn inside oninit");

    formatter = DateFormat('yyyyMMdd').format(DateTime.now());

    update();
    getStringValuesSF();
  }
  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    branchName.text  =   prefs.getString('branchName').toString();
    sessionBranchCode = prefs.getString('branchCode').toString();
    sessionbranchSubCode = prefs.getString('branchSubCode').toString();
    sessionCode = prefs.getString('EmpNo').toString();
    sessionDBName = prefs.getString('DBName').toString();
    sessionUserName = prefs.getString('UserName').toString();
    sessionPassword = prefs.getString('Password').toString();
    getWhsCode();
  }

  Future<void> scanBarcode() async {

    if(whsName.text.isEmpty){
      Utility.showDialaogboxWarning(Get.context, "Choose To WhsCode", "Warrning");
    }

    else {
      String barcodeScanRes = '';
      int count = 0;
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.QR);
        print("Scan" + barcodeScanRes);

        update();
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }


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
      rawScanInventoryModel = ScanInventoryModel.fromJson(newdecode);

      for (int i = 0; i < secScanInventoryModel.length; i++) {
        if (secScanInventoryModel[i].itemCode == rawScanInventoryModel.itemCode) {
          count++;
        }
      }

      secScanInventoryModel.add(
        ScanInventoryModel(
          rawScanInventoryModel.itemCode,
          rawScanInventoryModel.quantity,
          rawScanInventoryModel.batch,
          rawScanInventoryModel.whsCode,
          rawScanInventoryModel.gRPODocNum,
          whsCode,
        ),
      );
    }
    update();
  }

  void removeScreen(int lastIndexOf) {
    secScanInventoryModel.removeAt(lastIndexOf);
    update();
  }


  getWhsCode(){
    api_call.getAllMaster(6, "soNo", "docEntry", sessionCode, cardCode.text, sessionBranchCode, true).then((value) => {
      if(value.statusCode == 200){
        print(value.body),
        rawWhsCodeModel = WhsCodeModel.fromJson(jsonDecode(value.body)),
        for(int j=0;j<rawWhsCodeModel.result!.length;j++){
          secWhsCode.add(
              WhsCode(
                  rawWhsCodeModel.result![j].whsCode,
                  rawWhsCodeModel.result![j].whsName),
          )
        },
        Utility.closeLoader(),
        update(),

      }else{
        Utility.closeLoader(),
        update(),
      }
    });
  }

  showgWhsCode(BuildContext context, double height,index){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
              title: Text('Order Type'),
              content: SizedBox(
                  width: double.minPositive,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: secWhsCode.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text("${secWhsCode[index].whsCode} - ${secWhsCode[index].whsName}"),
                        onTap: () {
                          // secScanInventoryModel[index].toWhsCode = secWhsCode[index].whsName.toString();
                          // secScanInventoryModel[index].toWhsCode = secWhsCode[index].whsName.toString();
                          whsCode = secWhsCode[index].whsCode.toString();
                          whsName.text = secWhsCode[index].whsName.toString();

                          if(secScanInventoryModel.isNotEmpty){
                            for(int l=0;l<secScanInventoryModel.length;l++){
                              secScanInventoryModel[l].toWhsCode = whsCode;
                            }
                          }


                          Get.back();


                        },
                      );
                    },
                  ))

          );
        },
        );

      },
    );
  }




  loginSap()  {

    api_call.loginSap(sessionDBName,sessionUserName,sessionPassword,true).then((value) => {
      if(value.statusCode==200){
        log("Success"),
        log(value.headers["set-cookie"].toString()),
        posting(value.headers["set-cookie"].toString()),
      }

    });

  }


  posting(String Cookie)  {
    //SapRefNo='0';
    String str = "#@F&L^&%U##T#T@#ER###CA@#@M*(PU@&#S%^%2324@*(^&";
    String result = str.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    print(result);
    var body;

    body = {
      "Series": 27,
      "DocDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),//"2025-02-03",
      "DueDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "Comments": null,
      "PriceList": -1,
      "FromWarehouse": secScanInventoryModel[0].whsCode,
      "ToWarehouse": whsCode,
      "TaxDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "BPLID": sessionBranchCode,
      "StockTransfer_ApprovalRequests": [],
      "ElectronicProtocols": [],
      "StockTransferLines": [
        for(int k=0;k<secScanInventoryModel.length;k++)
        {
          "LineNum": k,
          "ItemCode": secScanInventoryModel[k].itemCode,
          "Quantity": secScanInventoryModel[k].quantity,
          "Price": 0.0,
          "Currency": "",
          "Rate": 0.0,
          "DiscountPercent": 0.0,
          "VendorNum": "",
          "SerialNumber": null,
          "WarehouseCode": whsCode,
          "FromWarehouseCode": secScanInventoryModel[0].whsCode,
          "SerialNumbers": [],
          "BatchNumbers": [
            {
              "BatchNumber": secScanInventoryModel[k].batch,
              "AddmisionDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
              "Quantity":secScanInventoryModel[k].quantity,
              "ItemCode": secScanInventoryModel[k].itemCode,
              "BaseLineNumber": k,
            }
          ],
          "CCDNumbers": [],
          "StockTransferLinesBinAllocations": []
        }
      ],
      "StockTransferTaxExtension": {
        "SupportVAT": "tNO",
        "FormNumber": null,
        "TransactionCategory": null
      },
      "DocumentReferences": []
    };

    api_call.inventoryPostin(Cookie,body).then((value) => {
      Utility.closeLoader(),
      update(),
      if (value.statusCode == 200) {

        //postSave(),
        Utility.showDialaogboxSaved(Get.context, "Saved Successfully", "Saved"),
      }
      else if(value.statusCode == 201){
        Utility.showDialaogboxSaved(Get.context, "Saved Successfully", "Saved"),
      }
      else if(value.statusCode == 400){

          Utility.showDialaogboxWarning(Get.context, jsonDecode(value.body)['error']['message']['value'].toString(), "Warning")

        } else if (value.statusCode == 401){
          Utility.showDialaogboxWarning(Get.context, jsonDecode(value.body)['error']['message']['value'].toString(), "Warning")
        } else {
          Utility.closeLoader(),
          update(),
          throw Exception('Failed to Login API')
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
                        secScanInventoryModel[index].quantity = typeController.text.toString();
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












}



class ScanInventoryModel {
  String? itemCode;
  String? quantity;
  String? batch;
  String? whsCode;
  String? gRPODocNum;
  String? toWhsCode;

  ScanInventoryModel(
      this.itemCode,
        this.quantity,
        this.batch,
        this.whsCode,
        this.gRPODocNum,this.toWhsCode);

  ScanInventoryModel.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    quantity = json[' Quantity'];
    batch = json[' Batch'];
    whsCode = json[' WhsCode'];
    gRPODocNum = json[' GRPODocNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemCode'] = this.itemCode;
    data[' Quantity'] = this.quantity;
    data[' Batch'] = this.batch;
    data[' WhsCode'] = this.whsCode;
    data[' GRPODocNum'] = this.gRPODocNum;
    return data;
  }
}


class WhsCode {
  String? whsCode;
  String? whsName;

  WhsCode(this.whsCode, this.whsName);


}
