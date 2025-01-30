// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pl_groups/app/modules/login_screen_module/login_screen_controller.dart';
import '../../theme/colors_value.dart';
import '../../utils/dimens.dart';
import '../../widgets/bottom_design.dart';
import '../../widgets/field_widget.dart';
import '../../widgets/top_design.dart';


class loginScreenPage extends GetView<loginScreenController> {
  final _login_cntrlr = Get.put(loginScreenController());
   loginScreenPage({super.key});

  @override
  Widget build(BuildContext context)=>GetBuilder<loginScreenController>(builder: (myController) {

    return Scaffold(
    body: SingleChildScrollView(
        child: Stack(
          children: [

            SizedBox(
              height: Get.height,
              width: Get.width,
            ),

            const Positioned(
              top: -160,
              left: -30,
              child: top_design_widgets(),
            ),
            const Positioned(
              bottom: -180,
              left: -40,
              child: bottom_design_widgets(),
            ),
            // center_design_widget(),
            // Dimens.boxHeight20,
            // Dimens.boxHeight20,
            Column(
              children: [
                // Dimens.boxHeight20,
                SizedBox(height: Get.height/4.3,),
                // CircleAvatar(
                //     backgroundColor: Colors.white,
                //     radius: height/10,
                //     child: Image.asset("assets/sts_logo.png",height: height/8,width: width/2,)),
                Text("Login".toUpperCase(),style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.width/10,
                    fontWeight: FontWeight.bold,
                  ),),
                SizedBox(height: Get.height/8,),
                SizedBox(
                  height: Get.height/13,
                  width: Get.width/1.1,
                  child: TextField(
                    controller: myController.branchName,
                    cursorColor: Colors.grey,
                    readOnly: true,
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                            const Text('Choose Branch Name'),
                            content: SizedBox(
                              width: double.minPositive,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: myController.secGetBranch.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(myController.secGetBranch[index].bPLName.toString()),
                                    //subtitle: Text(secScreenData[index].docNo.toString()),
                                    onTap: () {

                                      myController.branchName.text = myController.secGetBranch[index].bPLName.toString();
                                      myController.branchCode = myController.secGetBranch[index].bPLId.toString();
                                      myController.branchSubCode = myController.secGetBranch[index].code.toString();

                                      Navigator.pop(context,);


                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );

                    },
                    decoration: InputDecoration(
                      labelText: "Choose Branch Name",
                      labelStyle: const TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.list,color: Colors.pink.shade900,),
                      contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: Get.height/65),
                    ),
                  ),

                ),
                SizedBox(height: Get.height/60,),
                Center(
                    child: FieldWidget(
                        fieldWidth: Get.width/1.05,
                        textEditingController: _login_cntrlr.username_txt_cntrlr,
                        // inputFormatters: [UpperCaseTextFormatter()],
                        hintText:"Enter Name",
                        suffixIcon: const Icon(Icons.clear),
                        contentPadding: EdgeInsets.only(left: Get.width/30,),
                        formEnableBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(Get.width/25)),
                            borderSide: BorderSide(color: ColorsValue.blackcolor)
                        ),
                        formBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(Get.width/25)),
                            borderSide: BorderSide(color: ColorsValue.blackcolor)
                        )),
                  ),
                SizedBox(height: Get.height/60,),

                Center(
                    child: FieldWidget(
                        textEditingController: _login_cntrlr.password_txt_cntrlr,
                        fieldWidth: Get.width/1.05,
                        hintText:"Password",
                        // inputFormatters: [UpperCaseTextFormatter()],
                        contentPadding: EdgeInsets.only(left: Get.width/30),
                        suffixIcon: const Icon(Icons.visibility),
                        formEnableBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(Get.width/25)),
                            borderSide: BorderSide(color: ColorsValue.blackcolor)
                        ),
                        formBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(Get.width/25)),
                            borderSide: BorderSide(color: ColorsValue.blackcolor)
                        )
                    ),
                  ),
                SizedBox(height: Get.height/60,),

                GestureDetector(
                    onTap: () {
                      myController.logionPost();
                    },
                    child: Container(
                      height: Dimens.fourty,
                      width: Dimens.hundred+Dimens.fifty,
                      decoration: BoxDecoration(
                          gradient:   LinearGradient(
                              colors: [
                                Colors.blue.shade900,
                                Colors.blue.shade700,
                                Colors.blue,
                              ]
                          ),
                          color: ColorsValue.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(Get.width/25))
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width/18,
                            color: ColorsValue.brilliantWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            )

            // const LoginContent(),
          ],
        ),
      ),


    );


  });
}
