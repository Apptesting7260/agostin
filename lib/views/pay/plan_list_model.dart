class PlanListModel {
  String? status;
  String? message;
  List<AllPlans>? allPlans;

  PlanListModel({this.status, this.message, this.allPlans});

  PlanListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['all_plans'] != null) {
      allPlans = <AllPlans>[];
      json['all_plans'].forEach((v) {
        allPlans!.add(new AllPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.allPlans != null) {
      data['all_plans'] = this.allPlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllPlans {
  int? id;
  String? planName;
  String? mrp;
  String? validity;
  String? totalData;
  String? speed;
  String? voice;
  String? sms;
  String? otherAddon;
  Null? createdAt;
  String? updatedAt;
  int? subscriptionId;

  AllPlans(
      {this.id,
        this.planName,
        this.mrp,
        this.validity,
        this.totalData,
        this.speed,
        this.voice,
        this.sms,
        this.otherAddon,
        this.createdAt,
        this.updatedAt,
        this.subscriptionId});

  AllPlans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planName = json['plan_name'];
    mrp = json['mrp'];
    validity = json['validity'];
    totalData = json['total_data'];
    speed = json['speed'];
    voice = json['voice'];
    sms = json['sms'];
    otherAddon = json['other_addon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subscriptionId = json['subscription_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_name'] = this.planName;
    data['mrp'] = this.mrp;
    data['validity'] = this.validity;
    data['total_data'] = this.totalData;
    data['speed'] = this.speed;
    data['voice'] = this.voice;
    data['sms'] = this.sms;
    data['other_addon'] = this.otherAddon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['subscription_id'] = this.subscriptionId;
    return data;
  }
}