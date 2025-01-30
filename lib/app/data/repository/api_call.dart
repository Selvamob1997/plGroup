// ignore_for_file: non_constant_identifier_names, camel_case_types
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../utils/data_exception.dart';
import '../../utils/utility.dart';

class api_call {

  static String IPAddress = "http://14.98.224.34:4210/";

  static String SAP_URL = "https://14.98.224.34:50000/";



  static Future<http.Response> loginBranch(fromId,branch,username,password,isloading) async {

    if(isloading)Utility.showLoader();
    log('${IPAddress}inMObLog');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FormId": fromId,
      "Branch": branch,
      "UserName": username,
      "Password":password
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}inMObLog'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }





  Future<http.Response> dispatch_gettable_detailsData() async {

    try {
      var body = {
        "FormID" : 1,
        "Extra" : "",
        "Extra1" : ""
      };

      var Header = {"Content-Type": "application/json"};
      var response = await http.post(
        //Uri.parse('http://103.252.117.204:901/getClassMaster'),
          Uri.parse('${IPAddress}getDispatchDetail'),
          body: json.encode(body),
          headers: Header);
      return response;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something Went Wrong Please try again Later.!!",
        toastLength: Toast.LENGTH_SHORT,
      );
      throw DataException(
        message: "Something went wrong.!!",
      );

    }
  }


  static Future<http.Response> updateDel(fromId,soNo,quality,length,width,thickness,noOfSheet,weight,
      salesEntry,qREntry,lineID,bundles,itemCode,itemName,isloading) async {

    if(isloading)Utility.showLoader();
    log('${IPAddress}insertPackingTbl');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromId": fromId,
      "SoNo": soNo,
      "Quality": quality,
      "Length":length,
      "Width":width,
      "Thickness":thickness,
      "NoOfSheet":noOfSheet,
      "Weight":weight,
      "SalesEntry":salesEntry,
      "QREntry":qREntry,
      "LineID": lineID,
      "Bundles":bundles,
      "ItemCode":itemCode,
      "ItemName":itemName
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}insertPackingTbl'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }

  static Future<http.Response> getAllMaster(fromID, soNo, docEntry, userId, cardCode, status, isloading) async {
    if(isloading)Utility.showLoader();
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromId":fromID,
      "SoNo":soNo,
      "DocEntry":docEntry,
      "UserID":userId,
      "CradCode":cardCode,
      "Status":status
    };
    print(body);
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}getAllMaster'),
          body: jsonEncode(body),
          headers: headers);
      //print(jsonDecode(response.body));
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }

  }

  static Future<http.Response> getItemMaster(fromID, productCode, quality, emboss, finish, grade,clothrex,thicks,color, width,isloading) async {
    if(isloading)Utility.showLoader();
    //log('${IPAddress}getAllMaster');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromId":fromID,
      "ProdictCode":productCode,
      "Quality":quality,
      "Emboss":emboss,
      "Finish":finish,
      "Grade":grade,
      "ClothOfRex":clothrex,
      "Thicks":thicks,
      "Color":color,
      "Width":width
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}inItemCode00042'),
          body: jsonEncode(body),
          headers: headers);
      //print(jsonDecode(response.body));
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }

  }


  static insertDispatched(fromID, lineid, cardCode, vehicle, soNo, docEntry,itemCode,ItemName,actualQty,
   dispaQty,balanceQty, isloading) async {
    if(isloading)Utility.showLoader();
    log('${IPAddress}insertDispatchedTbl');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromId": fromID,
      "LineId": lineid,
      "CardCode": cardCode,
      "Vehicle": vehicle,
      "SoNo": soNo,
      "DocEntry": docEntry,
      "ItemCode":itemCode,
      "ItemName": ItemName,
      "ActualQty": actualQty,
      "DispatchQty": dispaQty,
      "DispatchedQty": "21.01",
      "BalanceQty": balanceQty,
      "Status": "0"
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}insertDispatchedTbl'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }

  }


  static Future<http.Response> getgetAllList(fromID, productcode, type,isloading) async {
    if(isloading)Utility.showLoader();
    log('${IPAddress}getAllList');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromId":fromID,
      "ProductCode":productcode,
      "Type":type
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}getAllList'),
          body: jsonEncode(body),
          headers: headers);
      log(response.body);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }

  }

  static Future<http.Response> insertPicking(
      formId,docNo,productCode,itemCode,varible1,varible2,varible3,varible4,varible5,
      varible6,varible7,varible8,varible9,varible10,varible11,storagePayNo,
      qrdocEntry,lineID,bundle,isloading) async {

    if(isloading)Utility.showLoader();
    log('${IPAddress}insertpickingGTbl');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromID":formId,
      "DocNo": docNo,
      "productCode": productCode,
      "itemCode": itemCode,
      "varible1": varible1,
      "varible2": varible2,
      "varible3":varible3,
      "varible4": varible4,
      "varible5": varible5,
      "varible6": varible6,
      "varible7": varible7,
      "varible8": varible8,
      "varible9": varible9,
      "varible10": varible10,
      "varible11": varible11,
      "storagePayNo": storagePayNo,
      "qrdocEntry": qrdocEntry,
      "lineID": lineID,
      "bundle": bundle
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}insertpickingGTbl'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }


  static Future<http.Response> insertDespatched_tbl(
      statusID,cardCode,sodocEntry,createBy,vehicle,status,itemDetailXML,itemDetailXMLID,itemDetailXML1,
      itemDetailXMLID1,isloading) async {

    if(isloading)Utility.showLoader();
    log('${IPAddress}insertDespatchedTbl');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "StatusID":statusID,
      "CardCode": cardCode,
      "SODocEntry": sodocEntry,
      "CreateBy": createBy,
      "Vehicle": vehicle,
      "Status": status,
      "ItemDetailXML":itemDetailXML,
      "ItemDetailXMLID": itemDetailXMLID,
      "ItemDetailXML1": itemDetailXML1,
      "ItemDetailXMLID1": itemDetailXMLID1,

    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}insertDespatchedTbl'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }





  static Future<http.Response> getQrDetiles(type,prodCode,docEntry,bundle,lineID,isloading) async {

    if(isloading)Utility.showLoader();
    log('${IPAddress}getQrDetiles');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "Type":type,
      "ProdCode": prodCode,
      "DocEntry": docEntry,
      "Bundle": bundle,
      "LineID": lineID,
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}getQrDetiles'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }






  static Future<http.Response> getSalesOrderList(fromID,branchCode,isloading) async {
    if(isloading)Utility.showLoader();

    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromID":fromID,
      "BranchCode":branchCode
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}getSalesOrderList'),
          body: jsonEncode(body),
          headers: headers);
      print('${IPAddress}getSalesOrderList');
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }

  }


  static Future<http.Response> getSalesOrderCalling(branchCode,isloading) async {
    if(isloading)Utility.showLoader();

    var headers = {"Content-Type": "application/json"};
    var body = {
      "Branch":branchCode
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}getSalesOrderCalling'),
          body: jsonEncode(body),
          headers: headers);
      //print(jsonDecode(response.body));
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }

  }


  static Future<http.Response> getSalesOrderGetDetailes(productCode,docEntry,lineID,orderType,isloading) async {
    if(isloading)Utility.showLoader();

    var headers = {"Content-Type": "application/json"};
    var body = {
      "ProductCode":productCode,
      "DocEntry":docEntry,
      "LineID":lineID,
      "OrderType":orderType,
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}getSalesOrderGetDetailes'),
          body: jsonEncode(body),
          headers: headers);
      //print(jsonDecode(response.body));
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }

  }

  static Future<http.Response> getSalesQrMaster(fromID,status,productCode,code,parName,isloading) async {
    if(isloading)Utility.showLoader();

    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromID":fromID,
      "Status":status,
      "ProductCode":productCode,
      "Code":code,
      "ParName":parName,
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}getQrMaster'),
          body: jsonEncode(body),
          headers: headers);
      //print(jsonDecode(response.body));
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }

  }


  static Future<http.Response> insertQRScreenInsert(fromID,orderType,cardCode,cardName,branchCode,
      branchName,productCode,createBy,itemDetailXML,itemDetailXMLID,itemDetailXML1,itemDetailXMLID1,isloading) async {
    if(isloading)Utility.showLoader();

    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromID": fromID,
      "OrderType": orderType,
      "CardCode": cardCode,
      "CardName": cardName,
      "BranchCode": branchCode,
      "BranchName": branchName,
      "ProductCode": productCode,
      "CreateBy": createBy,
      "ItemDetailXML": itemDetailXML,
      "ItemDetailXMLID": itemDetailXMLID,
      "ItemDetailXML1": itemDetailXML1,
      "ItemDetailXMLID1": itemDetailXMLID1,
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${IPAddress}insertQRScreen'),
          body: jsonEncode(body),
          headers: headers);
      //print(jsonDecode(response.body));
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }

  }



  static Future<http.Response> loginSap(dbName,username,password,isloading) async {
    if(isloading)Utility.showLoader();

    HttpOverrides.global = MyHttpOverrides();
    var headers = {"Content-Type": "application/json",};
    var body = {
      "CompanyDB": dbName,
      "Password":  password,
      "UserName": username
    };
    log('${SAP_URL}b1s/v1/Login');
    log(jsonEncode(body));

    final response = await http.post(Uri.parse('${SAP_URL}b1s/v1/Login'),
        headers: headers,
        body: jsonEncode(body));
    return response;

  }


  static Future<http.Response> sapposting(String Cookie,body) async {
    //SapRefNo='0';
    String str = "#@F&L^&%U##T#T@#ER###CA@#@M*(PU@&#S%^%2324@*(^&";
    String result = str.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    print(result);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Cookie": Cookie,
    };

    log(jsonEncode(body));

    final response = await http.post(Uri.parse('${SAP_URL}b1s/v1/QRG'),
        headers: headers,
        body: jsonEncode(body));
    log(response.body);

    return response;
  }


}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}