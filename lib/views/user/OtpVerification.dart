import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
import 'package:ibc_telecom/utils/urls.dart';
import 'package:ibc_telecom/views/home/home_screen.dart';
import 'package:ibc_telecom/views/pin_fields.dart';

import '../../shared_pref/preference.dart';
import '../../utils/device_size.dart';
import '../../utils/indicator.dart';
import '../../utils/snack_bar.dart';
import '../../widget/my_button.dart';
import 'package:http/http.dart'as http;
class OtpVerify extends StatefulWidget {
  final String id;
  final String mobile;
  final String countryCode;
  final String? username;
  final String nav;

  const OtpVerify({
    Key? key,
    required this.mobile,
    required this.nav,
    required this.countryCode,
    required this.id,
    this.username,
  }) : super(key: key);

  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  bool loading = false;
  bool resendCode = false;
  String? verId;
  Timer? timerController;
  int currentSeconds = 0;
  final int timerMaxSeconds = 60;
  final formKey = GlobalKey<FormState>();
  TextEditingController pinPutController = TextEditingController();
  final pinPutFocusNode = FocusNode();
  String fcmToken = "";
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    verifyPhone();
    getFcmToken();
  }

  getFcmToken() {
    firebaseMessaging.getToken().then((String? token) async {
      if (token == null) {
      } else {
        fcmToken = token;

        print("token===$token");
      }
    }).catchError((error) {
      print(error.toString());
    });
  }

  startTimeout() {
    var duration = const Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      setState(() {
        timerController = timer;
        //print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timerController?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceUtils.hideKeyboard(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: const CustomBackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0, // 1
          title: const Text(
            'Hyr',
            style: TextStyle(color: Colors.black),
          ),
        ),
        // appBar: AppBar(),
        body: Indicator(
          loaderState: loading,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Center(
                          child: Text(
                        "Ne ju dërguam kodin OTP 6-shifror për ta verifikuar\nNumri juaj i telefonit",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(height: 10),
                      Text(
                        "Dërguar në +${widget.countryCode}${widget.mobile}",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      PinFields(
                          formKey: formKey,
                          controller: pinPutController,
                          pinPutFocusNode: pinPutFocusNode),
                      const SizedBox(height: 20),
                      Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: currentSeconds != timerMaxSeconds
                                  ? () {}
                                  : () {
                                      verifyPhone();
                                      //print("Resend");
                                    },
                              child: Text(
                                  currentSeconds != timerMaxSeconds
                                      ? "${timerMaxSeconds - currentSeconds} Sec"
                                      : "Dërgo OTP përsëri",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).highlightColor)))),
                    ],
                  ),
                  const Spacer(),
                  MyButton(
                    title: "Vazhdo me tej ",
                    onTap: () async {
                      final signature = pinPutController.text;
                      //print(signature);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> const TabScreen()));
                      verifyPin();
                      // Get.to(OtpVerify());
                    },
                  ),
                  SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhone() async {
    if (loading == true) {
      //print("wait..");
      return;
    } else {
      setState(() {
        loading = true;
      });
    }
    final phone = widget.mobile;
    print("phone  = +${widget.countryCode}${widget.mobile}");
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+${widget.countryCode}${widget.mobile}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          final user =
              await FirebaseAuth.instance.signInWithCredential(credential);
          if (user.user != null) {
            loginApi();
            // return;
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          Navigator.pop(context);
          if (e.code == 'numër i pavlefshëm i telefonit') {
            print('The provided phone number is not valid.');
          }
          setState(() {
            resendCode = false;
            verId = null;
            loading = false;
          });
          print(e.message);
          showSnackBar(
              title: "utentifikimi i telefonit", description: "${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          pinPutController.clear();
          // startTimeout();
          setState(() {
            loading = false;
            verId = verificationId;
          });
          //print("OTP Send");
          startTimeout();
          // Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneVerify(verification: verId,body: body)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 60));
  }

  Future<void> verifyPin() async {

    if (verId == null) {
      // //printToast("");
      return;
    }

    DeviceUtils.hideKeyboard(context);
    if (loading == true) {
      //print("wait..");
      return;
    } else {
      setState(() {
        loading = true;
      });
    }
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verId!, smsCode: pinPutController.text);
    try {
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      if (user.user == null) {
        return;
      }
      if (widget.nav == "login") {
        loginApi();
      } else {
        register();
        loading = false;
      }
    } on SocketException {
    } on FirebaseAuthException catch (e) {
      showSnackBar(description: "${e.message}");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  loginApi() async {
    print("started");
    final body = {
      "cust_id": widget.id,
      "mob_no": widget.mobile,
      "country_code": widget.countryCode,
      "device_id": fcmToken
    };

    print(body);
    final response = await post(Uri.parse(loginURL), body: body);

    print("loginResponse== ${response.toString()}");

    if (response.statusCode != 200) {
      return;
    }
    final parse = jsonDecode(response.body);
    print("parse==$parse");

    if (parse["status"] != "Success") {
      return;
    }
getalirt();
   setState(() {
      // print(parse["details"]["id"].toString());

      MySharedPreferences.localStorage
          ?.setString("fullName", parse["details"]["username"]);
      MySharedPreferences.localStorage
          ?.setString("service", parse["details"]["service"]);

      MySharedPreferences.localStorage?.setString("mobile", parse["mobile"]);

      MySharedPreferences.localStorage
          ?.setInt("customer_id", parse["details"]["id"]);

      MySharedPreferences.localStorage?.setBool("login", true);


      Get.off(TabScreen(index: 0));

      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => TabScreen(index: 0),
      //     ));
    });
 
  }

  register() async {
    print("on register");
    final body = {
      "cust_id": widget.id,
      "mobile": widget.mobile,
      "device_id": fcmToken
    };
    final response = await post(
      Uri.parse(registerURL),
      body: body,
    );
    final parse = jsonDecode(response.body);
    print(parse);
    if (response.statusCode != 200) {
      setState(() {
        loading = false;
      });
      return;
    }
    setState(() {
      MySharedPreferences.localStorage
          ?.setString("fullName", parse["details"]["username"]);

      MySharedPreferences.localStorage?.setString("mobile", parse["mobile"]);
      MySharedPreferences.localStorage
          ?.setString("service", parse["details"]["service"]);

      MySharedPreferences.localStorage
          ?.setInt("customer_id", parse["details"]["id"]);

      MySharedPreferences.localStorage?.setBool("login", true);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TabScreen(index: 0),
          ));
      setState(() {
        loading = false;
      });
    });
  }


  void getalirt() async {
  try {
    var response = await http.get(
      Uri.parse('https://api-payment.ibc.al/api/alert-notification/user-id/$user_id'),
    );

    if (response.statusCode == 200) {
      

    } else {
      print(response.reasonPhrase);
    }
  } catch (error) {
    print('Error: $error');
  }
}
}
