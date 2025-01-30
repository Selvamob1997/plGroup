class QrOrderTypeModel {
  int? status;
  List<Result>? result;

  QrOrderTypeModel({this.status, this.result});

  QrOrderTypeModel.fromJson(Map<String, dynamic> json) {
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
  String? code;
  String? name;

  Result({this.code, this.name});

  Result.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Code'] = this.code;
    data['Name'] = this.name;
    return data;
  }
}
