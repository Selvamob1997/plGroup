class CustomerTypeModel {
  int? status;
  List<Result>? result;

  CustomerTypeModel({this.status, this.result});

  CustomerTypeModel.fromJson(Map<String, dynamic> json) {
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
  String? cardCode;
  String? cardName;

  Result({this.cardCode, this.cardName});

  Result.fromJson(Map<String, dynamic> json) {
    cardCode = json['CardCode'];
    cardName = json['CardName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CardCode'] = this.cardCode;
    data['CardName'] = this.cardName;
    return data;
  }
}
