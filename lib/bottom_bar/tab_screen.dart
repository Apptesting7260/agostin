import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/provider/home_provider.dart';
import 'package:ibc_telecom/utils/add_api.dart';
import 'package:ibc_telecom/utils/urls.dart';
import 'package:ibc_telecom/views/notification/notification_model.dart';
import 'package:ibc_telecom/views/notification/notification_screen.dart';
import 'package:ibc_telecom/views/profile/profile_screen.dart';
import 'package:ibc_telecom/views/store/store_screen.dart';
import 'package:ibc_telecom/views/user/login_screen.dart';
import 'package:ibc_telecom/widget/all_list_widget.dart';
import 'package:provider/provider.dart';
import '../shared_pref/preference.dart';
import '../views/home/drawer.dart';
import '../views/home/home_screen.dart';
import '../views/contact_us/contact_us.dart';
import '../views/pay/pay_screen.dart';
import '../views/store/store_model.dart';
import 'bottom_navigation.dart';

class TabScreen extends StatefulWidget {
  final int index;

  const TabScreen({Key? key, required this.index}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final NotificationModel NotificationModels=NotificationModel();
  int? bottomSelectedIndex;
  PageController? pageController;
  DateTime currentBackPressTime = DateTime.now();
  bool loading = false;
  var data;
  String userName = '';
  int user_id = 0;
int badcount=0;
  @override
  void initState() {
    // fetchApi();
    // TODO: implement initState
    userName = MySharedPreferences.localStorage
            ?.getString(MySharedPreferences.fullName) ??
        "";
    user_id = MySharedPreferences.localStorage
            ?.getInt(MySharedPreferences.customerId) ??
        0;
print(user_id);

    bottomSelectedIndex = widget.index;
    pageController = PageController(initialPage: widget.index, keepPage: true);

    callProviderApi();
    // a();
  
    super.initState();
    // studentType = MySharedPreferences.localStorage?.getString(MySharedPreferences.studentType) ?? "";
  }

  callProviderApi() async {
   // await Apis(context).callProviderApi();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeProvider>(context, listen: false).getHomeData();
    });


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<BannerProvider>(context, listen: false).getBannerData();
    });

    // user_id != 0 ? getInvoiceDate() : null;
    apiGetStore();

  }

  // getInvoiceDate() async {
  //   final response = await get(
  //     Uri.parse(
  //         baseURL+"invoice/user-id/$user_id"),
  //   );
  //   final parse = jsonDecode(response.body);
  //
  //   if (response.statusCode != 200) {
  //     return;
  //   }
  //   if (response.statusCode == 200) {
  //     return
  //         parse["details"]["clientExpiration"] + "T00:00:00.000000Z";
  //   }
  //
  //   // print(banner.length);
  //   // print("date====${AllList.date}");
  //   // return AllList.date;
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
//         'cust_id':user_id
//       });
//       final parse = jsonDecode(response.body);
// print(parse);
//    badcount=parse['Count'];
//    print("$badcount========count");
   

//       setState(() {
//       badcount;
//         final notificationData = NotificationModel.fromJson(parse);
//         // badcount=notificationData.Count;
//         // print("$badcount===============");
//       print(notificationData);
//         notification = notificationData.listnotification ?? [];
//         // notificationpublic= notificationData.publicNotification ?? [];
//       });
//     } on Exception catch (e) {
//       // TODO
//     }finally{
//       setState(() {
//         isLoading= false;
//       });
//     }
//   }
  apiGetStore() async {
    setState(() {
      loading = true;
    });
    print("abc");
    final response =
    await get(Uri.parse("${baseURL}get-stores"));
    final parse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      return;
    }
    print("storeserrors============");
    setState(() {
      final _storesModel = StoresModel.fromJson(parse);
      AllList.storesList.clear();
      AllList.storesList = _storesModel.allStores ?? [];
      print(AllList.storesList.length);
      loading = false;
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;

  
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        appBar: user_id != 0
            ? AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (scaffoldKey.currentState!.isDrawerOpen) {
                        scaffoldKey.currentState!.openEndDrawer();
                      } else {
                        scaffoldKey.currentState!.openDrawer();
                      }
                    },
                    child: Image.asset(
                      "assets/icon/menu.PNG",
                      cacheHeight: 25,
                      cacheWidth: 25,
                    ),
                  ),
                ),
                 actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BadgeWidget(
                badgeCount:badcount,
                child: GestureDetector(
                  onTap: () {
                    Get.to(NotificationScreen());
                  },
                  child: Image.asset(
                    "assets/icon/icon-1.PNG",
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.to(ProfileScreen());
              },
              child: Image.asset(
                "assets/icon/profile.PNG",
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],)
            : AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (scaffoldKey.currentState!.isDrawerOpen) {
                        scaffoldKey.currentState!.openEndDrawer();
                      } else {
                        scaffoldKey.currentState!.openDrawer();
                      }
                    },
                    child: Image.asset(
                      "assets/icon/menu.PNG",
                      cacheHeight: 25,
                      cacheWidth: 25,
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                      onTap: () {
                        Get.off(LoginScreen());
                      },
                      child: Icon(
                        Icons.login,
                        size: 30,
                      )),
                  SizedBox(
                    width: 20,
                  )
                ],
              ),
        drawer: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20)),
            child: MyDrawer(
              userName: userName,
              userId: user_id,
            )),
        body: RefreshIndicator(
          onRefresh: () {
            return callProviderApi();
          },
          child: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: user_id != 0
                  ? PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) => pageChanged(index),
                      children: [
                        HomeScreen(),
                        PayScreen(),
                        StoreListScreen(),
                        SupportScreen(),
                      ],
                    )
                  : PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) => pageChanged(index),
                      children: [
                        HomeScreen(),
                        StoreListScreen(),
                        SupportScreen(),
                      ],
                    ),
            ),
          ),
        ),
        bottomNavigationBar: Bottom(
          user_id: user_id,
          bottomSelectedIndex: bottomSelectedIndex!,
          bottomTapped: bottomTapped,
        ),
      ),
    );
  }

  void bottomTapped(int index) {
    setState(
      () {
        bottomSelectedIndex = index;
        pageController!.animateToPage(index,
            duration: const Duration(microseconds: 1), curve: Curves.ease);
      },
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  Future<bool> _onWillPop() {
    if (bottomSelectedIndex != 1) {
      setState(
        () {
          pageController!.jumpTo(0);
        },
      );
      return Future.value(false);
    } else if (bottomSelectedIndex == 1) {
      setState(
        () {
          pageController!.jumpTo(1);
        },
      );
      return Future.value(false);
    }
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(milliseconds: 500)) {
      currentBackPressTime = now;
      return Future.value(false);
    } else {
      SystemNavigator.pop();
    }
    return Future.value(true);
  }

  goAtLikeTab() {
    pageController!.animateToPage(1,
        duration: const Duration(microseconds: 1), curve: Curves.ease);
  }
}
