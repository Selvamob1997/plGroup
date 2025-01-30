class ProductCodeModel {
  int? status;
  List<Result>? result;

  ProductCodeModel({this.status, this.result});

  ProductCodeModel.fromJson(Map<String, dynamic> json) {
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
  String? prodCode;
  String? kEYCode;

  Result({this.prodCode, this.kEYCode});

  Result.fromJson(Map<String, dynamic> json) {
    prodCode = json['ProdCode'];
    kEYCode = json['kEY_Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProdCode'] = this.prodCode;
    data['kEY_Code'] = this.kEYCode;
    return data;
  }
}
