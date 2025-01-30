class SaleOrderGetModel {
  int? status;
  List<Result>? result;

  SaleOrderGetModel({this.status, this.result});

  SaleOrderGetModel.fromJson(Map<String, dynamic> json) {
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
  int? soEntry;
  int? soNum;
  var cardRefNo;
  var branch;
  String? delDate;
  String? cardCode;
  String? cardName;
  String? itemCode;
  String? itemName;
  String? whsCode;
  var baseLine;
  var quantity;
  String? varible1;
  String? varible1Name;
  String? varible1Code;
  String? varible2;
  String? varible2Name;
  String? varible2Code;
  String? varible3;
  String? varible3Name;
  String? varible3Code;
  String? varible4;
  String? varible4Name;
  String? varible4Code;
  String? varible5;
  String? varible5Name;
  String? varible5Code;
  String? varible6;
  String? varible6Name;
  String? varible6Code;
  String? varible7;
  String? varible7Name;
  String? varible7Code;
  var varible8;
  String? varible8Name;
  String? varible8Code;
  String? varible9;
  String? varible9Name;
  String? varible9Code;
  String? varible10;
  String? varible10Name;
  String? varible10Code;
  String? varible11;
  String? varible11Name;
  String? varible11Code;
  String? varible12;
  String? varible12Name;
  String? varible12Code;
  String? varible13;
  String? varible13Name;
  String? varible13Code;

  Result(
      {this.soEntry,
        this.soNum,
        this.cardRefNo,
        this.branch,
        this.delDate,
        this.cardCode,
        this.cardName,
        this.itemCode,
        this.itemName,
        this.whsCode,
        this.baseLine,
        this.quantity,
        this.varible1,
        this.varible1Name,
        this.varible1Code,
        this.varible2,
        this.varible2Name,
        this.varible2Code,
        this.varible3,
        this.varible3Name,
        this.varible3Code,
        this.varible4,
        this.varible4Name,
        this.varible4Code,
        this.varible5,
        this.varible5Name,
        this.varible5Code,
        this.varible6,
        this.varible6Name,
        this.varible6Code,
        this.varible7,
        this.varible7Name,
        this.varible7Code,
        this.varible8,
        this.varible8Name,
        this.varible8Code,
        this.varible9,
        this.varible9Name,
        this.varible9Code,
        this.varible10,
        this.varible10Name,
        this.varible10Code,
        this.varible11,
        this.varible11Name,
        this.varible11Code,
        this.varible12,
        this.varible12Name,
        this.varible12Code,
        this.varible13,
        this.varible13Name,
        this.varible13Code});

  Result.fromJson(Map<String, dynamic> json) {
    soEntry = json['SoEntry'];
    soNum = json['SoNum'];
    cardRefNo = json['CardRefNo'];
    branch = json['Branch'];
    delDate = json['DelDate'];
    cardCode = json['CardCode'];
    cardName = json['CardName'];
    itemCode = json['ItemCode'];
    itemName = json['ItemName'];
    whsCode = json['WhsCode'];
    baseLine = json['BaseLine'];
    quantity = json['Quantity'];
    varible1 = json['Varible1'];
    varible1Name = json['Varible1Name'];
    varible1Code = json['Varible1Code'];
    varible2 = json['Varible2'];
    varible2Name = json['Varible2Name'];
    varible2Code = json['Varible2Code'];
    varible3 = json['Varible3'];
    varible3Name = json['Varible3Name'];
    varible3Code = json['Varible3Code'];
    varible4 = json['Varible4'];
    varible4Name = json['Varible4Name'];
    varible4Code = json['Varible4Code'];
    varible5 = json['Varible5'];
    varible5Name = json['Varible5Name'];
    varible5Code = json['Varible5Code'];
    varible6 = json['Varible6'];
    varible6Name = json['Varible6Name'];
    varible6Code = json['Varible6Code'];
    varible7 = json['Varible7'];
    varible7Name = json['Varible7Name'];
    varible7Code = json['Varible7Code'];
    varible8 = json['Varible8'];
    varible8Name = json['Varible8Name'];
    varible8Code = json['Varible8Code'];
    varible9 = json['Varible9'];
    varible9Name = json['Varible9Name'];
    varible9Code = json['Varible9Code'];
    varible10 = json['Varible10'];
    varible10Name = json['Varible10Name'];
    varible10Code = json['Varible10Code'];
    varible11 = json['Varible11'];
    varible11Name = json['Varible11Name'];
    varible11Code = json['Varible11Code'];
    varible12 = json['Varible12'];
    varible12Name = json['Varible12Name'];
    varible12Code = json['Varible12Code'];


    varible13 = json['Varible13'];
    varible13Name = json['Varible13Name'];
    varible13Code = json['Varible13Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SoEntry'] = this.soEntry;
    data['SoNum'] = this.soNum;
    data['CardRefNo'] = this.cardRefNo;
    data['Branch'] = this.branch;
    data['DelDate'] = this.delDate;
    data['CardCode'] = this.cardCode;
    data['CardName'] = this.cardName;
    data['ItemCode'] = this.itemCode;
    data['ItemName'] = this.itemName;
    data['WhsCode'] = this.whsCode;
    data['BaseLine'] = this.baseLine;
    data['Quantity'] = this.quantity;
    data['Varible1'] = this.varible1;
    data['Varible1Name'] = this.varible1Name;
    data['Varible1Code'] = this.varible1Code;
    data['Varible2'] = this.varible2;
    data['Varible2Name'] = this.varible2Name;
    data['Varible2Code'] = this.varible2Code;
    data['Varible3'] = this.varible3;
    data['Varible3Name'] = this.varible3Name;
    data['Varible3Code'] = this.varible3Code;
    data['Varible4'] = this.varible4;
    data['Varible4Name'] = this.varible4Name;
    data['Varible4Code'] = this.varible4Code;
    data['Varible5'] = this.varible5;
    data['Varible5Name'] = this.varible5Name;
    data['Varible5Code'] = this.varible5Code;
    data['Varible6'] = this.varible6;
    data['Varible6Name'] = this.varible6Name;
    data['Varible6Code'] = this.varible6Code;
    data['Varible7'] = this.varible7;
    data['Varible7Name'] = this.varible7Name;
    data['Varible7Code'] = this.varible7Code;
    data['Varible8'] = this.varible8;
    data['Varible8Name'] = this.varible8Name;
    data['Varible8Code'] = this.varible8Code;
    data['Varible9'] = this.varible9;
    data['Varible9Name'] = this.varible9Name;
    data['Varible9Code'] = this.varible9Code;
    data['Varible10'] = this.varible10;
    data['Varible10Name'] = this.varible10Name;
    data['Varible10Code'] = this.varible10Code;
    data['Varible11'] = this.varible11;
    data['Varible11Name'] = this.varible11Name;
    data['Varible11Code'] = this.varible11Code;
    data['Varible12'] = this.varible12;
    data['Varible12Name'] = this.varible12Name;
    data['Varible12Code'] = this.varible12Code;

    data['Varible13'] = this.varible13;
    data['Varible13Name'] = this.varible13Name;
    data['Varible13Code'] = this.varible13Code;
    return data;
  }
}
