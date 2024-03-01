import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
import 'package:ibc_telecom/provider/home_provider.dart';
import 'package:ibc_telecom/shared_pref/preference.dart';
import 'package:ibc_telecom/utils/add_api.dart';
import 'package:ibc_telecom/views/contact_us/contact_us.dart';
import 'package:ibc_telecom/views/home/multi_user_model.dart';
import 'package:ibc_telecom/views/home/multi_user_screen.dart';
import 'package:ibc_telecom/views/pay/pay_screen.dart';
import 'package:ibc_telecom/views/profile/profile_screen.dart';
import 'package:ibc_telecom/views/store/store_screen.dart';
import 'package:ibc_telecom/widget/all_list_widget.dart';
import 'package:ibc_telecom/widget/cache_network_image.dart';
import 'package:ibc_telecom/widget/my_button.dart';
import 'package:provider/provider.dart';

import '../../stripe/stripe_Payment.dart';
import '../../utils/urls.dart';
import '../pay/all_plan_list.dart';
import 'package:http/http.dart'as http;
  int user_id = 0;
  List multiuserlist=[];
       var userId;
  var mobileNumber ;
    String userName = '';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  String? service;
  bool isLoading = false;
  bool isPostpaidLoading = false;
  String mobile = "";
  MultiUserModel data = MultiUserModel();
  List<PrimaryAccount> secoundryAccount = [];

  @override
  void initState() {
    setState(() {
      print(("abc"));
      isLoading = true;
    });
    userName = MySharedPreferences.localStorage
            ?.getString(MySharedPreferences.fullName) ??
        "";
    user_id = MySharedPreferences.localStorage
            ?.getInt(MySharedPreferences.customerId) ??
        0;

    service = MySharedPreferences.localStorage
            ?.getString(MySharedPreferences.service) ??
        "Internet";
    mobile = MySharedPreferences.localStorage
            ?.getString(MySharedPreferences.mobile) ??
        "";
        setState(() {
          print("mymobile : ${mobile}");
        });
        setState(() {
          isBeforeFiveDaysBeforeExpiration;
          userId=user_id;
          mobileNumber=mobile;
        });
    Future.delayed(const Duration(seconds: 1)).then((value) => a());
    // a();
    super.initState();
  }

  a() async {
    setState(() {
      isLoading = false;
      
      multiUser();
    });
  }

  bool isCardOpen = false;

  Future multiUser() async {
    setState(() {
      isCardOpen = true;
    });
 
  var url = Uri.parse('https://api-payment.ibc.al/api/get-accountdetails/user-id/$userId/$mobileNumber');

    // try {
    //   var body = {'cust_id': user_id.toString(), "mobile": mobile};

    //   final response = await post(Uri.parse(multiuserUrl), body: body);
    //   final parse = jsonDecode(response.body);

    //   if (parse["Status"] != "Success") {
    //     return;
    //   }
    //   data = MultiUserModel.fromJson(parse);
    //   secoundryAccount = data.secoundryAccount ?? [];
    // } on Exception catch (e) {
    //   // TODO
    // } finally {
    //   setState(() {
    //     isCardOpen = false;
    //   });
    // }

    try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // print(response.body);
      var parse=jsonDecode(response.body);
      multiuserlist=parse['all_accounts'];
      setState(() {
        multiuserlist;
      });
      print(multiuserlist);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Failed to make the request: $e');
  } finally {
    setState(() {
      isCardOpen = true;
    });
  }
  }

  trim(date) {
    final newdate = DateTime.parse(date ?? "");
    final trimDate = newdate.toString().split(" ").first;
    return trimDate;
  }
HomeProvider HomeProviderinHomeProvider=HomeProvider();
  apiPostpaid() async {
    setState(() {
      isPostpaidLoading = true;
    });
    final body = {"user_id": user_id.toString()};
    print(body);
    try {
      final response = await post(Uri.parse(postpaidUrl), body: body);

      final parse = jsonDecode(response.body);

      print(response.statusCode);
      if (response.statusCode != 200) {
        return;
      }
      print("parse===$parse");
      if (parse["status"] != "Success") {
        HomeProviderinHomeProvider.getHomeData();
        return Get.defaultDialog(
          titlePadding: EdgeInsetsDirectional.symmetric(horizontal: 10,vertical: 20),
          title: "Un Success",
          titleStyle: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).highlightColor),
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                height: 125,
                width: MediaQuery.of(context).size.width * .6,
                child: Center(
                    child: Text(
                  parse["details"]["clientExpiration"] ??
                      parse["details"]["errorMessage"],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ))),
          ),
          confirm: MyButton(
            width: 100,
            height: 30,
            title: "Ok",
            onTap: () {
              callProviderApi();
              // Get.off(TabScreen(index: 0));
              Get.back();
            },
          ),
        );
      }
      if (parse["status"] == "Success"&&parse["details"]["errorMessage"]!="Keni Post-Paid te pa kompensuar!") {
        return Get.defaultDialog(
          titlePadding: EdgeInsetsDirectional.symmetric(horizontal: 10,vertical: 20),

          title: "Successfull",
          titleStyle: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).highlightColor),
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                height: 125,
                width: MediaQuery.of(context).size.width * .6,
                child: Center(
                    child: Text(
                  parse["details"]["clientExpiration"] ??
                      parse["details"]["errorMessage"],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ))),
          ),
          confirm: MyButton(
            width: 100,
            height: 30,
            title: "Ok",
            onTap: () {
              callProviderApi();
              // Get.off(TabScreen(index: 0));
              Get.back();
            },
          ),
        );
      }

      if (parse["status"] == "Success"&&parse["details"]["errorMessage"]=="Keni Post-Paid te pa kompensuar!") {
        return Get.defaultDialog(
          titlePadding: EdgeInsetsDirectional.symmetric(horizontal: 10,vertical: 20),

          title: "shërbimi nuk u aktivizua",
          titleStyle: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).highlightColor),
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                height: 125,
                width: MediaQuery.of(context).size.width * .6,
                child: Center(
                    child: Text(
                  parse["details"]["clientExpiration"] ??
                      parse["details"]["errorMessage"],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ))),
          ),
          confirm: MyButton(
            width: 100,
            height: 30,
            title: "Ok",
            onTap: () {
              callProviderApi();
              // Get.off(TabScreen(index: 0));
              Get.back();
            },
          ),
        );
      }

      setState(() {
        // AllList.date = parse["details"]["client_expiration"];
      });
    } catch (e) {
    } finally {
      setState(() {
        isPostpaidLoading = false;
      });
    }
  }

  callProviderApi() async {
    // await Apis(context).callProviderApi();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeProvider>(context, listen: false).getHomeData();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<BannerProvider>(context, listen: false).getBannerData();
    });
    multiUser();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: isBeforeFiveDaysBeforeExpiration ==null? Center(child: CircularProgressIndicator()):
      RefreshIndicator(
        onRefresh: () {
          return callProviderApi();
        },
        child: Stack(
          children: [
            Visibility(
              visible: !isLoading,
              replacement: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      user_id != 0
                          ? Card(
                              child: Column(
                                children: [],
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(height: height * .02),
                      user_id != 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: height * .01),
                                Text(
                                  "Përshëndetje I nderuar klient!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.black),
                                ),
                                SizedBox(
                                  height: height * .005,
                                ),
                                Text(
                                  userName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.red.shade500),
                                ),
                                SizedBox(height: height * .02),
                                Consumer<HomeProvider>(
                                  builder: (context, value, child) => Column(
                                    children: [
                                      if (value.item != null)
                                        // DateTime.parse(AllList.date).isAfter(DateTime.now()) ?
                                        Card(
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white),
                                            // height: 160,
                                            // width: 415,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        "assets/image/ibclogo.png",
                                                        width: 50,
                                                      ),
                                                      RichText(
                                                          text: TextSpan(
                                                              text: "Llogaria ",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black),
                                                              children: [
                                                            TextSpan(
                                                                text: user_id
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black)),
                                                          ])),
                                                      const Spacer(),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // multiUser();

                                                          Get.to(BottomSheetScree(
                                                            // data: data,
                                                            // secoundryAccount:
                                                            //     secoundryAccount,
                                                          ));
                                                        },
                                                        child: Text(
                                                          "Shiko Llogari tjetër",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                                fontSize: 11,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .highlightColor),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  if (DateTime.parse(value
                                                              .item
                                                              ?.myPlan
                                                              ?.expiration ??
                                                          "")
                                                      .isBefore(DateTime.now()))
                                                    Text(
                                                      "Abonimi juaj ka mbaruar",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge
                                                          ?.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .errorColor),
                                                    ),
                                                  // if (DateTime.parse(value
                                                  //             .item
                                                  //             ?.myPlan
                                                  //             ?.expiration ??
                                                  //         "")
                                                  //     .isBefore(DateTime.now()))
                                                  //   Text(
                                                  //     "This term it should not be visible.",
                                                  //     style: Theme.of(context)
                                                  //         .textTheme
                                                  //         .bodyMedium
                                                  //         ?.copyWith(
                                                  //             color:
                                                  //                 Colors.grey),
                                                  //   ),
                                                  SizedBox(height: 8),
                                                  Divider(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: DateTime.parse(value
                                                                        .item
                                                                        ?.myPlan
                                                                        ?.expiration ??
                                                                    "")
                                                                .isAfter(
                                                                    DateTime
                                                                        .now())
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    service ??
                                                                        "",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText2!
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.blue.shade900),
                                                                  ),
                                                                  Text(
                                                                    value
                                                                            .item
                                                                            ?.myPlan
                                                                            ?.speed ??
                                                                        "",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline6!
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.black),
                                                                  ),
                                                                  if (value
                                                                          .item
                                                                          ?.myPlan
                                                                          ?.amount !=
                                                                      null)
                                                                    Text(
                                                                      "${value.item?.myPlan?.amount} Leke",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                              color: Colors.red),
                                                                    ),
                                                                  SizedBox(
                                                                    height:
                                                                        height *
                                                                            .005,
                                                                  ),
                                                                  Text(
                                                                    "Expiration date: " +
                                                                        trim(value
                                                                            .item
                                                                            ?.myPlan
                                                                            ?.expiration),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall!
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                ],
                                                              )
                                                            : Column(
                                                                children: [
                                                                  Text(
                                                                    "Abonimi ka mbaruar: " +
                                                                        trim(value
                                                                            .item
                                                                            ?.myPlan
                                                                            ?.expiration),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall!
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                ],
                                                              ),
                                                      ),
                                                      // ElevatedButton(
                                                      //     style: ElevatedButton
                                                      //         .styleFrom(
                                                      //             minimumSize:
                                                      //                 const Size(
                                                      //                     70,
                                                      //                     30)),
                                                      //     onPressed: () {
                                                      //       Get.to(
                                                      //           const AllPlanList());
                                                      //     },
                                                      //     child: Text(
                                                      //       "Shiko paketat",
                                                      //       style: Theme.of(
                                                      //               context)
                                                      //           .textTheme
                                                      //           .bodySmall!
                                                      //           .copyWith(
                                                      //               color: Colors
                                                      //                   .white),
                                                      //     )),
                                                      Container(
                                                        height: MediaQuery.sizeOf(context).width*0.07,
                                                        width: MediaQuery.sizeOf(context).width*0.23,
                                                        
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6),
                                                          color: Theme.of(
                                                                      context)
                                                                  .errorColor),
                                                        
                                                        child: Center(
                                                          child: GestureDetector(
                                                            onTap: (){
                                                              Get.to(
                                                                const AllPlanList());
                                                            },
                                                            child: Text(
                                                                "Shiko paketat",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                      fontSize: 11,
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      // :
                                      const SizedBox(height: 10),
                                    
                                        // if (DateTime.parse(value
                                        //             .item?.myPlan?.expiration ??
                                        //         "")
                                        //     .subtract(const Duration(
                                        //       days: 5,
                                        //     ))
                                        //     .isBefore(DateTime.now()))
                                        
                                          (isBeforeFiveDaysBeforeExpiration==true)?
                                          Container(
                                                height: Get.height*0.18,
                                                width: Get.width*0.9,
                                                
                                                decoration: BoxDecoration(
                                                  color:Colors.white,
                                                  borderRadius:
                                                    BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(12.0),
                                                  child: Column(
                                                    children: [
                                                      Text("Abonimi juaj ka mbaruar,për të aktivizuar shërbimin 3-ditor,ju lutem ",style: TextStyle(color: Colors.red, fontSize: 16,fontWeight: FontWeight.bold),),
                                                     
                                                  SizedBox(height: 10,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [

                                                          Container(
                                                              height: MediaQuery.sizeOf(context).width*0.07,
                                                              width: MediaQuery.sizeOf(context).width*0.23,
                                                              
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(6),
                                                                color: Theme.of(
                                                                            context)
                                                                        .highlightColor),
                                                              
                                                              child: Center(
                                                                child: GestureDetector(
                                                                  onTap: (){
                                                                    setState(() {
                                                                        apiPostpaid();
                                                                      });
                                                                  },
                                                                  child: Text(
                                                                      "Klikoni Këtu",
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodySmall!
                                                                          .copyWith(
                                                                            fontSize: 11,
                                                                              color: Colors
                                                                                  .white),
                                                                    ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      )
                                                  
                                                    ],
                                                  ),
                                                ),
                                              )

                                          :Card(
                                              child: Container(
                                                height: 120,
                                                width: 415,
                                                decoration: BoxDecoration(
                                                    image: const DecorationImage(
                                                        image: AssetImage(
                                                            "assets/image/bg.PNG"),
                                                        fit: BoxFit.cover),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Paguaj Këtu",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6!
                                                            .copyWith(
                                                                color: Colors
                                                                    .blue
                                                                    .shade800),
                                                      ),
                                                      Text(
                                                        "L ${value.item?.myPlan?.amount}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  minimumSize:
                                                                      const Size(
                                                                          60,
                                                                          30)),
                                                          onPressed: () async {
                                                            Get.to(
                                                                const PayScreen(
                                                              isShowable: true,
                                                            ));
                                                          },
                                                          child: Text(
                                                            "Paguaj",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                      // : SizedBox(),
                                      // const SizedBox(height: 10),
                                      // if (value.item?.myPlan?.expiration !=
                                      //     null)
                                      //   if (DateTime.parse(value
                                      //               .item?.myPlan?.expiration ??
                                      //           "")
                                      //       .subtract(const Duration(
                                      //         days: 5,
                                      //       ))
                                      //       .isBefore(DateTime.now()))
                                      //     const SizedBox(height: 10),

                                      // recharge card
                                      // if (value.item != null)
                                      //   if (value.item?.myPlan?.expiration !=
                                      //       null)
                                      //     if (DateTime.parse(value.item?.myPlan
                                      //                 ?.expiration ??
                                      //             "")
                                      //         .subtract(const Duration(
                                      //           days: 5,
                                      //         ))
                                      //         .isBefore(DateTime.now()))
                                            // (DateTime.parse(value.item?.myPlan
                                            //           ?.expiration ??
                                            //       "")
                                            //   .isBefore(DateTime.now()))?Container(
                                            //     height: Get.height*0.12,
                                            //     width: Get.width*0.9,
                                                
                                            //     decoration: BoxDecoration(
                                            //       color:Colors.white,
                                            //       borderRadius:
                                            //         BorderRadius.circular(15),
                                            //     ),
                                            //     child: Padding(
                                            //       padding: const EdgeInsets.all(10.0),
                                            //       child: Center(child: Text("Ju e keni sherbim te pa-kompensuar te Post-Paid.",style: TextStyle(color: Theme.of(
                                            //                               context)
                                            //                           .highlightColor),)),
                                            //     ),
                                            //   ):Card(
                                            //   child: Container(
                                            //     height: 120,
                                            //     width: 415,
                                            //     decoration: BoxDecoration(
                                            //         image: const DecorationImage(
                                            //             image: AssetImage(
                                            //                 "assets/image/bg.PNG"),
                                            //             fit: BoxFit.cover),
                                            //         color: Colors.white,
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 8)),
                                            //     child: Padding(
                                            //       padding:
                                            //           const EdgeInsets.all(8.0),
                                            //       child: Column(
                                            //         crossAxisAlignment:
                                            //             CrossAxisAlignment
                                            //                 .start,
                                            //         children: [
                                            //           Text(
                                            //             "Paguaj Këtu",
                                            //             style: Theme.of(context)
                                            //                 .textTheme
                                            //                 .headline6!
                                            //                 .copyWith(
                                            //                     color: Colors
                                            //                         .blue
                                            //                         .shade800),
                                            //           ),
                                            //           Text(
                                            //             "L ${value.item?.myPlan?.amount}",
                                            //             style: Theme.of(context)
                                            //                 .textTheme
                                            //                 .headline6!
                                            //                 .copyWith(
                                            //                     color: Colors
                                            //                         .black),
                                            //           ),
                                            //           const SizedBox(height: 5),
                                            //           ElevatedButton(
                                            //               style: ElevatedButton
                                            //                   .styleFrom(
                                            //                       minimumSize:
                                            //                           const Size(
                                            //                               60,
                                            //                               30)),
                                            //               onPressed: () async {
                                            //                 Get.to(
                                            //                     const PayScreen(
                                            //                   isShowable: true,
                                            //                 ));
                                            //               },
                                            //               child: Text(
                                            //                 "Paguaj",
                                            //                 style: Theme.of(
                                            //                         context)
                                            //                     .textTheme
                                            //                     .bodySmall!
                                            //                     .copyWith(
                                            //                         color: Colors
                                            //                             .white),
                                            //               )),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                    ],
                                  ),
                                ),
                                /* if (DateTime.parse(value.item?.myPlan?.expiration)
                                    .subtract(const Duration(
                                      days: 5,
                                    ))
                                    .isBefore(DateTime.now()))*/
                                SizedBox(height: height * .02),
                              ],
                            )
                          : Stack(
                              children: [
                                // MyCacheNetworkImages(imageUrl: "https://www.actcorp.in/images/blogs/4-signs-you-should-upgrade-your-internet-plan-blog-image.webp", radius: 10, height: 200,),
                                Container(
                                    height: 150,
                                    width: width * .9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/image/bg.PNG",
                                            ),
                                            fit: BoxFit.cover))),
                                Positioned(
                                  left: 20,
                                  top: 10,
                                  child: Image.asset(
                                    "assets/image/ibclogo.png",
                                    height: 100,
                                    width: 170,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                    left: 15,
                                    bottom: 15,
                                    child: MyButton(
                                      title: "Shiko paketat",
                                      width: 160,
                                      height: 28,
                                      onTap: () {
                                        Get.to(const AllPlanList());
                                      },
                                    ))
                              ],
                            ),
                      SizedBox(height: height * .02),
                      Consumer<BannerProvider>(
                        builder: (context, value, child) => Container(
                            height: height * .3,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.banner.length,
                              clipBehavior: Clip.antiAlias,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(right: width * .050),
                                child: Center(
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: MyCacheNetworkImages(
                                        imageUrl: value.banner[index],
                                        radius: 15,
                                        height: width * .7,
                                        width: width * .42,
                                      )),
                                ),
                              ),
                            )),
                      ),
                      Consumer<HomeProvider>(
                        builder: (context, value, child) => Column(
                          children: [
                            SizedBox(height: height * .02),
                            Container(
                              height: height * .12,
                              width: double.infinity,
                              child: Visibility(
                                visible: !value.isLoading,
                                replacement: const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                                child: ListView.builder(
                                  itemCount: value.item?.services?.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                .07),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (index == 0) {
                                          Get.to(const ProfileScreen());
                                        } else if (index == 1) {
                                          Get.to(const StoreListScreen(
                                              index: true));
                                        } else {
                                          Get.to(
                                              const SupportScreen(index: true));
                                          // return Get.to(TabScreen(index: 3));
                                        }
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                .27,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .26,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MyCacheNetworkImages(
                                                imageUrl: value
                                                        .item
                                                        ?.services?[index]
                                                        .images ??
                                                    "",
                                                radius: 10,
                                                height: width * .080,
                                                width: width * .080,
                                              ),
                                              // Image.network(
                                              //   value.item?.services?[index].images ?? "",
                                              //   cacheHeight: 30,
                                              //   cacheWidth: 30,
                                              // ),
                                              SizedBox(height: height * .010),
                                              Text(
                                                value.item?.services?[index]
                                                        .name ??
                                                    "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline!
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 8),
                                              )
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * .02),
                            Container(
                              height: height * .2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, top: 8, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Teknologjia jonë",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: Colors.black),
                                    ),
                                    SizedBox(height: height * .01),
                                    Container(
                                      height: height * .13,
                                      width: double.infinity,
                                      child: Visibility(
                                        visible: !value.isLoading,
                                        replacement: const Center(
                                          child: CircularProgressIndicator
                                              .adaptive(),
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          // physics: NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              value.item?.technology?.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .285,
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  MyCacheNetworkImages(
                                                    imageUrl: value
                                                            .item
                                                            ?.technology?[index]
                                                            .images ??
                                                        "",
                                                    radius: 10,
                                                    height: width * .12,
                                                    width: width * .12,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    value
                                                            .item
                                                            ?.technology?[index]
                                                            .name ??
                                                        "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isPostpaidLoading == true)
              const Center(
                child: CircularProgressIndicator.adaptive(),
              )
          ],
        ),
      ),
    );
  }




}

class BadgeWidget extends StatelessWidget {
  final int badgeCount;
  final Widget child;

  BadgeWidget({required this.badgeCount, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        child,
        badgeCount > 0
            ? Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  '$badgeCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : Container(),
      ],
    );
  }
}



