import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pl_groups/app/modules/dispatched_module/dispatched_controller.dart';
import 'package:pl_groups/app/theme/colors_value.dart';

import '../../utils/dimens.dart';


class DispatchedPage extends GetView<DispatchedController> {
  const DispatchedPage({super.key});

  @override
  Widget build(BuildContext context)=>GetBuilder<DispatchedController>(builder: (myController) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //centerTitle: true,
          title:  const Text("Dispatch"),
          backgroundColor: ColorsValue.primaryColor,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: height/50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: height/15,
                    width: width/2.1,
                    child:  Material(
                      elevation: 7.0,
                      color: Colors.white,
                      shadowColor: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(height/10)),
                      child: TextField(
                        controller: myController.cardNameCtr,
                        onTap: (){
                          myController.showcardame1(context,height);
                          //myController.showCardName();
                        },
                        cursorColor: Colors.grey,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "CardName",
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.account_circle,color: Colors.pinkAccent,),
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: height/50),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height/15,
                    width: width/2.1,
                    child: SizedBox(
                      height: height/15,
                      width: width/2.1,
                      child:  Material(
                        elevation: 7.0,
                        color: Colors.white,
                        shadowColor: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(height/10)),
                        child: TextField(
                          controller: myController.salesvechaleno,
                          cursorColor: Colors.grey,
                          //readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Vehicle",
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.fire_truck,color: Colors.pinkAccent,),
                            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: height/50),
                          ),
                        ),
                      ),
                    ),
                    //color: Colors.green,
                  ),
                ],
              ),
              SizedBox(height: height/50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: height/15,
                    width: width/2.1,
                    child:  Material(
                      elevation: 7.0,
                      color: Colors.white,
                      shadowColor: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(height/10)),
                      child: TextField(
                        controller: myController.salesDocNoctr,
                        onTap: (){
                          myController.showSalesDocno1(context, height);
                          //myController.showSalesDocno();
                        },
                        cursorColor: Colors.grey,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Sales DocNo",
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.list,color: Colors.pinkAccent,),
                          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: height/50),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height/15,
                    width: width/2.1,
                    child: IconButton(
                      onPressed: () {

                        myController.comonscanBarcode();

                      }, icon: Icon(Icons.camera_alt),),
                    //color: Colors.green,
                  ),
                ],
              ),
              SizedBox(height: height/50,),
              SizedBox(
                  height: height/1.6,
                  width: width,
                  //color: Colors.deepOrange,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: myController.secSalesOrdersItemList.isNotEmpty ?
                      DataTable(columnSpacing: 30.0,
                        // headingRowColor: MaterialStateProperty.all(Colors.blue.shade900),
                        headingRowColor: MaterialStateProperty.all(ColorsValue.primaryColor),
                        showCheckboxColumn: true,
                        sortColumnIndex: 0,
                        sortAscending: true,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'DocEntry',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'S.No',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                          DataColumn(
                            label: Center(
                              child: Text(
                                'ItemCode',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Description',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Actual Qty',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),


                          DataColumn(
                            label: Center(
                              child: Text(
                                'Dispatch Qty',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Center(
                              child: Text(
                                'Balance Qty',
                                style: TextStyle(color: Colors.white),
                              ),
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
                                'Action',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                        rows: myController.secSalesOrdersItemList.map((list) =>
                            DataRow(cells: [
                              DataCell(
                                Text(list.qrdocEntry1.toString(), textAlign: TextAlign.center),
                              ),
                              DataCell(Text(
                                  (myController.secSalesOrdersItemList.indexOf(list)+1).toString(), textAlign: TextAlign.center),),

                              DataCell(
                                Text(list.itemCode.toString(), textAlign: TextAlign.center),
                              ),
                              DataCell(
                                  Text(list.itemCode.toString(), textAlign: TextAlign.center),
                              ),
                              DataCell(
                                Text(list.actualQty.toString(), textAlign: TextAlign.center),
                              ),
                              DataCell(
                                Text(list.disatchedQty.toString(), textAlign: TextAlign.center),
                                showEditIcon: true,
                                onTap: (){
                                  myController.showQty(
                                      myController.secSalesOrdersItemList.indexOf(list),"Enter Qty..",1);
                                }

                              ),
                              DataCell(
                                  Text(list.blanceQty.toString(), textAlign: TextAlign.center),
                              ),
                              DataCell(
                                  IconButton(
                                    onPressed: () {
                                      myController.showBatch(
                                          myController.secSalesOrdersItemList.indexOf(list),"Enter Qty..",2,
                                          list.itemCode.toString(),
                                          list.qrdocEntry1.toString(),
                                          list.qrlineID.toString(),
                                      );
                                    },
                                    icon: Icon(Icons.remove_red_eye,color: Colors.pinkAccent,),)
                              ),
                              DataCell(
                                IconButton(
                                  onPressed: () {
                                    myController.removeListSales(

                                        myController.secSalesOrdersItemList.indexOf(list)
                                    );
                                  },
                                  icon: Icon(Icons.delete,color: Colors.deepOrange,),)
                              ),
                            ]),
                        )
                            .toList(),
                      )
                          : Center(
                        child: Container(
                            width: width,
                            alignment: Alignment.center,
                            child: const Text('No Data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: ColorsValue.primaryColor
                            ),)),
                      ))

              )
            ],
          ),
        ),
        persistentFooterButtons: [
          /*ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: (){
              myController.postSave();
            },
            child: Text('Save'),

          ),
*/
          GestureDetector(
            onTap: () {
              myController.postSave();
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
