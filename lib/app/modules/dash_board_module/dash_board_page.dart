import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pl_groups/app/modules/dash_board_module/dash_board_controller.dart';
import '../../theme/colors_value.dart';
import '../../utils/dimens.dart';


class DashBoardPage extends GetView<DashBoardController> {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context)=>GetBuilder<DashBoardController>(builder: (myController){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //centerTitle: true,
          title:  const Text("DashBoard"),
          backgroundColor: ColorsValue.primaryColor,
          actions: [
            SizedBox(
              height: Dimens.thirtyFive,
              // color: Colors.pink,
            )
          ],
          //leading: IconButton(onPressed: () {  }, icon: Icon(Icons.refresh),),
        ),
        /*body: Column(
          children: [
            // Container(
            //   height: height/15,
            //   width: width,
            //   color: Colors.pinkAccent,
            //   alignment: Alignment.center,
            //   child: Text("DashBoard",style: TextStyle(color: Colors.white,fontSize: height/60,fontWeight: FontWeight.bold),),
            // ),
            Container(
              height: height/1.2,
              width: width,
              alignment: Alignment.center,
              //color: Colors.deepOrange,
              child: SizedBox(
                height: height/3.2,
                width: width,
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        onPressed: (){
                          myController.navigationCtr(1);
                        },
                        child: const Text("Packing"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: (){
                        myController.navigationCtr(2);
                      },
                      child: const Text("Dispatched"),
                    ),
                  ],
                ),
              ),
            )

          ],
        ),*/
        body: Column(
          children: [

            SizedBox(height: height/30,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Scan Barcode Widget
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (builder) => Report_screen()));
                        // ScanQR(0);
                        myController.navigationCtr(1);
                      },
                      child: Container(
                        height: height/8,
                        width: width/2.5,
                        decoration: const BoxDecoration(
                            color: ColorsValue.primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(0)
                            )
                        ),
                        child: Image.asset("assets/picking_logo.png",
                          cacheWidth: 60,
                          cacheHeight: 60,),
                      ),
                    ),
                    SizedBox(
                      height: height/80,
                    ),
                    const Text("Packing",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),)
                  ],
                ),
                // Issue to Production Widget
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        myController.navigationCtr(2);
                      },
                      child: Container(
                        height: height/8,
                        width: width/2.5,
                        decoration: const BoxDecoration(
                            color: ColorsValue.primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(0)
                            )
                        ),
                        child: Image.asset(
                          "assets/exchange_logo.png",
                          cacheWidth: 60,
                          cacheHeight: 60,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height/80,
                    ),
                    const Text("Dispatch",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),)
                  ],
                ),
              ],
            ),
            SizedBox(height: height/30,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Scan Barcode Widget
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (builder) => Report_screen()));
                        // ScanQR(0);
                        myController.navigationCtr(3);
                      },
                      child: Container(
                        height: height/8,
                        width: width/2.5,
                        decoration: const BoxDecoration(
                            color: ColorsValue.primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(0)
                            )
                        ),
                        child: Icon(Icons.document_scanner_outlined,color: Colors.white,size: height/20,),
                      ),
                    ),
                    SizedBox(
                      height: height/80,
                    ),
                    const Text("QR View",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),)
                  ],
                ),
                // Issue to Production Widget
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (builder) => Report_screen()));
                        // ScanQR(0);
                        myController.navigationCtr(4);
                      },
                      child: Container(
                        height: height/8,
                        width: width/2.5,
                        decoration: const BoxDecoration(
                            color: ColorsValue.primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(0)
                            )
                        ),
                        child: Icon(Icons.qr_code_scanner_outlined,color: Colors.white,size: height/20,),
                      ),
                    ),
                    SizedBox(
                      height: height/80,
                    ),
                    const Text("QR Generation",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),)
                  ],
                ),
              ],
            ),
            SizedBox(height: height/30,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Scan Barcode Widget
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (builder) => Report_screen()));
                        // ScanQR(0);
                        myController.navigationCtr(5);
                      },
                      child: Container(
                        height: height/8,
                        width: width/2.5,
                        decoration: const BoxDecoration(
                            color: ColorsValue.primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(0),
                                bottomRight: Radius.circular(25),
                                bottomLeft: Radius.circular(0)
                            )
                        ),
                        child: Icon(Icons.inventory_outlined,color: Colors.white,size: height/20,),
                      ),
                    ),
                    SizedBox(
                      height: height/80,
                    ),
                    const Text("Stock Transfer",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),)
                  ],
                ),
                // Issue to Production Widget
                SizedBox(
                  height: height/8,
                  width: width/2.5,
                )
              ],
            )


          ],
        ),
      ),
    );
  });
}
