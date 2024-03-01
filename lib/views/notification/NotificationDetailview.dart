import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/shared_pref/preference.dart';
import 'package:ibc_telecom/utils/urls.dart';
import 'package:ibc_telecom/views/notification/notification_model.dart';
import 'package:ibc_telecom/views/notification/notification_screen.dart';

class NotificationDetail extends StatefulWidget {
  const NotificationDetail({Key? key}) : super(key: key);

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {


  // @override
  // void initState() {
  //   getNotification();
  //   super.initState();
  // }

//   getNotification() async {
//     setState(() {
//       isLoading = true;
//     });
//     final user_id = MySharedPreferences.localStorage
//         ?.getInt(MySharedPreferences.customerId).toString();
//     // var request = http.Request('GET', Uri.parse('https://urlsdemo.xyz/ibc-telecom/api/get-notification/user-id/658578'));

//     try {
//       final response = await post(Uri.parse("${notificationUrl}"),body:{
//         'cust_id':'658945'
//       });
//       final parse = jsonDecode(response.body);
// print(parse);
   

//       setState(() {
      
//         final notificationData = NotificationModel.fromJson(parse);
//       print(notificationData);
//         notification = notificationData.listNotification ?? [];
//         notificationpublic= notificationData.publicNotification ?? [];
//       });
//     } on Exception catch (e) {
//       // TODO
//     }finally{
//       setState(() {
//         isLoading= false;
//       });
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5)),
            child: GestureDetector(
              child: Icon(Icons.arrow_back, color: Colors.white),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: Text(
          "Njoftime",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body:Container(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(     
              
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),      color: Colors.white,   ),
                  width: Get.width,              child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      
                                      SizedBox(height: 10,), Text(title.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                   SizedBox(height: 10,), 
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(discription.toString(),style: TextStyle(color: Colors.black,),),
                                    )
                                   
                               ,    SizedBox(height: 10,),  ],),),
              )
            ],
          ),
        ),
      )
      
      //  Padding(
      //         padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
      //         child:   Column(
      // children: [
      //    Padding(
      //        padding: const EdgeInsets.all(8.0),
      //        child: Container(
      //         color: Colors.white,
      //         child: Row(children: [
      //           SizedBox(width: 10 ,),
      //           CircleAvatar(
      //           backgroundColor: Colors.red,
      //           child: Center(child: Icon(Icons.notifications),),),
      //          SizedBox(width: 20,),
              
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Container(
      //             // color: Colors.amber,
      //                         height: MediaQuery.of(context).size.height*.06, 
      //                         width: MediaQuery.of(context).size.width*.6, 
                              // child: Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [Text(title.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                
                              //   Text(discription.toString(),style: TextStyle(color: Colors.black,),)
                              //   ],),
      //                         ),
      //         ),
      //                       // Icon(Icons.forward)
      //         ],),
      //         // height: MediaQuery.of(context).size.height*.08,
      //           width: MediaQuery.of(context).size.width,),
           
         
      //    ),
      
        
      // ],
      //         ),
            // ),
    );
  }


notificationfunction(){
  return   Container(
             child: ListView.builder(
              itemCount: 2,
              itemBuilder: ((context, index) {
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Card(
                   child: Container(
                    // color: Colors.amber,
                    height: MediaQuery.of(context).size.height*.08,
                      width: MediaQuery.of(context).size.width,),
                 ),
               );
             
             })),
           );
}


publicnotificationfunction(){
  return   Container(
             child: ListView.builder(
              itemCount: 2,
              itemBuilder: ((context, index) {
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Card(
                   child: Container(
                    // color: Colors.amber,
                    height: MediaQuery.of(context).size.height*.08,
                      width: MediaQuery.of(context).size.width,),
                 ),
               );
             
             })),
           );
}

}


