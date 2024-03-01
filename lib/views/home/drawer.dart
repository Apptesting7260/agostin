import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
import 'package:ibc_telecom/views/contact_us/contact_us.dart';
import 'package:ibc_telecom/views/profile/profile_screen.dart';
import 'package:ibc_telecom/views/speed_test_screen/speed_test.dart';
import 'package:ibc_telecom/views/user/login_screen.dart';
import 'package:ibc_telecom/shared_pref/preference.dart';
import 'package:ibc_telecom/views/order/order_screen.dart';
import 'package:ibc_telecom/views/user/option_screen.dart';
import 'package:ibc_telecom/views/user/register_screen.dart';
import 'package:ibc_telecom/widget/my_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;
import '../about_us/about_us_screen.dart';
import '../notification/notification_screen.dart';
import '../store/store_screen.dart';

class MyDrawer extends StatelessWidget {
  final String userName;
  final int userId;

  MyDrawer({Key? key, required this.userName, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.white,
      child: Column(children: [
        DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
            ),
            child: userId != 0
                ? Row(
                    children: [
                      Image.asset(
                        "assets/icon/profile.PNG",
                        cacheHeight: 60,
                        cacheWidth: 60,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(60, 25)),
                              onPressed: () {
                                Get.back();
                                Get.to(const ProfileScreen());
                              },
                              child: Text(
                                "Shiko Profili Im ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              ))
                        ],
                      )
                    ],
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icon/profile.PNG",
                          cacheHeight: 60,
                          cacheWidth: 60,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // TextButton(onPressed: () {
                            //   Get.back();
                            //   Get.to(LoginScreen());
                            // }, child: Text("Login", style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).errorColor),)),
                            MyButton(
                              title: "Login",
                              height: 30,
                              width: 100,
                              radius: 5,
                              style: Theme.of(context).textTheme.bodyMedium,
                              onTap: () {
                                Get.back();
                                Get.to(const LoginScreen());
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // TextButton(onPressed: () {
                            //   Get.back();
                            //   Get.to(RegisterScreen());
                            // }, child: Text("Register", style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).errorColor),)),
                            MyButton(
                              title: "Register",
                              height: 30,
                              width: 100,
                              radius: 5,
                              style: Theme.of(context).textTheme.bodyMedium,
                              onTap: () {
                                Get.back();
                                Get.to(const RegisterScreen());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
        ListTile(
          onTap: () {
            Get.back();
            Get.to(const AboutUsScreen());
          },
          leading: const Icon(Icons.info_outline, color: Colors.red),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            "Rreth Kompanise",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
        ),
        userId != 0
            ? ListTile(
                onTap: () {
                  Get.back();
                  Get.to(const OrderScreen());
                },
                leading: const Icon(Icons.history, color: Colors.red),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  "Historiku I Pagesave",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
              )
            : const SizedBox(),
        userId != 0
            ? ListTile(
                onTap: () {
                  Get.back();
                  Get.to(const NotificationScreen());
                },
                leading:
                    const Icon(Icons.notifications_none, color: Colors.red),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                title: Text(
                  "Njoftime",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
              )
            : const SizedBox(),
        ListTile(
          onTap: () {
            Get.back();
            // Get.to(TabScreen(index: 3));
            Get.to(const SupportScreen(index: true));
          },
          leading: const Icon(Icons.support_agent_outlined, color: Colors.red),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            "Shërbimi Klientit",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.to(const StoreListScreen(index: true));
            // Get.to(TabScreen(index: 2));
          },
          leading: const Icon(Icons.local_convenience_store_outlined,
              color: Colors.red),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            "Dyqanet",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () {
            Get.back();

            _launchUrl();
            // Get.to(const SpeedTestScreen());
          },
          leading: const Icon(Icons.speed_outlined, color: Colors.red),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            "Testi i shpejtësisë",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
        ),
        const Spacer(),
        userId != 0
            ? SizedBox(
                width: MediaQuery.of(context).size.width * .3,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(60, 35),
                        maximumSize:
                            Size(MediaQuery.of(context).size.width * .6, 35)),
                    onPressed: () {
                      DeletFcm();
                     
                    },
                    child: Text(
                      "DIL",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    )),
              )
            : const SizedBox(),
        const SizedBox(
          height: 50,
        )
      ]),
    );
  }

  String _url = "https://www.speedtest.net/";

  _launchUrl() async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }



  void DeletFcm() async {
  try {
    var response = await http.post(
      Uri.parse('https://api-payment.ibc.al/api/get-fcm-token'),
      body: {'cust_id': userId.toString()},
    );

    if (response.statusCode == 200) {
       final fcmToken = MySharedPreferences.localStorage
                          ?.getString(MySharedPreferences.deviceId);
                      MySharedPreferences.localStorage?.clear();
                      MySharedPreferences.localStorage
                          ?.setString("device_id", fcmToken ?? "");

                      Get.offAll(const OptionScreen());
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    print('Error: $error');
  }
}

}
