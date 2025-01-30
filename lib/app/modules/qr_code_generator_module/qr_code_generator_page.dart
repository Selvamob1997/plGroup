import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pl_groups/app/modules/qr_code_generator_module/qr_code_generator_controller.dart';

import '../../theme/colors_value.dart';
import '../../utils/dimens.dart';


class QrCodeGeneratorPage extends GetView<QrCodeGeneratorController> {
  const QrCodeGeneratorPage({super.key});

  @override
  Widget build(BuildContext context)=>GetBuilder<QrCodeGeneratorController>(builder: (myController) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: ()=>myController.onWillPop(context),
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              //centerTitle: true,
              title:  const Text("QR Live Print"),
              backgroundColor: ColorsValue.primaryColor,
            ),
            body: SizedBox(
                height: height/1.1,
                width: width,
                child: PageView(
                  controller: myController.pagecontroller,
                  pageSnapping: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: height/2,
                      width: width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            SizedBox(height: height/80,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: width/2.1,
                                  height: height/18,
                                  child:  TextField(
                                    controller: myController.orderType,
                                    readOnly: true,
                                    enableInteractiveSelection: false,
                                    style: TextStyle(fontSize: height/63),
                                    decoration: const InputDecoration(
                                      labelText: "Order Type",
                                      labelStyle: TextStyle(color: Colors.black54),
                                      contentPadding:  EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),),
                                    ),
                                    onTap: (){

                                      myController.showOrderType(context,height);
                                      //myController.showCardName();
                                    },

                                  ),),
                                Container(
                                  color: Colors.white,
                                  width: width/2.1,
                                  height: height/18,
                                  child:  TextField(
                                    controller: myController.cardName,
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: height/63),
                                    decoration: const InputDecoration(
                                        labelText: "Customer Name",
                                        labelStyle: TextStyle(color: Colors.black54),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black12),
                                          borderRadius: BorderRadius.all(Radius.circular(0)),),
                                        contentPadding: EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 15)
                                    ),
                                    onTap: (){
                                      if(myController.orderType.text == "Make To Order"){
                                        myController.showcardame1(context,height);
                                      }

                                      //myController.showCardName();
                                    },

                                  ),),
                              ],
                            ),
                            SizedBox(height: height/80,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: width/2.1,
                                  height: height/18,
                                  child:  TextField(
                                    controller: myController.branchName,
                                    readOnly: true,
                                    enableInteractiveSelection: false,
                                    style: TextStyle(fontSize: height/63),
                                    decoration: const InputDecoration(
                                      labelText: "BranchName",
                                      labelStyle: TextStyle(color: Colors.black54),
                                      contentPadding:  EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),),
                                    ),
                                    onTap: (){},
                                  ),),
                                Container(
                                  color: Colors.white,
                                  width: width/2.1,
                                  height: height/18,
                                  child:  TextField(
                                    controller: myController.productCode,
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: height/63),
                                    decoration: const InputDecoration(
                                      labelText: "ProductCode",
                                      labelStyle: TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.all(Radius.circular(0)),),
                                    ),
                                    onTap: (){
                                      myController.getProductCode(context,height);
                                    },

                                  ),),
                              ],
                            ),
                            SizedBox(height: height/100,),
                            SizedBox(
                              height: height/1.5,
                              width: width,
                              child: ListView.builder(
                                itemCount: myController.secScreenDisplaySoData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    elevation: 5,
                                    child: SizedBox(
                                      width: width,
                                      child: Column(
                                        children: [
                                          SizedBox(height: height/200,),
                                          SizedBox(
                                            height: height/23,
                                            width: width/1,
                                            //color: Colors.indigo,
                                            child: Text(
                                              myController.secScreenDisplaySoData[index].itemName.toString(),
                                              style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                          SizedBox(height: height/200,),
                                          Row(
                                            children: [
                                              Container(
                                                height: height/48,
                                                width: width/6.5,
                                                alignment: Alignment.centerLeft,
                                                child: const Text("WhsCode",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                                              ),
                                              Container(
                                                height: height/48,
                                                width: width/30,
                                                alignment: Alignment.centerLeft,
                                                child: const Text(":"),
                                              ),
                                              Container(
                                                height: height/48,
                                                width: width/3.5,
                                                alignment: Alignment.centerLeft,
                                                child: Text(myController.secScreenDisplaySoData[index].whsCode.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                              ),
                                              Container(
                                                height: height/48,
                                                width: width/6.5,
                                                alignment: Alignment.centerLeft,
                                                child: const Text("Quanty",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                                              ),
                                              Container(
                                                height: height/48,
                                                width: width/30,
                                                alignment: Alignment.centerLeft,
                                                child: const Text(":"),
                                              ),
                                              Container(
                                                height: height/48,
                                                width: width/4.2,
                                                alignment: Alignment.centerLeft,
                                                child: Text(myController.secScreenDisplaySoData[index].quantity.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: height/100,),
                                          Row(
                                            children: [
                                              Container(
                                                height: height/20,
                                                width: width/6.5,
                                                alignment: Alignment.centerLeft,
                                                child: const Text("Bundle",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                                              ),
                                              Container(
                                                height: height/35,
                                                width: width/30,
                                                alignment: Alignment.centerLeft,
                                                child: const Text(":"),
                                              ),
                                              Card(
                                                elevation: 5,
                                                child: InkWell(
                                                  onTap: (){
                                                    myController.showQty(index, "Enter The No", 1,height,width);
                                                  },
                                                  child: Container(
                                                    height: height/20,
                                                    width: width/4,
                                                    alignment: Alignment.center,
                                                    child: Text(myController.secScreenDisplaySoData[index].bundale.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: height/20,
                                                width: width/5.5,
                                                alignment: Alignment.centerLeft,
                                                child: const Text("Bundle Info",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                                              ),
                                              Container(
                                                height: height/35,
                                                width: width/30,
                                                alignment: Alignment.centerLeft,
                                                child: const Text(":"),
                                              ),
                                              Container(
                                                height: height/20,
                                                width: width/4.2,
                                                alignment: Alignment.center,
                                                child: TextButton(onPressed: () {
                                                  myController.myBundaleCal(
                                                      int.parse(myController.secScreenDisplaySoData[index].bundale.toString()),
                                                      int.parse(myController.secScreenDisplaySoData[index].quantity.toString().isEmpty?"0":myController.secScreenDisplaySoData[index].quantity.toString()),
                                                      myController.secScreenDisplaySoData[index].itemCode.toString(),height,width,index
                                                  );
                                                }, child: Text('0',style: TextStyle(color: Colors.pink.shade900),),),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: height/100,),
                                          Container(
                                            height: height/1000,
                                            width: width,
                                            color: Colors.purple.shade900,
                                          ),
                                          SizedBox(height: height/100,),

                                          Row(
                                            children: [

                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                      1,
                                                      "O",
                                                      myController.secScreenDisplaySoData[index].varible1Code,
                                                      myController.secScreenDisplaySoData[index].varible1Name,context,height,"1",index);
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible1Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/5.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          myController.secScreenDisplaySoData[index].varible1Name.toString(),
                                                          style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/3.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible1.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                      1,
                                                      "O",
                                                      myController.secScreenDisplaySoData[index].varible7Code,
                                                      myController.secScreenDisplaySoData[index].varible7Name,context,height,"7",index,
                                                  );
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible7Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/6.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible7Name.toString(),style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/4.2,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible7.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),

                                          SizedBox(height: height/100,),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                    1,
                                                    "O",
                                                    myController.secScreenDisplaySoData[index].varible2Code,
                                                    myController.secScreenDisplaySoData[index].varible2Name,context,height,"2",index,
                                                  );
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible2Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/5.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          myController.secScreenDisplaySoData[index].varible2Name.toString(),
                                                          style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/3.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible2.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                    1,
                                                    "O",
                                                    myController.secScreenDisplaySoData[index].varible8Code,
                                                    myController.secScreenDisplaySoData[index].varible8Name,context,height,"8",index,
                                                  );
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible8Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/6.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible8Name.toString(),style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/4.2,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible8.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )



                                            ],
                                          ),
                                          SizedBox(height: height/100,),
                                          Row(
                                            children: [

                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                    1,
                                                    "O",
                                                    myController.secScreenDisplaySoData[index].varible3Code,
                                                    myController.secScreenDisplaySoData[index].varible3Name,context,height,"3",index,
                                                  );
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible3Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/5.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          myController.secScreenDisplaySoData[index].varible3Name.toString(),
                                                          style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/3.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible3.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                    1,
                                                    "O",
                                                    myController.secScreenDisplaySoData[index].varible9Code,
                                                    myController.secScreenDisplaySoData[index].varible9Name,context,height,"9",index,
                                                  );
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible9Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/6.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible9Name.toString(),style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/4.2,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible9.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )



                                            ],
                                          ),
                                          SizedBox(height: height/100,),
                                          Row(
                                            children: [

                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                    1,
                                                    "O",
                                                    myController.secScreenDisplaySoData[index].varible4Code,
                                                    myController.secScreenDisplaySoData[index].varible4Name,context,height,"4",index,
                                                  );
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible4Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/5.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          myController.secScreenDisplaySoData[index].varible4Name.toString(),
                                                          style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/3.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible4.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                    1,
                                                    "O",
                                                    myController.secScreenDisplaySoData[index].varible10Code,
                                                    myController.secScreenDisplaySoData[index].varible10Name,context,height,"10",index,
                                                  );
                                                },
                                                child:  Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible10Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/6.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible10Name.toString(),style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/4.2,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible10.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: height/100,),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                    1,
                                                    "O",
                                                    myController.secScreenDisplaySoData[index].varible5Code,
                                                    myController.secScreenDisplaySoData[index].varible5Name,context,height,"5",index,
                                                  );
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible5Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/5.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          myController.secScreenDisplaySoData[index].varible5Name.toString(),
                                                          style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/3.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible5.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                    1,
                                                    "O",
                                                    myController.secScreenDisplaySoData[index].varible11Code,
                                                    myController.secScreenDisplaySoData[index].varible11Name,context,height,"11",index,
                                                  );
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible11Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/6.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible11Name.toString(),style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/4.2,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible11.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),


                                            ],
                                          ),
                                          SizedBox(height: height/100,),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                    1,
                                                    "O",
                                                    myController.secScreenDisplaySoData[index].varible6Code,
                                                    myController.secScreenDisplaySoData[index].varible6Name,context,height,"6",index,
                                                  );
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible6Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/5.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          myController.secScreenDisplaySoData[index].varible6Name.toString(),
                                                          style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/3.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible6.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  myController.getMakeToOrderMaster(
                                                    1,
                                                    "O",
                                                    myController.secScreenDisplaySoData[index].varible12Code,
                                                    myController.secScreenDisplaySoData[index].varible12Name,context,height,"12",index,
                                                  );
                                                },
                                                child: Visibility(
                                                  visible: myController.secScreenDisplaySoData[index].varible12Name==""?false:true,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: height/48,
                                                        width: width/6.5,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible12Name.toString(),style: const TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/30,
                                                        alignment: Alignment.centerLeft,
                                                        child: const Text(":"),
                                                      ),
                                                      Container(
                                                        height: height/48,
                                                        width: width/4.2,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(myController.secScreenDisplaySoData[index].varible12.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )


                                            ],
                                          ),
                                          SizedBox(height: height/100,),

                                        ],
                                      ),
                                    ),
                                  );
                                },),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height/2,
                      width: width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(columnSpacing: 30.0,
                            headingRowColor: MaterialStateProperty.all(Colors.blue.shade900),
                            showCheckboxColumn: true,
                            sortColumnIndex: 0,
                            sortAscending: true,
                            border: TableBorder.all(color: Colors.black26),
                            columns:  const <DataColumn>[
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    'Selected',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    'DocEntry',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    'DocNo',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    'CardName',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    'ItemName',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),

                              DataColumn(
                                label: Center(
                                  child: Text(
                                    'ReqQty',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),

                            ],
                            rows: myController.secScreenSOData.map((list) =>
                                DataRow(cells: [

                                  DataCell(
                                      IconButton(
                                          onPressed: () {
                                            myController.itemdeteliesSelect(myController.secScreenSOData.indexOf(list));
                                          },
                                          icon: Icon(
                                            list.selected==""?
                                            Icons.check_box_outline_blank_sharp:Icons.check_circle,
                                            color: Colors.green,
                                          ))
                                  ),

                                  DataCell(
                                    Text(list.soEntry.toString(), textAlign: TextAlign.center),
                                  ),
                                  DataCell(
                                    Text(list.soDocNum.toString(), textAlign: TextAlign.center),
                                  ),
                                  DataCell(
                                    Text(list.cardName.toString(), textAlign: TextAlign.center),
                                  ),

                                  DataCell(
                                    Text(list.itemName.toString(), textAlign: TextAlign.center),

                                  ),

                                  DataCell(
                                    Text(list.reqQty.toString(), textAlign: TextAlign.center),

                                  ),


                                ]),
                            )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

            ),
            persistentFooterButtons: [
              Visibility(
                visible: myController.soDetalis,
                  child: GestureDetector(
                onTap: () {
                  myController.getSODetails(context,height);
                },
                child: Container(
                  height: height / 20,
                  width: width / 2.5,
                  decoration: BoxDecoration(
                    color: ColorsValue.backgroudwhitecolor,
                    borderRadius: BorderRadius.all(Radius.circular(width / 30)),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(Dimens.three),

                    child: Center(
                      child: Text(
                        "SO Details",
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
              ),
              SizedBox(width: width/150,),
              Visibility(
                visible: myController.saveBtn,
                  child: GestureDetector(
                onTap: () {
                  //myController.postSave();
                  myController.loginSap();
                  //myController.sapposting("");
                },
                child: Container(
                  height: height / 20,
                  width: width / 2.5,
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
              ),
              SizedBox(width: width/150,),
              Visibility(
                visible: myController.goBtn,
                child: GestureDetector(
                  onTap: () {
                    myController.getMyScreenData();
                  },
                  child: Container(
                    height: height / 20,
                    width: width / 2.5,
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
                          "GO",
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
              ),





            ],

          ),
        ),
    );
  });
}
