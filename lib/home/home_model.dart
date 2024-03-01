class HomeModel {
  String? status;
  String? message;
  MyPlan? myPlan;
  MyPlan? duePayment;
  List<Services>? services;
  List<Services>? technology;

  HomeModel(
      {this.status,
        this.message,
        this.myPlan,
        this.duePayment,
        this.services,
        this.technology});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    myPlan =
    json['my_plan'] != null ? MyPlan.fromJson(json['my_plan']) : null;
    duePayment = json['due_payment'] != null
        ? MyPlan.fromJson(json['due_payment'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    if (json['technology'] != null) {
      technology = <Services>[];
      json['technology'].forEach((v) {
        technology!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.myPlan != null) {
      data['my_plan'] = this.myPlan!.toJson();
    }
    if (this.duePayment != null) {
      data['due_payment'] = this.duePayment!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.technology != null) {
      data['technology'] = this.technology!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/*class MyPlan {
  int? planId;
  int? amount;
  String? validity;
  String? totalData;
  String? speed;
  String? voice;
  String? sms;
  String? otherAddon;
  String? createdAt;
  String? updatedAt;

  MyPlan(
      {this.planId,
        this.amount,
        this.validity,
        this.totalData,
        this.speed,
        this.voice,
        this.sms,
        this.otherAddon,
        this.createdAt,
        this.updatedAt});

  MyPlan.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    amount = json['amount'];
    validity = json['validity'];
    totalData = json['total_data'];
    speed = json['speed'];
    voice = json['voice'];
    sms = json['sms'];
    otherAddon = json['other_addon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_id'] = this.planId;
    data['amount'] = this.amount;
    data['validity'] = this.validity;
    data['total_data'] = this.totalData;
    data['speed'] = this.speed;
    data['voice'] = this.voice;
    data['sms'] = this.sms;
    data['other_addon'] = this.otherAddon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}*/
class MyPlan {
  int? planId;
  String? username;
  int? amount;
  String? expiration;
  String? validity;
  String? uploadBps;
  String? downloadBps;
  String? totalData;
  String? speed;
  String? voice;
  String? sms;
  String? otherAddon;
  String? createdAt;
  String? updatedAt;

  MyPlan(
      {this.planId,
        this.username,
        this.amount,
        this.expiration,
        this.validity,
        this.uploadBps,
        this.downloadBps,
        this.totalData,
        this.speed,
        this.voice,
        this.sms,
        this.otherAddon,
        this.createdAt,
        this.updatedAt});

  MyPlan.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    username = json['username'];
    amount = json['amount'];
    expiration = json['expiration'];
    validity = json['validity'];
    uploadBps = json['uploadBps'];
    downloadBps = json['downloadBps'];
    totalData = json['total_data'];
    speed = json['speed'];
    voice = json['voice'];
    sms = json['sms'];
    otherAddon = json['other_addon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['plan_id'] = this.planId;
    data['username'] = this.username;
    data['amount'] = this.amount;
    data['expiration'] = this.expiration;
    data['validity'] = this.validity;
    data['uploadBps'] = this.uploadBps;
    data['downloadBps'] = this.downloadBps;
    data['total_data'] = this.totalData;
    data['speed'] = this.speed;
    data['voice'] = this.voice;
    data['sms'] = this.sms;
    data['other_addon'] = this.otherAddon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Services {
  int? id;
  String? images;
  String? name;
  String? createdAt;
  String? updatedAt;

  Services({this.id, this.images, this.name, this.createdAt, this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['images'] = this.images;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}