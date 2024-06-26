class WarehouseModel {
  int? status;
  List<Result>? result;

  WarehouseModel({this.status, this.result});

  WarehouseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? whsCode;
  String? whsName;

  Result({this.whsCode, this.whsName});

  Result.fromJson(Map<String, dynamic> json) {
    whsCode = json['WhsCode'];
    whsName = json['WhsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['WhsCode'] = whsCode;
    data['WhsName'] = whsName;
    return data;
  }
}
