class OrderHistoryModel {
  String? status;
  String? message;
  List<Data>? data;

  OrderHistoryModel({this.status, this.message, this.data});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? amount;
  String? createdAt;
  int? month;

  Data({this.id, this.amount, this.createdAt, this.month});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['month'] = this.month;
    return data;
  }
}
