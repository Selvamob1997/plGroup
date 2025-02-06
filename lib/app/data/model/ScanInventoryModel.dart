class ScanInventoryModel {
  String? itemCode;
  String? quantity;
  String? batch;
  String? whsCode;
  String? gRPODocNum;

  ScanInventoryModel(
      {this.itemCode,
        this.quantity,
        this.batch,
        this.whsCode,
        this.gRPODocNum});

  ScanInventoryModel.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    quantity = json[' Quantity'];
    batch = json[' Batch'];
    whsCode = json[' WhsCode'];
    gRPODocNum = json[' GRPODocNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemCode'] = this.itemCode;
    data[' Quantity'] = this.quantity;
    data[' Batch'] = this.batch;
    data[' WhsCode'] = this.whsCode;
    data[' GRPODocNum'] = this.gRPODocNum;
    return data;
  }
}
