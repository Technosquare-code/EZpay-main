class TransactionModel {
  String? preAmt;
  String? amount;
  String? currentAmt;
  String? description;
  String? createdDate;
  String? orderId;

  TransactionModel({
    this.preAmt,
    this.amount,
    this.currentAmt,
    this.description,
    this.createdDate,
    this.orderId,
  });

  TransactionModel.fromJson(Map<String, dynamic> json) {
    preAmt = json['pre_amt'];
    amount = json['amount'];
    currentAmt = json['current_amt'];
    description = json['description'];
    createdDate = json['created_date'];
    orderId = json['order_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pre_amt'] = preAmt;
    data['amount'] = amount;
    data['current_amt'] = currentAmt;
    data['description'] = description;
    data['created_date'] = createdDate;
    data['order_id'] = orderId;
    return data;
  }
}
