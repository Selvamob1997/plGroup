import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pl_groups/app/data/model/CustomerTypeModel.dart';
import 'package:pl_groups/app/data/model/ProductCodeModel.dart';
import 'package:pl_groups/app/data/model/QRMaterModel.dart';
import 'package:pl_groups/app/data/model/QrOrderTypeModel.dart';
import 'package:pl_groups/app/data/model/SaleOrderDetailsModel.dart';
import 'package:pl_groups/app/data/model/SaleOrderGetModel.dart';
import 'package:pl_groups/app/data/model/WhsCodeModel.dart';
import 'package:pl_groups/app/data/repository/api_call.dart';
import 'package:pl_groups/app/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';


class QrCodeGeneratorController extends GetxController{
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

  late QrOrderTypeModel rawQrOrderTypeModel;
  late CustomerTypeModel rawCardCodeModel;
  late ProductCodeModel rawProductCodeModel;
  late SaleOrderDetailsModel rawSaleOrderDetailsModel;
  late SaleOrderGetModel rawSaleOrderGetModel;


  RxList secCardCodeList=[].obs;

  List<ScreenSOData> secScreenSOData=[];
  List<ScreenDisplaySoData> secScreenDisplaySoData=[];
  List<ScreenBundle> secScreenBundle=[];

  final pagecontroller = PageController(initialPage: 0,);


  List<MasterResult> secMasterResult=[];
  late QRMaterModel rawQRMaterModel;

  bool saveBtn = true;
  bool goBtn = false;
  bool soDetalis = true;


  String itemDetailXML = "";
  String itemDetailXML1 = "";


  late WhsCodeModel rawWhsCodeModel;
  List<WhsCode>secWhsCode=[];
  String? whsCode = '';
  var whsName = TextEditingController();

 @override
  void onInit() {
    // TODO: implement onInit
   getStringValuesSF();
    super.onInit();
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
     getOrderType();
   }

  getOrderType(){
   api_call.getSalesOrderList(1,sessionBranchCode, true).then((value) => {
     if(value.statusCode == 200){
       rawQrOrderTypeModel = QrOrderTypeModel.fromJson(jsonDecode(value.body)),
       Utility.closeLoader(),
       update(),
       getCustomerType(),
     }
   });
  }


  getCustomerType(){
    api_call.getSalesOrderList(2,sessionBranchCode, true).then((value) => {
      if(value.statusCode == 200){
        log(value.body),
        rawCardCodeModel = CustomerTypeModel.fromJson(jsonDecode(value.body)),
        for(int i=0;i<rawCardCodeModel.result!.length;i++){
          secCardCodeList.add(
            CardCodeList(
              rawCardCodeModel.result![i].cardCode,
              rawCardCodeModel.result![i].cardName,
            ),
          ),
        },
        Utility.closeLoader(),
        getWhsCode(),
      }
    });
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
                    itemBuilder: (BuildContext context, int ind) {
                      return ListTile(
                        title: Text("${secWhsCode[ind].whsCode} - ${secWhsCode[ind].whsName}"),
                        onTap: () {
                          // secScanInventoryModel[index].toWhsCode = secWhsCode[index].whsName.toString();
                          // secScanInventoryModel[index].toWhsCode = secWhsCode[index].whsName.toString();
                          whsCode = secScreenDisplaySoData[index].whsCode;
                          secScreenDisplaySoData[index].whsCode = secWhsCode[ind].whsCode.toString();
                          update();



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


  getProductCode(BuildContext context, double height){
    api_call.getSalesOrderList(3,sessionBranchCode, true).then((value) => {
      if(value.statusCode == 200){
        log(value.body),
        if(jsonDecode(value.body)['status']==1){
          rawProductCodeModel = ProductCodeModel.fromJson(jsonDecode(value.body)),
        },


        Utility.closeLoader(),
        showProductCode(context, height),
      }
    });
  }


  showOrderType(BuildContext context, double height){
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
                  itemCount: rawQrOrderTypeModel.result!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(rawQrOrderTypeModel.result![index].name.toString()),
                      onTap: () {
                        //print(rawQrOrderTypeModel.result![index].name.toString());
                       myListClear(rawQrOrderTypeModel.result![index].name.toString(),rawQrOrderTypeModel.result![index].code.toString());
                       // cardName.text = secCardCodeList[index].cardName.toString();
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


  showcardame1(BuildContext context, double height){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            title: TextField(
              cursorColor: Colors.blue,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Search here...",
                  hintText: "Search here...",
                  prefixIcon: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.all(Radius.circular(height/15)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: height/70)),
              onChanged: (vv){

                var searchvarible=vv.toString();
                secCardCodeList.clear();
                for(int j=0;j<rawCardCodeModel.result!.length;j++){
                  if(rawCardCodeModel.result![j].cardName.toString().toLowerCase().trim().
                  contains(searchvarible.toString().trim()) || rawCardCodeModel.result![j].cardCode.toString().toLowerCase().trim().
                  contains(searchvarible.toString())   ){
                    secCardCodeList.add(
                      CardCodeList(
                        rawCardCodeModel.result![j].cardCode,
                        rawCardCodeModel.result![j].cardName,
                      ),
                    );
                  }
                };
                update();
              },
            ),
            content: SizedBox(
                width: double.minPositive,
                child: Obx(()=> ListView.builder(
                  shrinkWrap: true,
                  itemCount: secCardCodeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(secCardCodeList[index].cardName.toString()),
                      onTap: () {
                        cardCode.text = secCardCodeList[index].cardCode.toString();
                        cardName.text = secCardCodeList[index].cardName.toString();
                        Get.back();


                      },
                    );
                  },
                ),)
            ),
          );
        },
        );

      },
    );
  }


  showProductCode(BuildContext context, double height){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
              title: const Text('Choose Product Code'),
              content: SizedBox(
                  width: double.minPositive,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: rawProductCodeModel.result!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(rawProductCodeModel.result![index].prodCode.toString()),
                        onTap: () {
                          productCode.text = rawProductCodeModel.result![index].prodCode.toString();
                          // cardName.text = secCardCodeList[index].cardName.toString();
                          print(orderType.text);
                          print(orderType.text == 'Make To Stock');
                          Get.back();
                          if(orderType.text == 'Make To Stock'){
                            getMakeToOrderLineData();
                          }



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


  getSODetails(BuildContext context, double height){
    api_call.getSalesOrderCalling(sessionBranchCode, true).then((value) => {
      if(value.statusCode == 200){
        secScreenSOData.clear(),
        log(value.body),
        if(jsonDecode(value.body)['status']==1){
          rawSaleOrderDetailsModel = SaleOrderDetailsModel.fromJson(jsonDecode(value.body)),
          for(int j=0;j<rawSaleOrderDetailsModel.result!.length;j++){
            secScreenSOData.add(ScreenSOData(
                rawSaleOrderDetailsModel.result![j].selected,
                rawSaleOrderDetailsModel.result![j].soEntry,
                rawSaleOrderDetailsModel.result![j].soDocNum,
                rawSaleOrderDetailsModel.result![j].cardCode,
                rawSaleOrderDetailsModel.result![j].cardName,
                rawSaleOrderDetailsModel.result![j].delDate,
                rawSaleOrderDetailsModel.result![j].itemCode,
                rawSaleOrderDetailsModel.result![j].itemName,
                rawSaleOrderDetailsModel.result![j].reqQty,
                rawSaleOrderDetailsModel.result![j].lineNum))
          }

        },
        Utility.closeLoader(),
        pagecontroller.jumpToPage(1),
        myLayout(),
        update(),

      }
    });
  }

  Future<bool> onWillPop(context) async {

    if(pagecontroller.page==0){
      return (
          await showDialog(context: context, builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want Back to Home Screen ???'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No',style: TextStyle(color: Colors.white),),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: (){
                  Get.back();
                  Get.back();
                },
                child: const Text('Yes',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
          )) ;

    }else {
      pagecontroller.jumpToPage(0);
    }
    myLayout();
    return false;

  }

  void itemdeteliesSelect(int indexOf) {
   if(secScreenSOData[indexOf].selected==""){
     secScreenSOData[indexOf].selected="1";
   }else{
     secScreenSOData[indexOf].selected="";
   }
   update();

  }

  myLayout() {
   saveBtn = false;
   goBtn = false;
   soDetalis = false;
   if(pagecontroller.page==0){
     saveBtn = true;
     soDetalis = true;
   }else if(pagecontroller.page==1){
     goBtn = true;
   }
   update();
  }



  getSalesOrderLineData(docEntry,lineID){
    secScreenDisplaySoData.clear();
   api_call.getSalesOrderGetDetailes(productCode.text, docEntry, lineID, orderType.text,true).then((value) => {
     if(value.statusCode == 200){
       if(jsonDecode(value.body)['status']==1){
         rawSaleOrderGetModel = SaleOrderGetModel.fromJson(jsonDecode(value.body)),
         for(int f=0;f<rawSaleOrderGetModel.result!.length;f++){
           secScreenDisplaySoData.add(ScreenDisplaySoData(
               rawSaleOrderGetModel.result![f].soEntry,
               rawSaleOrderGetModel.result![f].soNum,
               rawSaleOrderGetModel.result![f].cardRefNo.toString(),
               rawSaleOrderGetModel.result![f].branch.toString(),
               rawSaleOrderGetModel.result![f].delDate,
               rawSaleOrderGetModel.result![f].cardCode,
               rawSaleOrderGetModel.result![f].cardName,
               rawSaleOrderGetModel.result![f].itemCode,
               rawSaleOrderGetModel.result![f].itemName,
               rawSaleOrderGetModel.result![f].whsCode,
               rawSaleOrderGetModel.result![f].baseLine,
               rawSaleOrderGetModel.result![f].quantity,
               rawSaleOrderGetModel.result![f].varible1,
               rawSaleOrderGetModel.result![f].varible1Name,
               rawSaleOrderGetModel.result![f].varible1Code,
               rawSaleOrderGetModel.result![f].varible2,
               rawSaleOrderGetModel.result![f].varible2Name,
               rawSaleOrderGetModel.result![f].varible2Code,
               rawSaleOrderGetModel.result![f].varible3,
               rawSaleOrderGetModel.result![f].varible3Name,
               rawSaleOrderGetModel.result![f].varible3Code,
               rawSaleOrderGetModel.result![f].varible4,
               rawSaleOrderGetModel.result![f].varible4Name,
               rawSaleOrderGetModel.result![f].varible4Code,
               rawSaleOrderGetModel.result![f].varible5,
               rawSaleOrderGetModel.result![f].varible5Name,
               rawSaleOrderGetModel.result![f].varible5Code,
               rawSaleOrderGetModel.result![f].varible6,
               rawSaleOrderGetModel.result![f].varible6Name,
               rawSaleOrderGetModel.result![f].varible6Code,
               rawSaleOrderGetModel.result![f].varible7,
               rawSaleOrderGetModel.result![f].varible7Name,
               rawSaleOrderGetModel.result![f].varible7Code,
               rawSaleOrderGetModel.result![f].varible8,
               rawSaleOrderGetModel.result![f].varible8Name,
               rawSaleOrderGetModel.result![f].varible8Code,
               rawSaleOrderGetModel.result![f].varible9,
               rawSaleOrderGetModel.result![f].varible9Name,
               rawSaleOrderGetModel.result![f].varible9Code,
               rawSaleOrderGetModel.result![f].varible10,
               rawSaleOrderGetModel.result![f].varible10Name,
               rawSaleOrderGetModel.result![f].varible10Code,
               rawSaleOrderGetModel.result![f].varible11,
               rawSaleOrderGetModel.result![f].varible11Name,
               rawSaleOrderGetModel.result![f].varible11Code,
               rawSaleOrderGetModel.result![f].varible12,
               rawSaleOrderGetModel.result![f].varible12Name,
               rawSaleOrderGetModel.result![f].varible12Code,
               rawSaleOrderGetModel.result![f].varible13,
               rawSaleOrderGetModel.result![f].varible13Name,
               rawSaleOrderGetModel.result![f].varible13Code,""))
         },
         update(),
         log(value.body),
         Utility.closeLoader(),
       }
     },
   });
  }

   getMyScreenData() {

   int flog=0;

      for(int k=0;k<secScreenSOData.length;k++){
        if(secScreenSOData[k].selected=="1"){
          flog = 1;
          getSalesOrderLineData(
            secScreenSOData[k].soEntry,
            secScreenSOData[k].itemCode,
          );
        }

      }

      if(flog==0){

      }else{
        pagecontroller.jumpToPage(0);
        myLayout();
      }
      update();
   }


  getMakeToOrderLineData(){
    secScreenDisplaySoData.clear();
    api_call.getSalesOrderGetDetailes(productCode.text, 0, 0, orderType.text,true).then((value) => {
      //print(value.body),
      if(value.statusCode == 200){
        if(jsonDecode(value.body)['status']==1){
          rawSaleOrderGetModel = SaleOrderGetModel.fromJson(jsonDecode(value.body)),
          for(int f=0;f<rawSaleOrderGetModel.result!.length;f++){
            secScreenDisplaySoData.add(ScreenDisplaySoData(
                rawSaleOrderGetModel.result![f].soEntry,
                rawSaleOrderGetModel.result![f].soNum,
                rawSaleOrderGetModel.result![f].cardRefNo.toString(),
                rawSaleOrderGetModel.result![f].branch.toString(),
                rawSaleOrderGetModel.result![f].delDate,
                rawSaleOrderGetModel.result![f].cardCode,
                rawSaleOrderGetModel.result![f].cardName,
                rawSaleOrderGetModel.result![f].itemCode,
                rawSaleOrderGetModel.result![f].itemName,
                rawSaleOrderGetModel.result![f].whsCode,
                rawSaleOrderGetModel.result![f].baseLine,
                rawSaleOrderGetModel.result![f].quantity,
                rawSaleOrderGetModel.result![f].varible1,
                rawSaleOrderGetModel.result![f].varible1Name,
                rawSaleOrderGetModel.result![f].varible1Code,
                rawSaleOrderGetModel.result![f].varible2,
                rawSaleOrderGetModel.result![f].varible2Name,
                rawSaleOrderGetModel.result![f].varible2Code,
                rawSaleOrderGetModel.result![f].varible3,
                rawSaleOrderGetModel.result![f].varible3Name,
                rawSaleOrderGetModel.result![f].varible3Code,
                rawSaleOrderGetModel.result![f].varible4,
                rawSaleOrderGetModel.result![f].varible4Name,
                rawSaleOrderGetModel.result![f].varible4Code,
                rawSaleOrderGetModel.result![f].varible5,
                rawSaleOrderGetModel.result![f].varible5Name,
                rawSaleOrderGetModel.result![f].varible5Code,
                rawSaleOrderGetModel.result![f].varible6,
                rawSaleOrderGetModel.result![f].varible6Name,
                rawSaleOrderGetModel.result![f].varible6Code,
                rawSaleOrderGetModel.result![f].varible7,
                rawSaleOrderGetModel.result![f].varible7Name,
                rawSaleOrderGetModel.result![f].varible7Code,
                rawSaleOrderGetModel.result![f].varible8,
                rawSaleOrderGetModel.result![f].varible8Name,
                rawSaleOrderGetModel.result![f].varible8Code,
                rawSaleOrderGetModel.result![f].varible9,
                rawSaleOrderGetModel.result![f].varible9Name,
                rawSaleOrderGetModel.result![f].varible9Code,
                rawSaleOrderGetModel.result![f].varible10,
                rawSaleOrderGetModel.result![f].varible10Name,
                rawSaleOrderGetModel.result![f].varible10Code,
                rawSaleOrderGetModel.result![f].varible11,
                rawSaleOrderGetModel.result![f].varible11Name,
                rawSaleOrderGetModel.result![f].varible11Code,
                rawSaleOrderGetModel.result![f].varible12Code,
                rawSaleOrderGetModel.result![f].varible12,
                rawSaleOrderGetModel.result![f].varible12Name,
                rawSaleOrderGetModel.result![f].varible13,
                rawSaleOrderGetModel.result![f].varible13Name,
                rawSaleOrderGetModel.result![f].varible13Code,""))
          },
          update(),
          log(value.body),
          Utility.closeLoader(),
        }
      },
    });
  }

  showQty(int index, String tittle, fromId,height,width) {
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
                        secScreenDisplaySoData[index].bundale = int.parse(typeController.text.toString());
                        myBundaleCal(
                            int.parse(typeController.text.toString()),
                            secScreenDisplaySoData[index].quantity,
                            secScreenDisplaySoData[index].itemCode,height,width,index
                        );
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

  void myBundaleCal(int val, quantity,itemCode,height,width, int index) {

   api_call.getSalesOrderList(4, sessionBranchCode, true).then((value) => {
     if(value.statusCode == 200){
       secScreenBundle.clear(),
       if(jsonDecode(value.body)['status']==1){
         print(value.body),


         if(orderType.text =='Make To Order'){
           for(int h=0;h<(quantity~/val);h++){
             print(
                 jsonDecode(value.body)['result'][0]['Prefix']+""+ (int.parse(jsonDecode(value.body)['result'][0]['NextNo'].toString())+(h+1)).toString()
             ),
             secScreenBundle.add(
               ScreenBundle(
                 h.toString(),
                 itemCode,
                 jsonDecode(value.body)['result'][0]['Prefix']+""+ (int.parse(jsonDecode(value.body)['result'][0]['NextNo'].toString())+(h+1)).toString(),
                 val,
                 productCode.text,index+1
               ),
             )
           },
           if((quantity).remainder(val)==0){

           }else{
             secScreenBundle.add(
               ScreenBundle(
                 (secScreenBundle.length+1).toString(),
                 itemCode,
                 jsonDecode(value.body)['result'][0]['Prefix']+""+ (int.parse(jsonDecode(value.body)['result'][0]['NextNo'].toString())+(secScreenBundle.length+1)).toString(),
                 (quantity).remainder(val),
                 productCode.text,index+1
               ),
             ),
           },


         }else if(orderType.text =='Make To Stock'){


           for(int h=0;h<val;h++){
             print(
                 jsonDecode(value.body)['result'][0]['Prefix']+""+ (int.parse(jsonDecode(value.body)['result'][0]['NextNo'].toString())+(h+1)).toString()
             ),
             secScreenBundle.add(
               ScreenBundle(
                 h.toString(),
                 '0',
                 jsonDecode(value.body)['result'][0]['Prefix']+""+ (int.parse(jsonDecode(value.body)['result'][0]['NextNo'].toString())+(h+1)).toString(),
                 '0',
                 productCode.text,index+1
               ),
             )
           },



         },



         Utility.closeLoader(),
         update(),
         showBundleList(height,width)
       }else{
         Utility.closeLoader(),
       }

     }else{
       Utility.closeLoader(),
       update(),
     }
   });

   update();


  }

  showBundleList(height,width) {
    Get.dialog(
      AlertDialog(
        title: Text("QR Details"),
        content: SizedBox(
            width: width/1.2,
            height: height/2,
            child: ListView.builder(
              itemCount: secScreenBundle.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      SizedBox(height: height/200,),
                      Container(
                        height: height/50,
                        width: width,
                        margin: EdgeInsets.only(left: width/50),
                        child: Text(secScreenBundle[index].itemCode.toString(),style: TextStyle(fontWeight: FontWeight.w500,color: Colors.pink.shade900),),
                      ),
                      SizedBox(height: height/200,),

                      Row(
                        children: [
                          SizedBox(width: width/60,),
                          SizedBox(
                            height: height/50,
                            width: width/5,
                            child: Text("Bundles : ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w900),),
                          ),
                          SizedBox(
                            height: height/50,
                            width: width/3,
                            child: Text(secScreenBundle[index].bundles.toString()),
                          )
                        ],
                      ),
                      SizedBox(height: height/200,),

                      Row(
                        children: [
                          SizedBox(width: width/60,),
                          SizedBox(
                            height: height/50,
                            width: width/5,
                            child: Text("Actual Qty : ",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w900)),
                          ),
                          SizedBox(
                            height: height/50,
                            width: width/3,
                            child: Text(secScreenBundle[index].actualQty.toString()),
                          )
                        ],
                      ),

                    ],
                  ),
                );
              },
            ),
        ),
      ),
    );
  }

  void myListClear(order, String code) {
    soDetalis = false;
    orderType.text = order.toString();
    orderTypeCode.text = code.toString();
    cardCode.text = '';
    cardName.text = '';
    productCode.text = '';
    secScreenDisplaySoData.clear();
    if(orderType.text=="Make To Order"){
      soDetalis = true;
    }
    update();
  }

  getMakeToOrderMaster(int fromID,status,code,parName,BuildContext context,height,setVaribleName, int index){
    secMasterResult.clear();
    update();
   api_call.getSalesQrMaster(fromID, status, productCode.text, code, parName, true).then((value) => {
     if(value.statusCode  == 200){
       log(value.body),
       if(jsonDecode(value.body)['status']==1){
         rawQRMaterModel = QRMaterModel.fromJson(jsonDecode(value.body)),
         for(int i=0;i<rawQRMaterModel.result!.length;i++){
           secMasterResult.add(
               MasterResult(
                   rawQRMaterModel.result![i].uParCode,
                   rawQRMaterModel.result![i].uPaCode,
                   rawQRMaterModel.result![i].uSpcation,
                   rawQRMaterModel.result![i].uParName
               ),
           )
         },
         Utility.closeLoader(),
         update(),
         showMymasterData(context, height,setVaribleName,index)

       }else{
         Utility.closeLoader(),
         update(),
       },

     }else{
       Utility.closeLoader(),
       update(),
     }
   });
  }


  showMymasterData(BuildContext context, double height, setVaribleName, int index){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return AlertDialog(
            title: Text(rawQRMaterModel.result![0].uParName.toString()),
            content: SizedBox(
                width: double.minPositive,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: secMasterResult.length,
                  itemBuilder: (BuildContext context, int index1) {
                    return ListTile(
                      title: Text(secMasterResult[index1].uSpcation.toString()),
                      onTap: () {
                        if(setVaribleName=="1"){
                          secScreenDisplaySoData[index].varible1 = secMasterResult[index1].uSpcation.toString();
                        }else if(setVaribleName=="2"){
                          secScreenDisplaySoData[index].varible2 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="3"){
                          secScreenDisplaySoData[index].varible3 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="4"){
                          secScreenDisplaySoData[index].varible4 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="5"){
                          secScreenDisplaySoData[index].varible5 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="6"){
                          secScreenDisplaySoData[index].varible6 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="7"){
                          secScreenDisplaySoData[index].varible7 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="8"){
                          secScreenDisplaySoData[index].varible8 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="9"){
                          secScreenDisplaySoData[index].varible9 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="10"){
                          secScreenDisplaySoData[index].varible10 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="11"){
                          secScreenDisplaySoData[index].varible11 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="12"){
                          secScreenDisplaySoData[index].varible12 = secMasterResult[index1].uSpcation.toString();
                        }
                        else if(setVaribleName=="13"){
                          secScreenDisplaySoData[index].varible13 = secMasterResult[index1].uSpcation.toString();
                        }
                        update();
                        Get.back();


                      },
                    );
                  },
                )
            ),
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

    //if(orderType.text == "Make To Order"){
      if(productCode.text == '000042'){
        body = {
          "Series": 205,
          "U_QRFor": orderTypeCode.text,
          "U_Branch": sessionBranchCode,
          "U_CardCode": cardCode.text,
          "U_CardName": cardName.text,
          "U_PostDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),//"2025-01-08"
          "U_Remarks": "Posted From Mobile App",
          "U_Print": "12",
          "U_ProdCode": productCode.text,
          "U_ProdName": "REXINE",
          "U_QRType1": "WL",
          "U_QRType2": "WP",
          "INSP_QRG1Collection": [
            for(int j=0;j<secScreenDisplaySoData.length;j++)
              {

                  "U_SoEntry": secScreenDisplaySoData[j].soEntry,
                  "U_SoDocNum": secScreenDisplaySoData[j].soNum,
                  "U_BaseLine": secScreenDisplaySoData[j].baseLine,
                  "U_CardCode": cardCode.text,
                  "U_CardName": cardName.text,
                  "U_ReqDate": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  "U_ItemCode": secScreenDisplaySoData[j].itemCode,
                  "U_ItemName": secScreenDisplaySoData[j].itemName,
                  "U_Quantity": secScreenDisplaySoData[j].quantity,
                  "U_BundInfo": secScreenBundle.length,

                "U_QltRexine": secScreenDisplaySoData[j].varible1,
                "U_EmbossRexine": secScreenDisplaySoData[j].varible2,
                "U_ThickRexine": secScreenDisplaySoData[j].varible3,
                "U_ClothRexine": secScreenDisplaySoData[j].varible4,
                "U_FinishRexine": secScreenDisplaySoData[j].varible5,
                "U_CLrRexine": secScreenDisplaySoData[j].varible6,
                "U_ToneRexine": secScreenDisplaySoData[j].varible7,
                "U_WidthRexine": secScreenDisplaySoData[j].varible8,
                "U_GradeRexine": secScreenDisplaySoData[j].varible9,
                "U_Weight": 0,
                "U_LengthInch": null,
                "U_Noofsheet": secScreenDisplaySoData[j].bundale,
                "U_WhsCode": secScreenDisplaySoData[j].whsCode,
              },
          ],
          "INSP_QRG2Collection": [
            for(int j=0;j<secScreenBundle.length;j++)
              {
                "U_ItemCode": secScreenBundle[j].itemCode,
                "U_Bundles":secScreenBundle[j].bundles,// "WAL/REX44",
                "U_ActQty": secScreenBundle[j].actualQty,
                "U_DelQty": 0.0,
                "U_ActualWeight": 0.0,
                "U_UniqID": secScreenBundle[j].unqID,
                "U_BRQty": 10.0,
                "U_ProdCode":productCode.text,
                "U_ValidStatus": "N",
                "U_DeliveryStatus": "N",
                "U_StkGenStatus": "N",
                "U_GREntry": "",
                "U_GRStatus": "NP",
                "U_GIEntry": "",
                "U_GIStatus": "NP",
                "U_ProdStatus": "NP",
                "U_ProdEntry": null
              },
          ]
        };
      }
    //}


    //log(jsonEncode(body));


    api_call.sapposting(Cookie,body).then((value) => {
      Utility.closeLoader(),
      update(),
      if (value.statusCode == 200) {

        postSave(),
        //Utility.showDialaogboxSaved(Get.context, "Saved Successfully", "Saved"),
    } 
      else if(value.statusCode == 201){
        postSave(),
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


  postSave(){
    itemDetailXML="";

    for(int i=0;i<secScreenDisplaySoData.length;i++){
      itemDetailXML = itemDetailXML+"<Table1><DocEntry>0</DocEntry><SoEntry>"+secScreenDisplaySoData[i].soEntry.toString()+"</SoEntry><ProductNo>"+productCode.text+"</ProductNo><ItemCode>" + secScreenDisplaySoData[i].itemCode.toString() + "</ItemCode>"
          "<LineID>${i+1}</LineID><Qty>" + secScreenDisplaySoData[i].quantity.toString()
          + "</Qty><Bundle>${secScreenBundle.length+1}</Bundle><WhsCode>" +
          secScreenDisplaySoData[i].whsCode.toString() + "</WhsCode><Varible1>" + secScreenDisplaySoData[i].varible1.toString() +
          "</Varible1><Varible2>" + secScreenDisplaySoData[i].varible2.toString() + "</Varible2><Varible3>" +
          secScreenDisplaySoData[i].varible3.toString() + "</Varible3><Varible4>" + secScreenDisplaySoData[i].varible4.toString() + "</Varible4><Varible5>"
          + secScreenDisplaySoData[i].varible5.toString() + "</Varible5><Varible6>" + secScreenDisplaySoData[i].varible6.toString() + "</Varible6><Varible7>"
          + secScreenDisplaySoData[i].varible7.toString() + "</Varible7><Varible8>" + secScreenDisplaySoData[i].varible8.toString() + "</Varible8><Varible9>"
          + secScreenDisplaySoData[i].varible9.toString() + "</Varible9><Varible10>" + secScreenDisplaySoData[i].varible10.toString() + "</Varible10><Varible11>" + secScreenDisplaySoData[i].varible11.toString() +
          "</Varible11><Varible12>" + secScreenDisplaySoData[i].varible12.toString() + "</Varible12><Varible13>" + secScreenDisplaySoData[i].varible13.toString() +
          "</Varible13></Table1>";
    }



    for(int i=0;i<secScreenBundle.length;i++){
      itemDetailXML1 = itemDetailXML1+"<Table2><DocEntry>0</DocEntry><LineID>${i+1}</LineID><itemCode>"+secScreenBundle[i].itemCode+"</itemCode><Bundle>"+secScreenBundle[i].bundles.toString()+"</Bundle>"
          "<actualQty>"+secScreenBundle[i].actualQty.toString()+"</actualQty><prodCode>" + secScreenBundle[i].prodCode.toString()
          + "</prodCode></Table2>";
    }




    itemDetailXML = "<NewDataSet>$itemDetailXML</NewDataSet>";
    itemDetailXML1 = "<NewDataSet1>$itemDetailXML1</NewDataSet1>";

    api_call.insertQRScreenInsert(1, orderType.text, cardCode.text, cardName.text, sessionBranchCode,
        branchName.text, productCode.text, sessionCode, itemDetailXML, secScreenDisplaySoData.isEmpty?0:1, itemDetailXML1, 1, true).then((value) => {
          print(jsonDecode(value.body)['status']),
      Utility.closeLoader(),
      if(jsonDecode(value.body)['status'].toString()=="1"){
        print(jsonDecode(value.body)['result'][0]['Message']),
        if(jsonDecode(value.body)['result'][0]['Status'].toString()=="S"){
          Utility.showDialaogboxSaved(Get.context, jsonDecode(value.body)['result'][0]['Message'].toString(), "Saved"),
        }else{
          Utility.showDialaogboxSaved(Get.context, jsonDecode(value.body)['result'][0]['Message'].toString(), "Warning")
        }

      }



    });

  }


}


class CardCodeList {
  String? cardCode;
  String? cardName;
  CardCodeList(this.cardCode, this.cardName);
}

class ScreenSOData {
  String? selected;
  int? soEntry;
  int? soDocNum;
  String? cardCode;
  String? cardName;
  String? delDate;
  String? itemCode;
  String? itemName;
  var reqQty;
  var lineNum;

  ScreenSOData(
      this.selected,
        this.soEntry,
        this.soDocNum,
        this.cardCode,
        this.cardName,
        this.delDate,
        this.itemCode,
        this.itemName,
        this.reqQty,
        this.lineNum);


}


class ScreenDisplaySoData {
  int? soEntry;
  int? soNum;
  var cardRefNo;
  var branch;
  String? delDate;
  String? cardCode;
  String? cardName;
  String? itemCode;
  String? itemName;
  String? whsCode;
  var baseLine;
  var quantity;
  String? varible1;
  String? varible1Name;
  String? varible1Code;
  String? varible2;
  String? varible2Name;
  String? varible2Code;
  String? varible3;
  String? varible3Name;
  String? varible3Code;
  String? varible4;
  String? varible4Name;
  String? varible4Code;
  String? varible5;
  String? varible5Name;
  String? varible5Code;
  String? varible6;
  String? varible6Name;
  String? varible6Code;
  String? varible7;
  String? varible7Name;
  String? varible7Code;
  var varible8;
  String? varible8Name;
  String? varible8Code;
  String? varible9;
  String? varible9Name;
  String? varible9Code;
  String? varible10;
  String? varible10Name;
  String? varible10Code;
  String? varible11;
  String? varible11Name;
  String? varible11Code;
  String? varible12;
  String? varible12Name;
  String? varible12Code;
  String? varible13;
  String? varible13Name;
  String? varible13Code;
  var bundale;

  ScreenDisplaySoData(
      this.soEntry,
      this.soNum,
      this.cardRefNo,
      this.branch,
      this.delDate,
      this.cardCode,
      this.cardName,
      this.itemCode,
      this.itemName,
      this.whsCode,
      this.baseLine,
      this.quantity,
      this.varible1,
      this.varible1Name,
      this.varible1Code,
      this.varible2,
      this.varible2Name,
      this.varible2Code,
      this.varible3,
      this.varible3Name,
      this.varible3Code,
      this.varible4,
      this.varible4Name,
      this.varible4Code,
      this.varible5,
      this.varible5Name,
      this.varible5Code,
      this.varible6,
      this.varible6Name,
      this.varible6Code,
      this.varible7,
      this.varible7Name,
      this.varible7Code,
      this.varible8,
      this.varible8Name,
      this.varible8Code,
      this.varible9,
      this.varible9Name,
      this.varible9Code,
      this.varible10,
      this.varible10Name,
      this.varible10Code,
      this.varible11,
      this.varible11Name,
      this.varible11Code,
      this.varible12,
      this.varible12Name,
      this.varible12Code,
      this.varible13,
      this.varible13Name,
      this.varible13Code,this.bundale);
}

class ScreenBundle{
  var rowId;
  var itemCode;
  var bundles;
  var actualQty;
  var prodCode;
  var unqID;
  ScreenBundle(this.rowId,this.itemCode,this.bundles,this.actualQty,this.prodCode,this.unqID);
}


class MasterResult {
  String? uParCode;
  String? uPaCode;
  String? uSpcation;
  String? uParName;

  MasterResult(this.uParCode, this.uPaCode, this.uSpcation, this.uParName);

}

class WhsCode {
  String? whsCode;
  String? whsName;

  WhsCode(this.whsCode, this.whsName);


}






