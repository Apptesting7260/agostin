class MultiUserModel {
  String? status;
  PrimaryAccount? primaryAccount;
  List<PrimaryAccount>? secoundryAccount;

  MultiUserModel({this.status, this.primaryAccount, this.secoundryAccount});

  MultiUserModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    primaryAccount = json['primary_account'] != null
        ? new PrimaryAccount.fromJson(json['primary_account'])
        : null;
    if (json['secoundry_account'] != null) {
      secoundryAccount = <PrimaryAccount>[];
      json['secoundry_account'].forEach((v) {
        secoundryAccount!.add(new PrimaryAccount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    if (this.primaryAccount != null) {
      data['primary_account'] = this.primaryAccount!.toJson();
    }
    if (this.secoundryAccount != null) {
      data['secoundry_account'] =
          this.secoundryAccount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrimaryAccount {
  int? id;
  int? custId;
  String? username;
  String? mobile;
  String? image;
  String? countryCode;
  String? deviceKey;
  String? createdAt;
  String? updatedAt;

  PrimaryAccount(
      {this.id,
        this.custId,
        this.username,
        this.mobile,
        this.image,
        this.countryCode,
        this.deviceKey,
        this.createdAt,
        this.updatedAt});

  PrimaryAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    custId = json['cust_id'];
    username = json['username'];
    mobile = json['mobile'];
    image = json['image'];
    countryCode = json['country_code'];
    deviceKey = json['device_key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cust_id'] = this.custId;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['country_code'] = this.countryCode;
    data['device_key'] = this.deviceKey;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SecoundryAccount {
  int? id;
  String? custId;
  String? username;
  String? mobile;
  Null? image;
  Null? countryCode;
  String? deviceKey;
  String? createdAt;
  String? updatedAt;

  SecoundryAccount(
      {this.id,
        this.custId,
        this.username,
        this.mobile,
        this.image,
        this.countryCode,
        this.deviceKey,
        this.createdAt,
        this.updatedAt});

  SecoundryAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    custId = json['cust_id'];
    username = json['username'];
    mobile = json['mobile'];
    image = json['image'];
    countryCode = json['country_code'];
    deviceKey = json['device_key'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cust_id'] = this.custId;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['country_code'] = this.countryCode;
    data['device_key'] = this.deviceKey;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}