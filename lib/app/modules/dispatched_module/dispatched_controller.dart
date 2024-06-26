// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pl_groups/app/data/model/CardCodeModel.dart';
import 'package:pl_groups/app/data/model/SalesOrdersDocNoModel.dart';
import 'package:pl_groups/app/data/model/SalesOrdersItemModel.dart';
import 'package:pl_groups/app/data/repository/api_call.dart';
import 'package:pl_groups/app/utils/utility.dart';
import '../../theme/colors_value.dart';
import '../packing_screen_module/packing_screen_controller.dart';


class DispatchedController extends GetxController{

  late CardCodeModel rawCardCodeModel;
  RxList secCardCodeList=[].obs;

  late SalesOrdersDocNoModel rawSalesOrdersDocNoModel;
  RxList secSalesOrderList=[].obs;


  late SalesOrdersItemModel  rawSalesOrdersItemModel;
  List<SalesOrdersItemList> secSalesOrdersItemList=[];
  List<SalesOrdersBatchList> secSalesOrdersBatchList=[];


  var cardNameCtr = TextEditingController();
  var cardCodeCtr = TextEditingController();


  var salesDocNoctr = TextEditingController();
  var salesDocEntryctr = TextEditingController();


  var salesvechaleno = TextEditingController();



  @override
  void onInit() {
    // TODO: implement onInit
    getStringValuesSF();
    update();
    super.onInit();
  }

  getStringValuesSF()   {
     Future.delayed(const Duration(milliseconds: 20), () {
       getCardCodelist(1, "status");
     });
  }

  getCardCodelist(fromID,status){
    secCardCodeList.clear();
    update();
    api_call.getAllMaster(fromID, "soNo","docEntry","userId","cardCode","status", true).then((value) => {
      log(value.body),
      if(value.statusCode==200){
        if(jsonDecode(value.body)["status"].toString()=="0"){
          Utility.closeLoader(),
          update(),
        }else {
          rawCardCodeModel = CardCodeModel.fromJson(jsonDecode(value.body)),
          for(int i=0;i<rawCardCodeModel.result!.length;i++){
          secCardCodeList.add(
              CardCodeList(
                rawCardCodeModel.result![i].cardCode,
                rawCardCodeModel.result![i].cardName,
              ),
          ),
        },
          Utility.closeLoader(),
          update(),
        }
      }
    });
  }


  showCardName(){
    var serchcall = TextEditingController();
    Get.dialog(
        StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                  left: Constants.padding,
                  top: Constants.avatarRadius + Constants.padding,
                  right: Constants.padding,
                  bottom: Constants.padding),
                  margin: const EdgeInsets.only(top: Constants.avatarRadius),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Constants.padding),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
                      ]),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: TextField(
                            controller: serchcall,
                            enabled: true,
                            style: const TextStyle(fontSize: 12),
                            onChanged: (vvv){

                              update();
                              },
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 3, bottom: 2, left: 10, right: 10),
                            hintText: 'Search Here..',
                            labelText: 'Search Here..',
                            labelStyle: TextStyle(color: Colors.grey.shade600),
                            prefixIcon: const Icon(Icons.search_rounded,color: Colors.deepOrange,)
                          //border: const OutlineInputBorder(),
                        ),
                          ),
                        ),
                        SizedBox(
                          width: 350,
                          height: 450,
                          child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: secCardCodeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(secCardCodeList[index].cardCode.toString()),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(secCardCodeList[index].cardName.toString()),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Get.back();
                                cardCodeCtr.text = secCardCodeList[index].cardCode.toString();
                                cardNameCtr.text = secCardCodeList[index].cardName.toString();
                                getSaleDocNolist(2, "status", cardCodeCtr.text);

                                update();
                              },
                            ),
                          );
                        },
                      ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                        onPressed: () {
                          Get.back();
                          update();
                        },
                        child: const Text("Cancel", style: TextStyle(fontSize: 18, color: Colors.black),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
            ),
          );
        }),
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
                        cardCodeCtr.text = secCardCodeList[index].cardCode.toString();
                        cardNameCtr.text = secCardCodeList[index].cardName.toString();
                        Get.back();
                        getSaleDocNolist(2, "status", cardCodeCtr.text);

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


  showSalesDocno(){
    var serchcall = TextEditingController();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: Constants.padding,
                  top: Constants.avatarRadius + Constants.padding,
                  right: Constants.padding,
                  bottom: Constants.padding),
              margin: const EdgeInsets.only(top: Constants.avatarRadius),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.padding),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
                  ]),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextField(
                        controller: serchcall,
                        enabled: true,
                        style: const TextStyle(fontSize: 12),
                        onChanged: (vvv){

                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 3, bottom: 2, left: 10, right: 10),
                            hintText: 'Search Here..',
                            labelText: 'Search Here..',
                            labelStyle: TextStyle(color: Colors.grey.shade600),
                            prefixIcon: const Icon(Icons.search_rounded,color: Colors.deepOrange,)
                          //border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: 450,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: secSalesOrderList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(secSalesOrderList[index].docNum.toString()),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(secSalesOrderList[index].docEntry.toString()),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Get.back();
                                salesDocNoctr.text = secSalesOrderList[index].docNum.toString();
                                salesDocEntryctr.text = secSalesOrderList[index].docEntry.toString();
                                getSaleItemlist(3, "status", salesDocEntryctr.text);

                                update();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                          update();
                        },
                        child: const Text("Cancel", style: TextStyle(fontSize: 18, color: Colors.black),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  showSalesDocno1(BuildContext context, double height){
    secSalesOrderList.clear();
    for(int i=0;i<rawSalesOrdersDocNoModel.result!.length;i++){
      secSalesOrderList.add(
        SalesOrderList(
            rawSalesOrdersDocNoModel.result![i].docNum,
            rawSalesOrdersDocNoModel.result![i].docEntry,
            rawSalesOrdersDocNoModel.result![i].cardCode),
      );
    };
    update();

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
                secSalesOrderList.clear();
                for(int j=0;j<rawSalesOrdersDocNoModel.result!.length;j++){
                  if(rawSalesOrdersDocNoModel.result![j].docNum.toString().toLowerCase().trim().
                  contains(searchvarible.toString().trim()) || rawSalesOrdersDocNoModel.result![j].docEntry.toString().toLowerCase().trim().
                  contains(searchvarible.toString())   ){
                    secSalesOrderList.add(
                      SalesOrderList(
                          rawSalesOrdersDocNoModel.result![j].docNum,
                          rawSalesOrdersDocNoModel.result![j].docEntry,
                          rawSalesOrdersDocNoModel.result![j].cardCode),
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
                  itemCount: secSalesOrderList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            Container(
                              height: height/30,
                              width: double.maxFinite,
                              margin: EdgeInsets.only(left: 5),
                              child: Text(secSalesOrderList[index].docNum.toString()),
                            ),
                            SizedBox(height: height/80,),
                            Container(
                              height: height/30,
                              width: double.maxFinite,
                              margin: EdgeInsets.only(left: 5),
                              child: Text(secSalesOrderList[index].docEntry.toString()),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        salesDocNoctr.text = secSalesOrderList[index].docNum.toString();
                        salesDocEntryctr.text = secSalesOrderList[index].docEntry.toString();
                        Get.back();
                        getSaleItemlist(3, "status", salesDocEntryctr.text);
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



  getSaleDocNolist(fromID,status,cardCode){
    salesDocNoctr.text = "";
    salesDocEntryctr.text = "";
    secSalesOrderList.clear();
    secSalesOrdersItemList.clear();
    update();
    api_call.getAllMaster(fromID, "soNo","docEntry","userId",cardCode,"status", true).then((value) => {
      log(value.body),
      if(value.statusCode==200){


        if(jsonDecode(value.body)["status"].toString()=="0"){
          Utility.closeLoader(),
          update(),
        }else{
          rawSalesOrdersDocNoModel = SalesOrdersDocNoModel.fromJson(jsonDecode(value.body)),
          for(int i=0;i<rawSalesOrdersDocNoModel.result!.length;i++){
      secSalesOrderList.add(
        SalesOrderList(
            rawSalesOrdersDocNoModel.result![i].docNum,
            rawSalesOrdersDocNoModel.result![i].docEntry,
            rawSalesOrdersDocNoModel.result![i].cardCode),
      ),
    },
          Utility.closeLoader(),
          update(),
        }

      }
    });
  }


  getSaleItemlist(fromID,status,docEntry){
    secSalesOrdersItemList.clear();
    secSalesOrdersBatchList.clear();

    update();
    api_call.getAllMaster(fromID, "soNo",docEntry,"userId","cardCode","status", true).then((value) => {
      log(value.body),
      if(value.statusCode==200){
        rawSalesOrdersItemModel = SalesOrdersItemModel.fromJson(jsonDecode(value.body)),
        if(jsonDecode(value.body)["status"].toString()=="0"){

          Utility.closeLoader(),
          update(),
        }else{
          for(int i=0;i<rawSalesOrdersItemModel.result!.length;i++){
            secSalesOrdersItemList.add(
              SalesOrdersItemList(
                  rawSalesOrdersItemModel.result![i].itemCode,
                  rawSalesOrdersItemModel.result![i].itemName,
                  rawSalesOrdersItemModel.result![i].actualQty,
                  0,
                  rawSalesOrdersItemModel.result![i].actualQty,
                  0,"","","","","",
                rawSalesOrdersItemModel.result![i].qrdocEntry,
                rawSalesOrdersItemModel.result![i].qrlineID,
              ),
            )
          },
          Utility.closeLoader(),
          update(),
        }


      }
    });
  }


  showQty(int index,String tittle,fromId){
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
                  keyboardType: fromId==1?TextInputType.number:TextInputType.visiblePassword,
                  decoration:  InputDecoration(
                    hintText: tittle,
                    border: InputBorder.none,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      if(fromId==1){
                        secSalesOrdersItemList[index].disatchedQty=double.parse(typeController.text.toString());
                        double value = double.parse(typeController.text.toString());

                        double sum_value = secSalesOrdersItemList[index].actualQty - value;

                        secSalesOrdersItemList[index].blanceQty = sum_value;
                        update();

                      }
                      update();

                      Get.back();
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


  showBatch(int index,String tittle,fromId,itemCode,qrDocentry,qrLine){
    Get.dialog(
      AlertDialog(
        content: SizedBox(
            width: double.minPositive,
            //height: double.minPositive,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: secSalesOrdersBatchList.isNotEmpty ?
                DataTable(columnSpacing: 30.0,
                  headingRowColor: MaterialStateProperty.all(ColorsValue.primaryColor),
                  showCheckboxColumn: true,
                  sortColumnIndex: 0,
                  sortAscending: true,
                  columns: const <DataColumn>[
                    DataColumn(
                  label: Text(
                    'ItemCode',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                    DataColumn(
                  label: Center(
                    child: Text(
                      'Batch',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                    DataColumn(
                  label: Center(
                    child: Text(
                      'Qty',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                  ],
                  rows: secSalesOrdersBatchList.where((element) =>
                      element.itemCode.toString().toLowerCase().contains(itemCode.toString().toLowerCase())&&
                      element.qrdocEntry.toString().toLowerCase().contains(qrDocentry.toString().toLowerCase())&&
                      element.qrLine.toString().toLowerCase().contains(qrLine.toString().toLowerCase())
                  ).map((list) =>
                  DataRow(cells: [
                    DataCell(
                      Text(list.itemCode.toString(), textAlign: TextAlign.center),
                    ),
                    DataCell(
                      Text(list.bundle.toString(), textAlign: TextAlign.center),
                    ),
                    DataCell(
                      Text(list.Qty, textAlign: TextAlign.center),
                    ),


                  ]),
                  )
                  .toList(),
                ) : Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text('No Data',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: ColorsValue.primaryColor
                    ),)),
            ))
        ),
      ),
    );

  }


  postSave() {

    var bookingitem = "";
    var bookingitem1 = "";

    for (int i = 0; i < secSalesOrdersItemList.length; i++) {
      if(double.parse(secSalesOrdersItemList[i].disatchedQty.toString())>0 ){

      bookingitem = bookingitem +
          "<Table1>"
              "<DocNo>${0}</DocNo>"
              "<ItemCode>${secSalesOrdersItemList[i].itemCode.toString()}</ItemCode>"
              "<ItemName>${secSalesOrdersItemList[i].itemCode.toString()}</ItemName>"
              "<ActualQty>${secSalesOrdersItemList[i].actualQty.toString()}</ActualQty>"
              "<DispatchedQty>${secSalesOrdersItemList[i].disatchedQty.toString()}</DispatchedQty>"
              "<BalancedQty>${secSalesOrdersItemList[i].blanceQty.toString()}</BalancedQty>"
              "<Status>${secSalesOrdersItemList[i].status.toString()}</Status>"
              "<PickDocNo>${secSalesOrdersItemList[i].pickDocNo.toString()}</PickDocNo>"
              "<QrdocEntry>${secSalesOrdersItemList[i].qrdocEntry.toString()}</QrdocEntry>"
              "<Bundle>${secSalesOrdersItemList[i].bundle.toString()}</Bundle>"
              "<ProductNo>${secSalesOrdersItemList[i].productNo.toString()}</ProductNo>"
              "<LineID>${secSalesOrdersItemList[i].lineID.toString()}</LineID></Table1>";

    }
    }
    for (int j = 0; j < secSalesOrdersBatchList.length; j++) {
        bookingitem1 = bookingitem1 +
            "<Table1>"
                "<DocNo>${0}</DocNo>"
                "<PickDocNo>${secSalesOrdersBatchList[j].pickDocNo.toString()}</PickDocNo>"
                "<QrdocEntry>${secSalesOrdersBatchList[j].qrdocEntry.toString()}</QrdocEntry>"
                "<Bundle>${secSalesOrdersBatchList[j].bundle.toString()}</Bundle>"
                "<ProductNo>${secSalesOrdersBatchList[j].productNo.toString()}</ProductNo>"
                "<ItemCode>${secSalesOrdersBatchList[j].itemCode.toString()}</ItemCode>"
                "<Qty>${secSalesOrdersBatchList[j].Qty.toString()}</Qty>"
                "<LineID>${secSalesOrdersBatchList[j].lineID.toString()}</LineID></Table1>";

    }


    bookingitem = "<NewDataSet>$bookingitem</NewDataSet>";
    bookingitem1 = "<NewDataSet>$bookingitem1</NewDataSet>";
    update();




    api_call.insertDespatched_tbl(1,
        cardCodeCtr.text,
        salesDocEntryctr.text,
        "1",
        salesvechaleno.text,
        "C",
        bookingitem,
        secSalesOrdersItemList.isEmpty ? 0 : 1,
        bookingitem1,
        secSalesOrdersBatchList.isEmpty ? 0 : 1,
    true).then((value) => {
      if(value.statusCode==200){
        //print(value.body),
        Utility.closeLoader(),
        update(),

        Utility.showDialaogboxSaved(
        Get.context,
        jsonDecode(value.body)["result"][0]["Message"].toString()+"\n"+
        jsonDecode(value.body)["result"][0]["Message1"].toString(),
        //jsonDecode(value.body)['result'][0]['empID'].toString(),
        "Saved.."),
      }else {
        Utility.closeLoader(),
        update(),
      }

    });

  }


  void saveResponseDialog(String message, int typeofMessage) async {
    //print("inside onpendialog func");
    //print("inside showLoader");
    Utility.closeDialog();
    Utility.closeLoader();
    await Get.dialog(
      Center(
        child: Container(
          width: Get.width/1.3,
          height: Get.height/2.7,
          decoration: BoxDecoration(
              color: ColorsValue.brilliantWhiteColor,
              borderRadius: BorderRadius.all(Radius.circular(Get.width/20))
          ),
          // color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: Get.height/40),
                child: typeofMessage==0 ? Center(child: Lottie.asset("assets/save_anim.json",
                    height: Get.height/8)) :
                Center(child: Lottie.asset("assets/warning_anim.json",
                    height: Get.height/8)),
              ),
              Container(
                margin: EdgeInsets.only(top: Get.height/60),
                // child: Text(
                //   "Success...",
                //   style: TextStyle(
                //       color: ColorsValue.blackcolor,
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold
                //   ),
                // ),
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                        color: ColorsValue.blackcolor,
                        fontSize: Get.height/35,
                        fontWeight: FontWeight.bold
                    ),
                    child: typeofMessage ==0 ? const Text("Success") : const Text("Warning"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Get.height/80),
                // child: Text(
                //   "Success...",
                //   style: TextStyle(
                //       color: ColorsValue.blackcolor,
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold
                //   ),
                // ),
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                        color: ColorsValue.blackcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400
                    ),
                    child: Center(child: Text(message.toString(),
                      textAlign: TextAlign.center,)),
                    // Text("Data Posted Successfully..."),

                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Get.back<void>();
                  Get.back();
                  //pageRefresh();
                  update();
                },
                child: Container(
                  margin: EdgeInsets.only(top: Get.height/40),
                  height: Get.height/20,
                  width: Get.width/5,
                  decoration: BoxDecoration(
                      color: ColorsValue.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(Get.width/25))
                  ),
                  child: const DefaultTextStyle(
                    style: TextStyle(
                        color: ColorsValue.brilliantWhiteColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 18
                    ),
                    child: Center(child: Text("Okay")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
    /*await Get.defaultDialog(
        title: "Success",
        middleText: "Data Posted Successfully...",
        backgroundColor: ColorsValue.brilliantWhiteColor,
        titleStyle: TextStyle(color: ColorsValue.blackcolor),
        middleTextStyle: TextStyle(color: ColorsValue.blackcolor),
        radius: 30,
        barrierDismissible: false,
        actions: [
          GestureDetector(
            onTap: () {
              print("Okay Pressed");
              Get.back<void>();
              reloadScreen();
            },
            child: Container(
                height: Get.height/20,
                width: Get.width/3.7,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(Get.width/20))
                ),
                child: Center(
                  child: Text("Okay",
                    style: TextStyle(
                      color: ColorsValue.brilliantWhiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.height/35,
                    ),),
                )
            ),
          )
        ],
    );*/
  }


  List<BundalScreen> secBundalScreen = [];




  Future<void> comonscanBarcode() async {
    String barcodeScanRes;
    double qty=0;
    double oldqty=0;
    int count =0;
    int insetbatch=0;
    int newBarcode=0;
    double actualoldqty =0;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      //print(barcodeScanRes);

      update();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    final decode = jsonDecode(barcodeScanRes);
    update();


    // var barcodeScanRes;
    // barcodeScanRes ={
    //   "Header Item":"000021",
    //   "ItemCode":"",
    //   "Date":"20240213",
    //   "Quality":"BLN-BlissLine",
    //   "Length":"15",
    //   "Width":"15",
    //   "Thickness":"3",
    //   "MRP":"",
    //   "Weight":"",
    //   "StoragePayNo":"",
    //   "QRDocEntry":"87",
    //   "LineID":"1",
    //   "Bundle":"DRB/PLG/1027",
    // };
    // double qty=0;
    // double oldqty=0;
    // int count =0;
    // int insetbatch=0;
    print(decode["Bundle"].toString());
    print(decode["QRDocEntry"].toString());
    print(decode["LineID"].toString());
    //print(jsonDecode(jsonEncode(barcodeScanRes)));
    update();

    api_call.getAllMaster(5, "soNo", decode["Bundle"].toString(), "userId", "cardCode", "status", true).then((value) => {

      if(value.statusCode==200){
        print(value.body),
        if(jsonDecode(value.body)["status"].toString()=="0"){
          Utility.showDialaogboxWarning(Get.context, "message", "Warning"),
          Utility.closeLoader(),
          update(),
        }else{
          Utility.closeLoader(),
          update(),

          //print(jsonDecode(value.body)["result"][0]["Qty"].toString()),
          if(jsonDecode(value.body)["result"][0]["Status"].toString()=="S"){
            if(jsonDecode(value.body)["result"][0]["Qty"].toString()=="0"){
              count=2,
              update(),
            }else{
              for(int j=0;j<secSalesOrdersItemList.length;j++){
                print("For - 1"),
                if(secSalesOrdersItemList[j].itemCode == jsonDecode(value.body)["result"][0]["ItemCode"].toString()
                 && secSalesOrdersItemList[j].qrdocEntry1.toString()==jsonDecode(value.body)["result"][0]["QRDocEntry"].toString()
                 && secSalesOrdersItemList[j].qrlineID.toString()==jsonDecode(value.body)["result"][0]["QRLine"].toString()
                ){
                  newBarcode =1,
                  update(),
                  print("For - 2"),

                  if(secSalesOrdersBatchList.isEmpty){
                    print("For - 3"),
                    qty = double.parse(jsonDecode(value.body)["result"][0]["Qty"].toString()),
                    oldqty = double.parse(secSalesOrdersItemList[j].disatchedQty.toString()),
                    secSalesOrdersItemList[j].disatchedQty = (qty + oldqty).toString(),

                    secSalesOrdersItemList[j].pickDocNo = jsonDecode(value.body)["result"][0]["DocNo"].toString(),
                    secSalesOrdersItemList[j].qrdocEntry = jsonDecode(value.body)["result"][0]["QRDocEntry"].toString(),
                    secSalesOrdersItemList[j].bundle = decode["Bundle"].toString(),
                    secSalesOrdersItemList[j].productNo = jsonDecode(value.body)["result"][0]["ProductNo"].toString(),
                    secSalesOrdersItemList[j].lineID = jsonDecode(value.body)["result"][0]["LineID"].toString(),
                    secSalesOrdersBatchList.add(SalesOrdersBatchList(
                        jsonDecode(value.body)["result"][0]["ItemCode"].toString(),
                        jsonDecode(value.body)["result"][0]["DocNo"].toString(),
                        decode["QRDocEntry"].toString().toLowerCase(),
                        decode["Bundle"].toString(),
                        jsonDecode(value.body)["result"][0]["ProductNo"].toString(),
                        jsonDecode(value.body)["result"][0]["Qty"].toString(),
                        decode["LineID"].toString().toLowerCase(),
                        jsonDecode(value.body)["result"][0]["QRLine"].toString()
                    ),),
                    count = 1,
                    update(),
                  }
                  else {
                    print("For - 8"),
                    print(jsonDecode(value.body)["result"][0]["Bundle"].toString()),

                    for(int k = 0; k < secSalesOrdersBatchList.length; k++){
                      if(secSalesOrdersBatchList[k].bundle.toString().toLowerCase() == decode["Bundle"].toString().toLowerCase()){
                        insetbatch=2,
                        update(),
                      }
                    },

                    if(insetbatch==2){
                      count=0,
                      print("For - 9"),
                      update(),

                    }else{
                      print("For - 10"),
                      qty = double.parse(jsonDecode(value.body)["result"][0]["Qty"].toString()),
                      oldqty = double.parse(secSalesOrdersItemList[j].disatchedQty.toString()),
                      actualoldqty = double.parse(secSalesOrdersItemList[j].actualQty.toString()),

                      if(secSalesOrdersItemList[j].status==1){
                        secSalesOrdersItemList[j].actualQty = (qty+actualoldqty).toString(),
                      },



                      secSalesOrdersItemList[j].disatchedQty = (qty + oldqty).toString(),
                      secSalesOrdersItemList[j].blanceQty = (double.parse(secSalesOrdersItemList[j].actualQty.toString()) -
                          double.parse(secSalesOrdersItemList[j].disatchedQty.toString())).toString(),

                      secSalesOrdersItemList[j].pickDocNo = jsonDecode(value.body)["result"][0]["DocNo"].toString(),
                      secSalesOrdersItemList[j].qrdocEntry = decode["QRDocEntry"].toString().toLowerCase(),
                      secSalesOrdersItemList[j].bundle = decode["Bundle"].toString(),
                      secSalesOrdersItemList[j].productNo = jsonDecode(value.body)["result"][0]["ProductNo"].toString(),
                      secSalesOrdersItemList[j].lineID = jsonDecode(value.body)["result"][0]["LineID"].toString(),
                      secSalesOrdersBatchList.add(SalesOrdersBatchList(
                          jsonDecode(value.body)["result"][0]["ItemCode"].toString(),
                          jsonDecode(value.body)["result"][0]["DocNo"].toString(),
                          decode["QRDocEntry"].toString().toLowerCase(),
                          decode["Bundle"].toString(),
                          jsonDecode(value.body)["result"][0]["ProductNo"].toString(),
                          jsonDecode(value.body)["result"][0]["Qty"].toString(),
                          decode["LineID"].toString().toLowerCase(),jsonDecode(value.body)["result"][0]["QRLine"].toString()),),
                      count = 1,
                      update(),
                    }
                  }
                }
              },
              if(newBarcode==0){


                secSalesOrdersItemList.add(SalesOrdersItemList(
                  jsonDecode(value.body)["result"][0]["ItemCode"].toString(),//itemCode,
                  jsonDecode(value.body)["result"][0]["ItemName"].toString(),//itemName,
                  jsonDecode(value.body)["result"][0]["Qty"].toString(),//actualQty,
                  jsonDecode(value.body)["result"][0]["Qty"].toString(),//disatchedQty,
                  "0",//blanceQty,
                  1,//status,
                  jsonDecode(value.body)["result"][0]["DocNo"].toString(),//pickDocNo,
                  jsonDecode(value.body)["result"][0]["QRDocEntry"].toString(),//qrdocEntry,
                  decode["Bundle"].toString(),//bundle,
                  jsonDecode(value.body)["result"][0]["ProductNo"].toString(),//productNo,
                  jsonDecode(value.body)["result"][0]["LineID"].toString(),"","",//lineID,
                ),),
                secSalesOrdersBatchList.add(SalesOrdersBatchList(
                    jsonDecode(value.body)["result"][0]["ItemCode"].toString(),
                    jsonDecode(value.body)["result"][0]["DocNo"].toString(),
                    decode["QRDocEntry"].toString().toLowerCase(),
                    decode["Bundle"].toString(),
                    jsonDecode(value.body)["result"][0]["ProductNo"].toString(),
                    jsonDecode(value.body)["result"][0]["Qty"].toString(),
                    decode["LineID"].toString().toLowerCase(),jsonDecode(value.body)["result"][0]["QRLine"].toString()),),
                count=1,
                update(),

              }
            },



          }
          else {
            count=1,
            Utility.closeLoader(),
            update(),
            Utility.showDialaogboxWarning(Get.context,jsonDecode(value.body)["result"][0]["Message"], "Warning"),

          },

          //print(secSalesOrdersBatchList.length),
          print(jsonEncode(secSalesOrdersBatchList)),

          if(count==0){
            Utility.showDialaogboxWarning(Get.context,"QRCode Already Scaned.. ", "Warning"),
          }else if(count==2){
            Utility.showDialaogboxWarning(Get.context,"Qty is Zero UOM is Mismatched..", "Warning"),
          }

        }

      }else {

      }

    });

    update();
  }

  Future<void> scanBarcode(int indexValue) async {
    String barcodeScanRes;
    double qty=0;
    double oldqty=0;
    int count =0;
    int insetbatch=0;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      //print(barcodeScanRes);

      update();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    final decode = jsonDecode(barcodeScanRes);
    update();


    // var barcodeScanRes;
    // barcodeScanRes ={
    //   "Header Item":"000021",
    //   "ItemCode":"",
    //   "Date":"20240213",
    //   "Quality":"BLN-BlissLine",
    //   "Length":"15",
    //   "Width":"15",
    //   "Thickness":"3",
    //   "MRP":"",
    //   "Weight":"",
    //   "StoragePayNo":"",
    //   "QRDocEntry":"87",
    //   "LineID":"1",
    //   "Bundle":"DRB/PLG/1027",
    // };
    // double qty=0;
    // double oldqty=0;
    // int count =0;
    // int insetbatch=0;
    print(decode["Bundle"].toString());
    //print(jsonDecode(jsonEncode(barcodeScanRes)));
    update();

    api_call.getAllMaster(5, "soNo", decode["QRDocEntry"].toString(), "userId", "cardCode", "status", true).then((value) => {
      if(value.statusCode==200){
        print(value.body),
        if(jsonDecode(value.body)["status"].toString()=="0"){
          Utility.showDialaogboxWarning(Get.context, "message", "Warning"),
          Utility.closeLoader(),
          update(),
        }else{
          Utility.closeLoader(),
          update(),

          //print(jsonDecode(value.body)["result"][0]["Qty"].toString()),
          if(jsonDecode(value.body)["result"][0]["Status"].toString()=="S"){
            if(jsonDecode(value.body)["result"][0]["Qty"].toString()=="0"){
              count=2,
              update(),
            }else{
              for(int j=0;j<secSalesOrdersItemList.length;j++){
                print("For - 1"),
                if(secSalesOrdersItemList[j].itemCode == jsonDecode(value.body)["result"][0]["ItemCode"].toString()){
                  print("For - 2"),

                  if(secSalesOrdersBatchList.isEmpty){
                    print("For - 3"),
                    qty = double.parse(jsonDecode(value.body)["result"][0]["Qty"].toString()),
                    oldqty = double.parse(secSalesOrdersItemList[j].disatchedQty.toString()),
                    secSalesOrdersItemList[j].disatchedQty = (qty + oldqty).toString(),

                    secSalesOrdersItemList[j].pickDocNo = jsonDecode(value.body)["result"][0]["DocNo"].toString(),
                    secSalesOrdersItemList[j].qrdocEntry = jsonDecode(value.body)["result"][0]["QRDocEntry"].toString(),
                    secSalesOrdersItemList[j].bundle = decode["Bundle"].toString(),
                    secSalesOrdersItemList[j].productNo = jsonDecode(value.body)["result"][0]["ProductNo"].toString(),
                    secSalesOrdersItemList[j].lineID = jsonDecode(value.body)["result"][0]["LineID"].toString(),
                    secSalesOrdersBatchList.add(SalesOrdersBatchList(
                        jsonDecode(value.body)["result"][0]["ItemCode"].toString(),
                        jsonDecode(value.body)["result"][0]["DocNo"].toString(),
                        decode["QRDocEntry"].toString().toLowerCase(),
                        decode["Bundle"].toString(),
                        jsonDecode(value.body)["result"][0]["ProductNo"].toString(),
                        jsonDecode(value.body)["result"][0]["Qty"].toString(),
                        decode["LineID"].toString().toLowerCase(),jsonDecode(value.body)["result"][0]["QRLine"].toString()),),
                    count = 1,
                    update(),
                  }
                  else {
                    print("For - 8"),
                    print(jsonDecode(value.body)["result"][0]["Bundle"].toString()),

                    for(int k = 0; k < secSalesOrdersBatchList.length; k++){
                      if(secSalesOrdersBatchList[k].bundle.toString().toLowerCase() == decode["Bundle"].toString().toLowerCase()){
                        insetbatch=2,
                        update(),
                      }
                    },

                    if(insetbatch==2){
                      count=0,
                      print("For - 9"),
                      update(),

                    }else{
                      print("For - 10"),
                      qty = double.parse(jsonDecode(value.body)["result"][0]["Qty"].toString()),
                      oldqty = double.parse(secSalesOrdersItemList[j].disatchedQty.toString()),
                      secSalesOrdersItemList[j].disatchedQty = (qty + oldqty).toString(),
                      secSalesOrdersItemList[j].blanceQty = (double.parse(secSalesOrdersItemList[j].actualQty.toString()) -
                          double.parse(secSalesOrdersItemList[j].disatchedQty.toString())).toString(),

                      secSalesOrdersItemList[j].pickDocNo = jsonDecode(value.body)["result"][0]["DocNo"].toString(),
                      secSalesOrdersItemList[j].qrdocEntry = decode["QRDocEntry"].toString().toLowerCase(),
                      secSalesOrdersItemList[j].bundle = decode["Bundle"].toString(),
                      secSalesOrdersItemList[j].productNo = jsonDecode(value.body)["result"][0]["ProductNo"].toString(),
                      secSalesOrdersItemList[j].lineID = jsonDecode(value.body)["result"][0]["LineID"].toString(),
                      secSalesOrdersBatchList.add(SalesOrdersBatchList(
                          jsonDecode(value.body)["result"][0]["ItemCode"].toString(),
                          jsonDecode(value.body)["result"][0]["DocNo"].toString(),
                          decode["QRDocEntry"].toString().toLowerCase(),
                          decode["Bundle"].toString(),
                          jsonDecode(value.body)["result"][0]["ProductNo"].toString(),
                          jsonDecode(value.body)["result"][0]["Qty"].toString(),
                          decode["LineID"].toString().toLowerCase(),jsonDecode(value.body)["result"][0]["QRLine"].toString()),),
                      count = 1,
                      update(),
                    }
                  }
                }
              },
            },



          }
          else {
            count=1,
            Utility.closeLoader(),
            update(),
            Utility.showDialaogboxWarning(Get.context,jsonDecode(value.body)["result"][0]["Message"], "Warning"),

          },

          //print(secSalesOrdersBatchList.length),
          print(jsonEncode(secSalesOrdersBatchList)),

          if(count==0){
            Utility.showDialaogboxWarning(Get.context,"QRCode Already Scaned.. ", "Warning"),
          }else if(count==2){
            Utility.showDialaogboxWarning(Get.context,"Qty is Zero UOM is Mismatched..", "Warning"),
          }

        }

      }else {

      }

    });

    update();
  }

  scanBarcode1(soNo,date,qty,length,width,thickness,noofSheet,weight,
      bundles,salesEntry,qrEntry,lineId,itemcode,itemname, int indexvalue){
    //print("gvffyhfufgghjg : "+bundles.toString());
    var salesOrder = TextEditingController();
    var itemCode = TextEditingController();
    var itemDis = TextEditingController();
    var qtyct = TextEditingController();
    var actualwight = TextEditingController();
    var bundleNo = TextEditingController();
    salesOrder.text=soNo.toString();
    itemCode.text=itemcode.toString();
    itemDis.text=itemname.toString();
    update();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: Constants.padding,
                  top: Constants.avatarRadius + Constants.padding,
                  right: Constants.padding,
                  bottom: Constants.padding),
              margin: const EdgeInsets.only(top: Constants.avatarRadius),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.padding),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
                  ]),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: TextField(
                        controller: salesOrder,
                        readOnly: true,
                        decoration:  const InputDecoration(
                          labelText: "SO No",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2,),
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: TextField(
                        controller: itemCode,
                        readOnly: true,
                        decoration:  const InputDecoration(
                          labelText: "ItemCode",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2,),
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: TextField(
                        controller: itemDis,
                        readOnly: true,
                        decoration:  const InputDecoration(
                          labelText: "Description",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2,),
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: TextField(
                        controller: qtyct,
                        decoration:  const InputDecoration(
                          labelText: "Qty",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2,),
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: TextField(
                        controller: actualwight,
                        decoration:  const InputDecoration(
                          hintText: "Actual Weight",
                          labelText: "Actual Weight",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2,),
                    SizedBox(
                      height: 60,
                      width: 300,
                      child:  TextField(
                        controller: bundleNo,
                        decoration:  const InputDecoration(
                          labelText: "Bundle No",
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {

                          // qtyct

                          double value = double.parse(qtyct.text.toString());

                          if (secSalesOrdersItemList[indexvalue].actualQty<value) {
                            saveResponseDialog("Actual Qty Should Greater than Dispatch Qty.!!", 1);
                            // Utility.showMessage("Actual Qty Should Greater than Dispatch Qty.!!",
                            //     TypeOfMessage.error, () => null, "Okay");
                          } else {

                            secSalesOrdersItemList[indexvalue].disatchedQty=double.parse(qtyct.text.toString());

                            double sum_value = secSalesOrdersItemList[indexvalue].actualQty - value;

                            secSalesOrdersItemList[indexvalue].blanceQty = sum_value;
                            Get.back();
                            update();
                          }



                          // secBundalScreen.add(
                          //   BundalScreen(
                          //     soNo, // salesNo
                          //     date, // date
                          //     qtyct.text,//Qty
                          //     length,//length
                          //     width, //Width,
                          //     thickness, //Thickness,
                          //     noofSheet, //NoofSheets,
                          //     actualwight.text, //Weight,
                          //     bundleNo.text, //Bundles
                          //     salesEntry, //SalesEntry
                          //     qrEntry, //QREntry
                          //     lineId, //LineId
                          //     itemcode, //ItemCode
                          //     itemname, //ItemName
                          //   ),);
                          // Get.back();
                          update();
                        },
                        child: const Text("Ok", style: TextStyle(fontSize: 18, color: Colors.black),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   removeListSales(int indexOf) {

    secSalesOrdersBatchList.removeWhere((element) => element.pickDocNo == secSalesOrdersItemList[indexOf].pickDocNo);
    secSalesOrdersItemList.removeAt(indexOf);
    update();
   }

   serchSpareDetalies(String vvv) {

secCardCodeList.clear();

       update();



   }

}

class CardCodeList {
  String? cardCode;
  String? cardName;
  CardCodeList(this.cardCode, this.cardName);
}

class SalesOrderList {
  int? docNum;
  int? docEntry;
  String? cardCode;
  SalesOrderList(this.docNum, this.docEntry, this.cardCode);
}

class SalesOrdersItemList {
  String? itemCode;
  String? itemName;
  var actualQty;
  var disatchedQty;
  var blanceQty;
  var status;
  var pickDocNo;
  var qrdocEntry;
  var bundle;
  var productNo;
  var lineID;
  var qrdocEntry1;
  var qrlineID;

  SalesOrdersItemList(this.itemCode, this.itemName, this.actualQty,this.disatchedQty,this.blanceQty,this.status,
      this.pickDocNo,this.qrdocEntry,this.bundle,this.productNo,this.lineID,this.qrdocEntry1,this.qrlineID);

}

class SalesOrdersBatchList {
  var itemCode;
  var pickDocNo;
  var qrdocEntry;
  var bundle;
  var productNo;
  var Qty;
  var lineID;
  var qrLine;

  SalesOrdersBatchList(this.itemCode,this.pickDocNo,this.qrdocEntry,this.bundle,this.productNo,this.Qty,this.lineID,this.qrLine);

  SalesOrdersBatchList.fromJson(Map<String, dynamic> json) {
    itemCode = json['itemCode'];
    pickDocNo = json['pickDocNo'];
    qrdocEntry = json['qrdocEntry'];
    bundle = json['bundle'];
    productNo = json['productNo'];
    Qty = json['Qty'];
    lineID = json['lineID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemCode'] = itemCode;
    data['pickDocNo'] = pickDocNo;
    data['qrdocEntry'] = qrdocEntry;
    data['bundle'] = bundle;
    data['productNo'] = productNo;
    data['Qty'] = Qty;
    data['lineID'] = lineID;
    return data;
  }

}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}