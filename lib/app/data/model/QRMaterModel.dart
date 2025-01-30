class QRMaterModel {
  int? status;
  List<Result>? result;

  QRMaterModel({this.status, this.result});

  QRMaterModel.fromJson(Map<String, dynamic> json) {
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
  String? uParCode;
  String? uPaCode;
  String? uSpcation;
  String? uParName;

  Result({this.uParCode, this.uPaCode, this.uSpcation, this.uParName});

  Result.fromJson(Map<String, dynamic> json) {
    uParCode = json['U_ParCode'];
    uPaCode = json['U_PaCode'];
    uSpcation = json['U_Spcation'];
    uParName = json['U_ParName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['U_ParCode'] = this.uParCode;
    data['U_PaCode'] = this.uPaCode;
    data['U_Spcation'] = this.uSpcation;
    data['U_ParName'] = this.uParName;
    return data;
  }
}
