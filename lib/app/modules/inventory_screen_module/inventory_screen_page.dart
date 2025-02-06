import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pl_groups/app/modules/inventory_screen_module/inventory_screen_controller.dart';

import '../../theme/colors_value.dart';
import '../../utils/dimens.dart';


class InventoryScreenPage extends GetView<InventoryScreenController> {
  @override
  Widget build(BuildContext context)=>GetBuilder<InventoryScreenController>(builder: (myController) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //centerTitle: true,
          title:  const Text("Stock Transfer"),
          backgroundColor: ColorsValue.primaryColor,
          elevation: 0,
          actions: [

            SizedBox(width: width/50,),
            IconButton(onPressed: (){
              myController.scanBarcode();
            }, icon: Icon(Icons.qr_code_scanner_outlined))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: height/100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.white,
                    width: width/2.1,
                    height: height/18,
                    child:  TextField(
                      controller: myController.whsName,
                      readOnly: true,
                      enableInteractiveSelection: false,
                      style: TextStyle(fontSize: height/63),
                      decoration: const InputDecoration(
                        labelText: "ToWhsCode",
                        labelStyle: TextStyle(color: Colors.black54),
                        contentPadding:  EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(
                              Radius.circular(0)),),
                      ),
                      onTap: (){

                        myController.showgWhsCode(context, height, 0);
                        //myController.showCardName();
                      },

                    ),),
                  Container(
                    color: Colors.white,
                    width: width/2.1,
                    height: height/18,
                    // child:  TextField(
                    //   controller: myController.cardName,
                    //   readOnly: true,
                    //   keyboardType: TextInputType.number,
                    //   style: TextStyle(fontSize: height/63),
                    //   decoration: const InputDecoration(
                    //       labelText: "Customer Name",
                    //       labelStyle: TextStyle(color: Colors.black54),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.black12),
                    //         borderRadius: BorderRadius.all(Radius.circular(0)),),
                    //       contentPadding: EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 15)
                    //   ),
                    //   onTap: (){
                    //     if(myController.orderType.text == "Make To Order"){
                    //       myController.showcardame1(context,height);
                    //     }
                    //
                    //     //myController.showCardName();
                    //   },
                    //
                    // ),
                  ),
                ],
              ),
              SizedBox(height: height/100,),
              SizedBox(
                height: height/1.8,
                width: width,
                child: SingleChildScrollView(
                  scrollDirection:
                  Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection:
                    Axis.horizontal,
                    child: myController.secScanInventoryModel.isEmpty ?
                    const Center(child: Text('No Data Add!'),) :
                    DataTable(
                      showCheckboxColumn: false,
                      headingRowHeight: height/20,
                      headingRowColor: MaterialStateProperty.all(ColorsValue.primaryColor),
                      columns: const <DataColumn>[
                        DataColumn(label: Text('GRPODocNum',style: TextStyle(color:Colors.white),),),
                        DataColumn(
                          label: Text('ItemCode',style: TextStyle(color:Colors.white),),
                        ),
                        DataColumn(label: Text('Quantity',style: TextStyle(color:Colors.white),),),
                        DataColumn(label: Text('Batch',style: TextStyle(color:Colors.white),),),
                        DataColumn(label: Text('WhsCode)',style: TextStyle(color:Colors.white),),),

                        DataColumn(label: Text('ToWhsCode',style: TextStyle(color:Colors.white),),),
                        DataColumn(label: Text('Action',style: TextStyle(color:Colors.white),),),

                      ],
                      rows:myController.secScanInventoryModel.map((list) =>
                          DataRow(
                            //color: list.status==1?MaterialStateProperty.all(Colors.black12):MaterialStateProperty.all(Colors.white),
                            cells: [
                              DataCell(
                                Text("${list.gRPODocNum}", textAlign: TextAlign.left,),
                              ),
                              DataCell(
                                Text("${list.itemCode}", textAlign: TextAlign.left,),
                              ),
                              // DataCell(
                              //   Text("${list.packing}", textAlign: TextAlign.left,),
                              // ),
                              DataCell(
                                Text("${list.quantity}", textAlign: TextAlign.left,),
                                showEditIcon: true,
                                onTap: (){
                                  myController.showQty(myController.secScanInventoryModel.lastIndexOf(list), "Enter The Qty", 1);
                                }
                              ),
                              DataCell(
                                Text("${list.batch}", textAlign: TextAlign.left,),
                              ),
                              DataCell(
                                Text("${list.whsCode}", textAlign: TextAlign.left,),
                              ),

                              DataCell(
                                Text("${list.toWhsCode}", textAlign: TextAlign.left,),

                              ),
                              DataCell(
                                  IconButton(onPressed: () {
                                    //myController.getWhsCode();
                                    myController.removeScreen(myController.secScanInventoryModel.lastIndexOf(list));

                                  }, icon: Icon(Icons.delete,color: Colors.red,),)
                              ),
                            ],
                          ),)
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [

          GestureDetector(
            onTap: () {
              myController.loginSap();
            },
            child: Container(
              height: height / 18,
              // width: width / 2.5,
              width: width,
              decoration: BoxDecoration(
                  color: ColorsValue.primaryColor,
                  borderRadius:
                  BorderRadius.all(Radius.circular(width / 30))),
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
