import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
import 'package:ibc_telecom/shared_pref/preference.dart';
import 'package:ibc_telecom/utils/urls.dart';
import 'package:ibc_telecom/views/notification/NotificationDetailview.dart';
import 'package:ibc_telecom/views/notification/detailviewscreenPublic.dart';
import 'package:ibc_telecom/views/notification/notification_model.dart';
import "package:http/http.dart"as http;
String? title;
String? discription;
 List<Listnotification>? notification = [];
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool private=false;
  bool Public=true;
 
  // List<PublicNotification>? notificationpublic = [];
  bool isLoading =false;

  @override
  void initState() {
   getNotification();
    super.initState();
  }

  getNotification() async {
    print("fjdsbhfjdbsfjbjdsf");
    setState(() {
      isLoading = true;
    });
    final user_id = MySharedPreferences.localStorage
        ?.getInt(MySharedPreferences.customerId).toString();

    try {
      final response = await post(Uri.parse("https://api-payment.ibc.al/api/list-notifications"),body:{
        'cust_id':user_id
      });
      print(response.body);
      final parse = jsonDecode(response.body);

   

      setState(() {
      
        final notificationData = NotificationModel.fromJson(parse);
      print(notificationData);
        notification = notificationData.listnotification ?? [];
        // notificationpublic= notificationData.publicNotification ?? [];
      });
    } on Exception catch (e) {
      // TODO
    }finally{
      setState(() {
        isLoading= false;
      });
    }
  }
Future<void> updateNotificationStatus(String notificationId) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api-payment.ibc.al/api/update-notification-status'),
    );

    request.fields.addAll({
      'id': notificationId,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print('Request failed with status: ${response.statusCode}');
      print(response.reasonPhrase);
    }
  } catch (e) {
    print('Error: $e');
  }
}
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
              onTap: () => Get.to(TabScreen(index: 0)),
            ),
          ),
        ),
        title: Text(
          "Njoftimeee",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body:Visibility(
              visible: !isLoading,
              replacement: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              child: Container(height: Get.height,width: Get.width,child: Column(
          children: [
                  SizedBox(height: Get.height*0.03,),
          //         Row(
            
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [InkWell(
          //           child: Container(
          //                           height: Get.height*0.05,
          //                           width: Get.width*0.3,
          //                           decoration: BoxDecoration(border: Border.all(),color: Public==false ?Colors.transparent:Colors.black),
          //                           child: Center(child:  Text("Private",style: TextStyle(color:Public==true?Colors.white: Colors.black,fontWeight: FontWeight.bold),)),),
          //  onTap: (() {
          //    setState(() {
          //      Public=true;
          //      private=false;
          //    });
          //  }),       ),
        
          //                         SizedBox(width: Get.width*.1,),
                            
                            
          //                         InkWell(
          //                           child: Container(
          //                           height: Get.height*0.05,
          //                           width: Get.width*0.3,
          //                                                    decoration: BoxDecoration(border: Border.all(),color: private==false ?Colors.transparent:Colors.black),
          //                           child: Center(child:  Text("Publike",style: TextStyle(color: private==false ? Colors.black:Colors.white,fontWeight: FontWeight.bold))),),
          //                      onTap: () {
          //                          setState(() {
          //      Public=false;
          //      private=true;
          //    });
                        //  },   )],),
        
                         SizedBox(height: Get.height*0.03,),
                         
                      Expanded(
                           child: Container(
                             child: ListView.builder(
                               itemCount: notification!.length,
                               itemBuilder: (BuildContext context, int index) {
                                 return InkWell(
                                       child: Card(
                                         child: Container(
                              // color: Colors.amber,
                              child: Row(children: [
                                SizedBox(width: 10 ,),
                                CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Center(child: Icon(Icons.notifications),),),
                               SizedBox(width: 20,),
                              
                              Container(
                                // color: Colors.amber,
                                            height: MediaQuery.of(context).size.height*.06, 
                                            width: MediaQuery.of(context).size.width*.6, 
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [Text(notification![index].title.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                              
                                              Text(notification![index].notification.toString(),style: TextStyle(color: Colors.black,), overflow: TextOverflow.ellipsis, )
                                              ],),
                                            ),
                                            Icon(Icons.forward)
                              ],),
                              height: MediaQuery.of(context).size.height*.08,
                                width: MediaQuery.of(context).size.width,),
                                       ),
                                       onTap: () {
                                        title=notification![index].title.toString();
                                        discription=notification![index].notification.toString();
                                        setState(() {
                              title;
                              discription;
                                        });
                                        updateNotificationStatus(notification![index].id.toString());
                                         Navigator.push(context, CupertinoPageRoute(builder: (context)=>NotificationDetail()));
                                       },
                                     );
                                       
                               },
                             ),
                           ),
                         ),
        
                        //    if(private==true)  Expanded(
                        //    child: Container(
                        //      child: ListView.builder(
                        //        itemCount: notificationpublic!.length,
                        //        itemBuilder: (BuildContext context, int index) {
                        //          return InkWell(
                        //                child: Card(
                        //                  child: Container(
                        //       // color: Colors.amber,
                        //       child: Row(children: [
                        //         SizedBox(width: 10 ,),
                        //         CircleAvatar(
                        //         backgroundColor: Colors.red,
                        //         child: Center(child: Icon(Icons.notifications),),),
                        //        SizedBox(width: 20,),
                              
                        //       Container(
                        //         // color: Colors.amber,
                        //                     height: MediaQuery.of(context).size.height*.06, 
                        //                     width: MediaQuery.of(context).size.width*.6, 
                        //                     child: Column(
                        //                       crossAxisAlignment: CrossAxisAlignment.start,
                        //                       children: [Text(notificationpublic![index].notification.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                                              
                        //                       // Text(notification![index].notification.toString(),style: TextStyle(color: Colors.black,), overflow: TextOverflow.ellipsis, )
                        //                       ],),
                        //                     ),
                        //                     Icon(Icons.forward)
                        //       ],),
                        //       height: MediaQuery.of(context).size.height*.08,
                        //         width: MediaQuery.of(context).size.width,),
                        //                ),
                        //                onTap: () {
                        //                 title=notificationpublic![index].notification.toString();
                        //                 // discription=notification![index].notification.toString();
                        //                 setState(() {
                        //       title;
                        //       // discription;
                        //                 });
                        //                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>publicNotification()));
                        //                },
                        //              );
                                       
                        //        },
                        //      ),
                        //    ),
                        //  ),
        
                         SizedBox(height: 20,)
                         ],
        ),),
      )
        // DefaultTabController(
        //   length: 2,
        //    child: Column(
        //      children: [
        //        Container(
        //         alignment: Alignment.center,
        //          child: TabBar(
        //               isScrollable: true,
        //               labelColor: Colors.black,
        //               unselectedLabelColor: Colors.black,
        //               indicatorColor: Colors.blue,
        //             // labelPadding: EdgeInsets.symmetric(horizontal: (Get.width - 2 * Get.width * 0.2) / ),
        //               tabs: [
        //                 Tab(child: Container(
        //                   height: Get.height*0.05,
        //                   width: Get.width*0.2,
        //                   decoration: BoxDecoration(border: Border.all()),
        //                   child: Center(child: Text("publike"))),),
                        
                        // Tab(child: Container(
                        //   height: Get.height*0.05,
                        //   width: Get.width*0.2,
                        //   decoration: BoxDecoration(border: Border.all()),
                        //   child: Center(child:  Text("private")),),)
                       
        //               ],
                      
        //             ),
        //        ),

        //           TabBarView(children: [
        //                         Column(children: [
        //                           for(int i=0;i<notification!.length;i++) Padding(
        //                        padding: const EdgeInsets.all(8.0),
                        //        child: InkWell(
                        //          child: Card(
                        //            child: Container(
                        // // color: Colors.amber,
                        // child: Row(children: [
                        //   SizedBox(width: 10 ,),
                        //   CircleAvatar(
                        //   backgroundColor: Colors.red,
                        //   child: Center(child: Icon(Icons.notifications),),),
                        //  SizedBox(width: 20,),
                        
                        // Container(
                        //   // color: Colors.amber,
                        //               height: MediaQuery.of(context).size.height*.06, 
                        //               width: MediaQuery.of(context).size.width*.6, 
                        //               child: Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [Text(notification![i].title.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        
                        //                 Text(notification![i].notification.toString(),style: TextStyle(color: Colors.black,), overflow: TextOverflow.ellipsis, )
                        //                 ],),
                        //               ),
                        //               Icon(Icons.forward)
                        // ],),
                        // height: MediaQuery.of(context).size.height*.08,
                        //   width: MediaQuery.of(context).size.width,),
                        //          ),
                        //          onTap: () {
                        //           title=notification![i].title.toString();
                        //           discription=notification![i].notification.toString();
                        //           setState(() {
                        // title;
                        // discription;
                        //           });
                        //            Navigator.push(context, CupertinoPageRoute(builder: (context)=>NotificationDetail()));
                        //          },
                        //        ),
                               
                             
        //                      ),
        //                         ],),
        //                           Column(children: [
        //                             for(int i=0;i<notificationpublic!.length;i++) Padding(
        //                          padding: const EdgeInsets.all(8.0),
        //                          child: InkWell(
        //                            child: Card(
        //                              child: Container(
        //                               // color: Colors.amber,
        //                               child: Row(children: [
        //                                 SizedBox(width: 10 ,),
        //                                 CircleAvatar(
        //                                 backgroundColor: Colors.red,
        //                                 child: Center(child: Icon(Icons.notifications),),),
        //                                SizedBox(width: 20,),
                        
        //                               Container(
        //                                 // color: Colors.amber,
        //                    height: MediaQuery.of(context).size.height*.06, 
        //                    width: MediaQuery.of(context).size.width*.6, 
        //                    child: Column(
        //                      crossAxisAlignment: CrossAxisAlignment.start,
        //                      children: [Text(notificationpublic![i].notification.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                        
        //                      // Text(notification![i].notification.toString(),style: TextStyle(color: Colors.black,), overflow: TextOverflow.ellipsis, )
        //                      ],),
        //                    ),
        //                    Icon(Icons.forward)
        //                               ],),
        //                               height: MediaQuery.of(context).size.height*.08,
        //                                 width: MediaQuery.of(context).size.width,),
        //                            ),
        //                            onTap: () {
        //                             title=notification![i].title.toString();
        //                             discription=notification![i].notification.toString();
        //                             setState(() {
        //                               title;
        //                               discription;
        //                             });
        //                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>NotificationDetail()));
        //                            },
        //                        ),
                               
                             
        //                      ),
        //                         ],)
                              
        //                       ])
        //      ],
        //    ),
              
        // ),
      //       TabBarView(children: [
      //         Column(children: [
      //           for(int i=0;i<notification!.length;i++) Padding(
      //        padding: const EdgeInsets.all(8.0),
      //        child: InkWell(
      //          child: Card(
      //            child: Container(
      // // color: Colors.amber,
      // child: Row(children: [
      //   SizedBox(width: 10 ,),
      //   CircleAvatar(
      //   backgroundColor: Colors.red,
      //   child: Center(child: Icon(Icons.notifications),),),
      //  SizedBox(width: 20,),
      
      // Container(
      //   // color: Colors.amber,
      //               height: MediaQuery.of(context).size.height*.06, 
      //               width: MediaQuery.of(context).size.width*.6, 
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [Text(notification![i].title.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      
      //                 Text(notification![i].notification.toString(),style: TextStyle(color: Colors.black,), overflow: TextOverflow.ellipsis, )
      //                 ],),
      //               ),
      //               Icon(Icons.forward)
      // ],),
      // height: MediaQuery.of(context).size.height*.08,
      //   width: MediaQuery.of(context).size.width,),
      //          ),
      //          onTap: () {
      //           title=notification![i].title.toString();
      //           discription=notification![i].notification.toString();
      //           setState(() {
      // title;
      // discription;
      //           });
      //            Navigator.push(context, CupertinoPageRoute(builder: (context)=>NotificationDetail()));
      //          },
      //        ),
             
           
      //      ),
      //         ],),
      //           Column(children: [
      //           for(int i=0;i<notification!.length;i++) Padding(
      //        padding: const EdgeInsets.all(8.0),
      //        child: InkWell(
      //          child: Card(
      //            child: Container(
      // // color: Colors.amber,
      // child: Row(children: [
      //   SizedBox(width: 10 ,),
      //   CircleAvatar(
      //   backgroundColor: Colors.red,
      //   child: Center(child: Icon(Icons.notifications),),),
      //  SizedBox(width: 20,),
      
      // Container(
      //   // color: Colors.amber,
      //               height: MediaQuery.of(context).size.height*.06, 
      //               width: MediaQuery.of(context).size.width*.6, 
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [Text(notification![i].title.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      
      //                 Text(notification![i].notification.toString(),style: TextStyle(color: Colors.black,), overflow: TextOverflow.ellipsis, )
      //                 ],),
      //               ),
      //               Icon(Icons.forward)
      // ],),
      // height: MediaQuery.of(context).size.height*.08,
      //   width: MediaQuery.of(context).size.width,),
      //          ),
      //          onTap: () {
      //           title=notification![i].title.toString();
      //           discription=notification![i].notification.toString();
      //           setState(() {
      // title;
      // discription;
      //           });
      //            Navigator.push(context, CupertinoPageRoute(builder: (context)=>NotificationDetail()));
      //          },
      //        ),
             
           
      //      ),
      //         ],)
            
      //       ])
            
          // Row(children: [Container(child: Text("publike",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),),Container(child: Text("Private"),)],),
          // for(int i=0;i<notification!.length;i++) Padding(
          //      padding: const EdgeInsets.all(8.0),
          //      child: InkWell(
          //        child: Card(
          //          child: Container(
          //           // color: Colors.amber,
          //           child: Row(children: [
          //             SizedBox(width: 10 ,),
          //             CircleAvatar(
          //             backgroundColor: Colors.red,
          //             child: Center(child: Icon(Icons.notifications),),),
          //            SizedBox(width: 20,),
      
          //           Container(
          //             // color: Colors.amber,
          //                         height: MediaQuery.of(context).size.height*.06, 
          //                         width: MediaQuery.of(context).size.width*.6, 
          //                         child: Column(
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           children: [Text(notification![i].title.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      
          //                           Text(notification![i].notification.toString(),style: TextStyle(color: Colors.black,), overflow: TextOverflow.ellipsis, )
          //                           ],),
          //                         ),
          //                         Icon(Icons.forward)
          //           ],),
          //           height: MediaQuery.of(context).size.height*.08,
          //             width: MediaQuery.of(context).size.width,),
          //        ),
          //        onTap: () {
          //         title=notification![i].title.toString();
          //         discription=notification![i].notification.toString();
          //         setState(() {
          //           title;
          //           discription;
          //         });
          //          Navigator.push(context, CupertinoPageRoute(builder: (context)=>NotificationDetail()));
          //        },
          //      ),
             
           
          //  ),
      
          //   for(int i=0;i<notificationpublic!.length;i++) Padding(
          //      padding: const EdgeInsets.all(8.0),
          //      child: Card(
          //        child: Container(
          //         // color: Colors.amber,
          //         child: Row(children: [
          //           SizedBox(width: 10 ,),
          //           CircleAvatar(
          //           backgroundColor: Colors.red,
          //           child: Center(child: Icon(Icons.notifications),),),
          //          SizedBox(width: 20,),
                
          //         Container(
          //           // color: Colors.amber,
          //                       // height: MediaQuery.of(context).size.height*.06, 
          //                       width: MediaQuery.of(context).size.width*.6, 
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [Text(notificationpublic![i].notification.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,overflow:TextOverflow.ellipsis),),
                    
          //                         // Text(notification![i].notification.toString(),style: TextStyle(color: Colors.black,),)
          //                         ],),
          //                       ),
          //                       // Icon(Icons.forward)
          //         ],),
          //         height: MediaQuery.of(context).size.height*.08,
          //           width: MediaQuery.of(context).size.width,),
          //      ),
             
           
          //  ),
         
          // // for(int i=0;i<notification!.length;i++)Padding(
          // //      padding: const EdgeInsets.all(8.0),
          // //      child: Card(
          // //        child: Container(
          // //         // color: Colors.amber,
          // //         height: MediaQuery.of(context).size.height*.08,
          // //           width: MediaQuery.of(context).size.width,),
          // //      ),
             
           
          // // ),
         
      
            
                
          // // ListView.separated(
          // //   shrinkWrap: true,
          // //   itemCount: notification!.length,
          // //   separatorBuilder: (context, index) => Divider(),
          // //   itemBuilder: (context, index) => Container(
          // //     color: Colors.amber,
          // //     height: MediaQuery.of(context).size.height*.2,
          // //     width: MediaQuery.of(context).size.width,
          // //     child: Card(child: Container(child:Row(children: [],),),))
          // // )

    );
  }


// notificationfunction(){
//   return   Container(
//              child: ListView.builder(
//               itemCount: 2,
//               itemBuilder: ((context, index) {
//                return Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Card(
//                    child: Container(
//                     // color: Colors.amber,
//                     height: MediaQuery.of(context).size.height*.08,
//                       width: MediaQuery.of(context).size.width,),
//                  ),
//                );
             
//              })),
//            );
// }


// publicnotificationfunction(){
//   return   Container(
//              child: ListView.builder(
//               itemCount: 2,
//               itemBuilder: ((context, index) {
//                return Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Card(
//                    child: Container(
//                     // color: Colors.amber,
//                     height: MediaQuery.of(context).size.height*.08,
//                       width: MediaQuery.of(context).size.width,),
//                  ),
//                );
             
//              })),
//            );
// }

}
