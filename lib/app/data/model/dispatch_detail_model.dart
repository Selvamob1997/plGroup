

class dispatch_detail_model_List {
  final List<dispatch_detail_model> details;

  dispatch_detail_model_List({
    required this.details,
  });

  factory dispatch_detail_model_List.fromJson(List<dynamic> parsedJson) {
    List<dispatch_detail_model> details = [];
    details =
        parsedJson.map((i) => dispatch_detail_model.fromJson(i)).toList();

    return dispatch_detail_model_List(details: details);
  }
}



class dispatch_detail_model {
  int? status;
  List<Result>? result;

  dispatch_detail_model({this.status, this.result});

  dispatch_detail_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? docNum;
  int? docEntry;
  String? cardCode;
  String? cardName;
  String? itemCode;
  String? dscription;
  var quantity;
  int? uWeight;
  String? uBundleNo;
  String? uTtlNtWgt;

  Result(
      {this.docNum,
        this.docEntry,
        this.cardCode,
        this.cardName,
        this.itemCode,
        this.dscription,
        this.quantity,
        this.uWeight,
        this.uBundleNo,
        this.uTtlNtWgt});

  Result.fromJson(Map<String, dynamic> json) {
    docNum = json['DocNum'];
    docEntry = json['DocEntry'];
    cardCode = json['CardCode'];
    cardName = json['CardName'];
    itemCode = json['ItemCode'];
    dscription = json['Dscription'];
    quantity = json['Quantity'];
    uWeight = json['U_Weight'];
    uBundleNo = json['U_BundleNo'];
    uTtlNtWgt = json['U_TtlNtWgt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocNum'] = this.docNum;
    data['DocEntry'] = this.docEntry;
    data['CardCode'] = this.cardCode;
    data['CardName'] = this.cardName;
    data['ItemCode'] = this.itemCode;
    data['Dscription'] = this.dscription;
    data['Quantity'] = this.quantity;
    data['U_Weight'] = this.uWeight;
    data['U_BundleNo'] = this.uBundleNo;
    data['U_TtlNtWgt'] = this.uTtlNtWgt;
    return data;
  }
}



class dispatch_model {

  String? itemname;
  String? itemcode;
  String? qty;
  String? weight;
  String? bundles;

  dispatch_model({this.itemname, this.itemcode, this.qty, this.bundles, this.weight});

}