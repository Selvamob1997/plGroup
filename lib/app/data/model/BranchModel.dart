class BranchModel {
  int? status;
  List<Result>? result;

  BranchModel({this.status, this.result});

  BranchModel.fromJson(Map<String, dynamic> json) {
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
  var bPLId;
  String? bPLName;
  String? code;

  Result({this.bPLId, this.bPLName,this.code});

  Result.fromJson(Map<String, dynamic> json) {
    bPLId = json['BPLId'];
    bPLName = json['BPLName'];
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BPLId'] = this.bPLId;
    data['BPLName'] = this.bPLName;
    data['Code'] = this.code;
    return data;
  }
}
