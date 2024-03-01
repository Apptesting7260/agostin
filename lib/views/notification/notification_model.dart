// class NotificationModel {
//   String? status;
//   String? message;
//   List<Listnotification>? listnotification;

//   NotificationModel({this.status, this.message, this.listnotification});

//   NotificationModel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'];
//     message = json['message'];
//     if (json['Listnotification'] != null) {
//       listnotification = <Listnotification>[];
//       json['Listnotification'].forEach((v) {
//         listnotification!.add(new Listnotification.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Status'] = this.status;
//     data['message'] = this.message;
//     if (this.listnotification != null) {
//       data['Listnotification'] =
//           this.listnotification!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Listnotification {
//   int? id;
//   int? custId;
//   String? title;
//   String? notification;

//   Listnotification({this.id, this.custId, this.title, this.notification});

//   Listnotification.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     custId = json['cust_id'];
//     title = json['title'];
//     notification = json['notification'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['cust_id'] = this.custId;
//     data['title'] = this.title;
//     data['notification'] = this.notification;
//     return data;
//   }
// }
class NotificationModel {
  NotificationModel({
     this.Status,
     this.message,
     this.Count,
     this.listnotification,
  });
   var Status;
   var message;
   var Count;
   List<Listnotification>? listnotification;
  
  NotificationModel.fromJson(Map<String, dynamic> json){
    Status = json['Status'];
    message = json['message'];
    Count = json['Count'];
    listnotification = List.from(json['Listnotification']).map((e)=>Listnotification.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Status'] = Status;
    _data['message'] = message;
    _data['Count'] = Count;
    _data['Listnotification'] = listnotification!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Listnotification {
  Listnotification({
     this.id,
     this.custId,
     this.title,
     this.notification,
     this.status,
  });
   var id;
   var custId;
   var title;
   var notification;
   var status;
  
  Listnotification.fromJson(Map<String, dynamic> json){
    id = json['id'];
    custId = ['custId'];
    title = json['title'];
    notification = json['notification'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['cust_id'] = custId;
    _data['title'] = title;
    _data['notification'] = notification;
    _data['status'] = status;
    return _data;
  }
}