class SaleOrderDetailsModel {
  int? status;
  List<Result>? result;

  SaleOrderDetailsModel({this.status, this.result});

  SaleOrderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? selected;
  int? soEntry;
  int? soDocNum;
  String? cardCode;
  String? cardName;
  String? delDate;
  String? itemCode;
  String? itemName;
  var reqQty;
  var lineNum;

  Result(
      {this.selected,
        this.soEntry,
        this.soDocNum,
        this.cardCode,
        this.cardName,
        this.delDate,
        this.itemCode,
        this.itemName,
        this.reqQty,
        this.lineNum});

  Result.fromJson(Map<String, dynamic> json) {
    selected = json['Selected'];
    soEntry = json['SoEntry'];
    soDocNum = json['SoDocNum'];
    cardCode = json['CardCode'];
    cardName = json['CardName'];
    delDate = json['DelDate'];
    itemCode = json['ItemCode'];
    itemName = json['ItemName'];
    reqQty = json['ReqQty'];
    lineNum = json['LineNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Selected'] = this.selected;
    data['SoEntry'] = this.soEntry;
    data['SoDocNum'] = this.soDocNum;
    data['CardCode'] = this.cardCode;
    data['CardName'] = this.cardName;
    data['DelDate'] = this.delDate;
    data['ItemCode'] = this.itemCode;
    data['ItemName'] = this.itemName;
    data['ReqQty'] = this.reqQty;
    data['LineNum'] = this.lineNum;
    return data;
  }
}
