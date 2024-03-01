class StoresModel {
  var status;
  var message;
  List<AllStores>? allStores;

  StoresModel({this.status, this.message, this.allStores});

  StoresModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['all_stores'] != null) {
      allStores = <AllStores>[];
      json['all_stores'].forEach((v) {
        allStores!.add(new AllStores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.allStores != null) {
      data['all_stores'] = this.allStores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllStores {
  var id;
  var title;
  var address;
  var contactNo;
  var image;
var createdAt;
var updatedAt;

  AllStores(
      {this.id,
        this.title,
        this.address,
        this.contactNo,
        this.image,
        this.createdAt,
        this.updatedAt});

  AllStores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    address = json['address'];
    contactNo = json['contact_no'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['address'] = this.address;
    data['contact_no'] = this.contactNo;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}