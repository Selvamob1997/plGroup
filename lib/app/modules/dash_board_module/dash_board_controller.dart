import 'package:get/get.dart';
import 'package:pl_groups/app/routes/routemanagement.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DashBoardController extends GetxController{

  var sessionName='';
  var sessionEmpId='';
  var sessionBranchName='';
  var sessionBranchCode='';





  @override
  void onInit() {
    // TODO: implement onInit
    getStringValuesSF();
    update();
    super.onInit();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionName  =   prefs.getString('Name').toString();
    sessionEmpId = prefs.getString('EmpNo').toString();
    sessionBranchName = prefs.getString('branchName').toString();
    sessionBranchCode = prefs.getString('branchCode').toString();

    update();
  }




  void navigationCtr(int i) {

    if(i==1){
      routemanagement.gotoPacking();
    }else if(i==2){
      routemanagement.gotoDispatched();
    }else if(i==3){
      routemanagement.gotoScaning();
    }else if(i==4){
      routemanagement.gotoQRScaning();
    }else if(i==5){
      routemanagement.gotoInventory();
    }
    update();
  }
}
