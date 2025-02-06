class WhsCodeModel {
  int? status;
  List<Result>? result;

  WhsCodeModel({this.status, this.result});

  WhsCodeModel.fromJson(Map<String, dynamic> json) {
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
  String? whsCode;
  String? whsName;

  Result({this.whsCode, this.whsName});

  Result.fromJson(Map<String, dynamic> json) {
    whsCode = json['WhsCode'];
    whsName = json['WhsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WhsCode'] = this.whsCode;
    data['WhsName'] = this.whsName;
    return data;
  }
}
