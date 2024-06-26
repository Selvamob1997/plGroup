// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pl_groups/app/modules/packing_screen_module/packing_screen_controller.dart';
import 'package:pl_groups/app/theme/colors_value.dart';
import 'package:pl_groups/app/utils/dimens.dart';


class packingScreenPage extends GetView<packingScreenController> {
  const packingScreenPage({super.key});



  @override
  Widget build(BuildContext context) {
    return GetBuilder<packingScreenController>(builder: (dispatchCntrlr){
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            //centerTitle: true,
            title:  const Text("Packing"),
            backgroundColor: ColorsValue.primaryColor,
            actions: [
              IconButton(
                  onPressed: (){
                    dispatchCntrlr.selectDelete();
                  },
                  icon: const Icon(Icons.delete,color: Colors.white,))
            ],
          ),
          body: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    dispatchCntrlr.scanBarcode();
                  },
                  child: Container(
                    height: height/20,
                    width: width,
                    margin: EdgeInsets.only(top: Dimens.eight, right: Dimens.five, left: Dimens.five),
                    decoration: BoxDecoration(
                      color: ColorsValue.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(Dimens.twenty)),
                    ),
                    child: const Center(
                      child: Text("Scan Qr",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                ),
              SizedBox(height: height/100,),

              SizedBox(
                height: height/1.4,
                width: width/1.1,
                child: ListView.builder(
                  itemCount: dispatchCntrlr.secBundalScreen.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onLongPress: (){
                        dispatchCntrlr.myListselect(index);
                        //print("object");
                      },
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(width / 30)),
                          gradient: LinearGradient(
                            colors: dispatchCntrlr.secBundalScreen[index].selected==0?[
                              Colors.blue.shade50,
                              Colors.blue.shade100,

                            ]:[Colors.blue.shade400,
                              Colors.blue.shade500,],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ListTile(
                          title: Text(dispatchCntrlr.secBundalScreen[index].productCode),
                          dense: true,
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: height/30,
                                    width: width/3,
                                    alignment: Alignment.centerLeft,
                                    child: Text("ItemCode",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                  ),
                                  SizedBox(
                                    width: width/100,
                                    child: const Text(":"),
                                  ),
                                  Container(
                                    height: height/30,
                                    width: width/2.2,
                                    margin: const EdgeInsets.only(left: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(dispatchCntrlr.secBundalScreen[index].itemCode,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500,fontSize: height/70),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: height/30,
                                    width: width/3,
                                    alignment: Alignment.centerLeft,
                                    child: Text("Date",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                  ),
                                  SizedBox(
                                    width: width/100,
                                    child: const Text(":"),
                                  ),
                                  Container(
                                    height: height/30,
                                    width: width/2.2,
                                    margin: const EdgeInsets.only(left: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(dispatchCntrlr.secBundalScreen[index].date,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: dispatchCntrlr.secBundalScreen[index].varible1Name==""?false:true,
                                child: InkWell(
                                  onTap: (){
                                    dispatchCntrlr.showenterinput(
                                        dispatchCntrlr.secBundalScreen[index].productCode,
                                        dispatchCntrlr.secBundalScreen[index].varible1Name,
                                        index,"varible1Name"
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible1Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible1,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: dispatchCntrlr.secBundalScreen[index].varible2Name==""?false:true,
                                child: InkWell(
                                  onTap: (){
                                    dispatchCntrlr.showenterinput(
                                        dispatchCntrlr.secBundalScreen[index].productCode,
                                        dispatchCntrlr.secBundalScreen[index].varible2Name,
                                        index,"varible2Name"
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible2Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible2,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: dispatchCntrlr.secBundalScreen[index].varible3Name==""?false:true,
                                child: InkWell(
                                  onTap: (){
                                    dispatchCntrlr.showenterinput(
                                        dispatchCntrlr.secBundalScreen[index].productCode,
                                        dispatchCntrlr.secBundalScreen[index].varible3Name,
                                        index,"varible3Name"
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible3Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible3,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: dispatchCntrlr.secBundalScreen[index].varible4Name==""?false:true,
                                child: InkWell(
                                  onTap: (){
                                    dispatchCntrlr.showenterinput(
                                        dispatchCntrlr.secBundalScreen[index].productCode,
                                        dispatchCntrlr.secBundalScreen[index].varible4Name,
                                        index,"varible4Name"
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible4Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible4,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: dispatchCntrlr.secBundalScreen[index].varible5Name==""?false:true,
                                child: InkWell(
                                  onTap: (){
                                    dispatchCntrlr.showenterinput(
                                        dispatchCntrlr.secBundalScreen[index].productCode,
                                        dispatchCntrlr.secBundalScreen[index].varible5Name,
                                        index,"varible5Name"
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible5Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible5,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: dispatchCntrlr.secBundalScreen[index].varible6Name==""?false:true,
                                child: InkWell(
                                  onTap: (){
                                    dispatchCntrlr.showenterinput(
                                        dispatchCntrlr.secBundalScreen[index].productCode,
                                        dispatchCntrlr.secBundalScreen[index].varible6Name,
                                        index,"varible6Name"
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible6Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible6,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: dispatchCntrlr.secBundalScreen[index].varible7Name==""?false:true,
                                child: InkWell(
                                  onTap: (){
                                    dispatchCntrlr.showenterinput(
                                        dispatchCntrlr.secBundalScreen[index].productCode,
                                        dispatchCntrlr.secBundalScreen[index].varible7Name,
                                        index,"varible7Name"
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible7Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible7,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: dispatchCntrlr.secBundalScreen[index].varible8Name==""?false:true,
                                child: InkWell(
                                  onTap: (){
                                    dispatchCntrlr.showenterinput(
                                        dispatchCntrlr.secBundalScreen[index].productCode,
                                        dispatchCntrlr.secBundalScreen[index].varible8Name,
                                        index,"varible8Name"
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible8Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible8,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: dispatchCntrlr.secBundalScreen[index].varible9Name==""?false:true,
                                child: InkWell(
                                  onTap: (){
                                    dispatchCntrlr.showenterinput(
                                        dispatchCntrlr.secBundalScreen[index].productCode,
                                        dispatchCntrlr.secBundalScreen[index].varible9Name,
                                        index,"varible9Name"
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible9Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible9,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: dispatchCntrlr.secBundalScreen[index].varible10Name==""?false:true,
                                child: InkWell(
                                  onTap: (){
                                    dispatchCntrlr.showenterinput(
                                        dispatchCntrlr.secBundalScreen[index].productCode,
                                        dispatchCntrlr.secBundalScreen[index].varible10Name,
                                        index,"varible10Name"
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible10Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible10,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  dispatchCntrlr.showenterinput(
                                      dispatchCntrlr.secBundalScreen[index].productCode,
                                      dispatchCntrlr.secBundalScreen[index].varible11Name,
                                      index,"varible11Name"
                                  );
                                },
                                child: Visibility(
                                  visible: dispatchCntrlr.secBundalScreen[index].varible11Name==""?false:true,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible11Name,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].varible11,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: (){
                                  dispatchCntrlr.showenterinput(
                                      dispatchCntrlr.secBundalScreen[index].productCode,
                                      "StorageBayNo",
                                      index,"StorageBayNo"
                                  );
                                },
                                child: Row(
                                    children: [
                                      Container(
                                        height: height/30,
                                        width: width/3,
                                        alignment: Alignment.centerLeft,
                                        child: Text("StorageBayNo",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                      ),
                                      SizedBox(
                                        width: width/100,
                                        child: const Text(":"),
                                      ),
                                      Container(
                                        height: height/30,
                                        width: width/2.2,
                                        margin: const EdgeInsets.only(left: 5),
                                        alignment: Alignment.centerLeft,
                                        child: Text(dispatchCntrlr.secBundalScreen[index].storagePayNo,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                      ),
                                    ],
                                  ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: height/30,
                                    width: width/3,
                                    alignment: Alignment.centerLeft,
                                    child: Text("QRDocEntry",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                  ),
                                  SizedBox(
                                    width: width/100,
                                    child: const Text(":"),
                                  ),
                                  Container(
                                    height: height/30,
                                    width: width/2.2,
                                    margin: const EdgeInsets.only(left: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(dispatchCntrlr.secBundalScreen[index].qrdocEntry,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: height/30,
                                    width: width/3,
                                    alignment: Alignment.centerLeft,
                                    child: Text("LineID",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                  ),
                                  SizedBox(
                                    width: width/100,
                                    child: const Text(":"),
                                  ),
                                  Container(
                                    height: height/30,
                                    width: width/2.2,
                                    margin: const EdgeInsets.only(left: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(dispatchCntrlr.secBundalScreen[index].lineID,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: height/30,
                                    width: width/3,
                                    alignment: Alignment.centerLeft,
                                    child: Text("Bundle",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: height/70),),
                                  ),
                                  SizedBox(
                                    width: width/100,
                                    child: const Text(":"),
                                  ),
                                  Container(
                                    height: height/30,
                                    width: width/2.2,
                                    margin: const EdgeInsets.only(left: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(dispatchCntrlr.secBundalScreen[index].bundle,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500,fontSize: height/70),),
                                  ),
                                ],
                              ),
                              SizedBox(height: height/50,),
                              Row(
                                children: [
                                  Container(
                                    height: height/30,
                                    width: width/3,
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      onPressed: () {

                                        dispatchCntrlr.getData(index);


                                      },
                                      icon: const Icon(Icons.production_quantity_limits_outlined,color: Colors.redAccent,),),
                                  ),
                                  SizedBox(
                                    width: width/100,
                                    //child: Text(":"),
                                  ),
                                  SizedBox(
                                    height: height/30,
                                    width: width/2.2,
                                    //margin: const EdgeInsets.only(left: 5),
                                    //alignment: Alignment.centerLeft,

                                  ),
                                ],
                              ),
                              SizedBox(height: height/50,),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )



            ],
          ),
          persistentFooterButtons: [


            GestureDetector(
              onTap: () {
                dispatchCntrlr.postSave();
              },
              child: Container(
                height: height / 18,
                // width: width / 2.5,
                width: width,
                decoration: BoxDecoration(
                    color: ColorsValue.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(width / 30)),
                ),
                child: Container(
                  margin: EdgeInsets.all(Dimens.three),
                  decoration: BoxDecoration(
                    // color: Colour_configs.white_clr,
                      borderRadius:
                      BorderRadius.all(Radius.circular(width / 30)),
                      border: Border.all(
                          color: ColorsValue.backgroundColor, width: Dimens.two)),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: ColorsValue.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),





          ],

        ),
      );
    });
  }



}
