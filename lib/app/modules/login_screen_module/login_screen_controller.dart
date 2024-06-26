// ignore_for_file: camel_case_types, non_constant_identifier_names
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pl_groups/app/data/model/BranchModel.dart';
import 'package:pl_groups/app/data/repository/api_call.dart';
import 'package:pl_groups/app/routes/routemanagement.dart';
import 'package:pl_groups/app/utils/ennum_values.dart';
import 'package:pl_groups/app/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginScreenController extends GetxController{


  TextEditingController username_txt_cntrlr = TextEditingController();

  TextEditingController password_txt_cntrlr = TextEditingController();

  late BranchModel rawBranchModel;
  List<GetBranch> secGetBranch=[];

  var branchName = TextEditingController();
  var branchCode='0';


  @override
  void onInit() {
    // TODO: implement onInit
    getStringValuesSF();
    update();
    super.onInit();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getBranch();
    update();
  }

  getBranch()  {
    api_call.loginBranch(1, "0", "", "", true).then((value) => {
      if(value.statusCode==200){
        log(value.body),
        rawBranchModel = BranchModel.fromJson(jsonDecode(value.body)),
        for(int j=0;j<rawBranchModel.result!.length;j++){
          secGetBranch.add(
              GetBranch(
                rawBranchModel.result![j].bPLId,
                rawBranchModel.result![j].bPLName,
              ),
          ),
          update(),
        },
        Utility.closeLoader(),
        update(),
      }else{
        Utility.closeLoader(),
        update(),
      }
    });
  }


  logionPost(){
    if(branchName.text.isEmpty){

    }else if(username_txt_cntrlr.text.isEmpty){

    }else if(password_txt_cntrlr.text.isEmpty){

    }else {

      api_call.loginBranch(2, "0", username_txt_cntrlr.text, password_txt_cntrlr.text, true).then((value) => {
        if(value.statusCode==200){
          log(value.body),
          //empID,firstName
          Utility.closeLoader(),
          update(),
          setSession(
              jsonDecode(value.body)['result'][0]['firstName'],
              jsonDecode(value.body)['result'][0]['empID'],
              branchName.text,
              branchCode),


        }else {
          Utility.closeLoader(),
          update(),
        }
      });
    }
  }


  void logion() {

    if(username_txt_cntrlr.text.isEmpty){
      Utility.showMessage("Please Enter Username.!!", TypeOfMessage.error, () => null,
          "Okay");
    }else if(password_txt_cntrlr.text.isEmpty){
      Utility.showMessage("Please Enter Password.!!", TypeOfMessage.error, () => null,
          "Okay");
    }else if(username_txt_cntrlr.text=="Admin"&&password_txt_cntrlr.text=="1234"){


    }else {
      Utility.showMessage("Invalid Credential.!!", TypeOfMessage.error, () => null,
          "Okay");
    }

  }


  setSession(name,empno,branchName,branchCode) async {

    Future<SharedPreferences> prefs1 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs1;
    prefs.setString("Name", name.toString());
    prefs.setString("EmpNo",empno.toString());
    prefs.setString("branchName",branchName.toString());
    prefs.setString("branchCode",branchCode.toString());
    prefs.setString("Status", "Login");
    update();
    routemanagement.gotodashBoard();
  }
}


class GetBranch {
  var bPLId;
  String? bPLName;

  GetBranch(this.bPLId, this.bPLName);


}
