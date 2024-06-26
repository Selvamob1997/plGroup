class QualityModel {
  int? status;
  List<Result>? result;

  QualityModel({this.status, this.result});

  QualityModel.fromJson(Map<String, dynamic> json) {
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
  String? uSpcation;

  Result({this.uSpcation});

  Result.fromJson(Map<String, dynamic> json) {
    uSpcation = json['U_Spcation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['U_Spcation'] = this.uSpcation;
    return data;
  }
}
