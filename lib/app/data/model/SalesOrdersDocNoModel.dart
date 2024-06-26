class SalesOrdersDocNoModel {
  int? status;
  List<Result>? result;

  SalesOrdersDocNoModel({this.status, this.result});

  SalesOrdersDocNoModel.fromJson(Map<String, dynamic> json) {
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

  Result({this.docNum, this.docEntry, this.cardCode});

  Result.fromJson(Map<String, dynamic> json) {
    docNum = json['DocNum'];
    docEntry = json['DocEntry'];
    cardCode = json['CardCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocNum'] = this.docNum;
    data['DocEntry'] = this.docEntry;
    data['CardCode'] = this.cardCode;
    return data;
  }
}
