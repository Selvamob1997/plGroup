class SalesOrdersItemModel {
  int? status;
  List<Result>? result;

  SalesOrdersItemModel({this.status, this.result});

  SalesOrdersItemModel.fromJson(Map<String, dynamic> json) {
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
  String? itemCode;
  String? itemName;
  var actualQty;
  var qrdocEntry;
  var qrlineID;

  Result({this.itemCode, this.itemName, this.actualQty,this.qrdocEntry,this.qrlineID});

  Result.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    itemName = json['ItemName'];
    actualQty = json['ActualQty'];
    qrdocEntry = json['QRDocEntry'];
    qrlineID = json['QRLineID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ItemCode'] = itemCode;
    data['ItemName'] = itemName;
    data['ActualQty'] = actualQty;
    data['QRDocEntry'] = qrdocEntry;
    data['QRLineID'] = qrlineID;
    return data;
  }
}
