
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
import 'package:ibc_telecom/shared_pref/preference.dart';
import 'package:ibc_telecom/utils/urls.dart';
import 'package:ibc_telecom/views/user/login_screen.dart';
import 'package:ibc_telecom/widget/my_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:new_pinput/new_pinput.dart';
import 'package:http/http.dart'as http;
import 'package:fluttertoast/fluttertoast.dart';

class PinFieldssignup extends StatefulWidget {
final String id;
  final String mobile;
  final String countryCode;
  final String? username;
  final String nav;

  const PinFieldssignup({
    Key? key,
    required this.mobile,
    required this.nav,
    required this.countryCode,
    required this.id,
    this.username,
  }) : super(key: key);


  @override
  State<PinFieldssignup> createState() => _PinFieldssignupState();
}

class _PinFieldssignupState extends State<PinFieldssignup> {
  bool ResendOtpControllerInstanse = false;
  bool isloading=false;


  final TextEditingController OtpVarificationControllerinstace =
      TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  // var time = 30;
  var count = "00";
  // late Timer _timer;
  int _start = 60;
  late Timer _timer;

  // void startTimer() {
  //   const oneSecond = Duration(seconds: 1);
  //   _timer = Timer.periodic(oneSecond, (timer) {
  //     if (time >= 1) {
  //       setState(() {
  //         time--;
  //         if (time.toString().length == 2) {
  //           count = time.toString();
  //         } else {
  //           count = "0$time";
  //         }
  //       });
  //     }
  //   });
  // }
void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  bool verifyloading=false;

  //   loginApi() async {
  //   print("started");
  //   final body = {
  //     "cust_id": costomerid,
  //     "mob_no": mobilenumber,
  //     "country_code": mobilecode,
  //     "device_id": fcmToken,
  //     "otp": OtpVarificationControllerinstace.text,
  //   };
  //   print(body);
  //   final response = await http.post(Uri.parse(loginURL), body: body);

  //   print("loginResponse== ${response.toString()}");

  //   if (response.statusCode != 200) {
  //     return;
  //   }
  //   final parse = jsonDecode(response.body);
  //   print("parse==$parse");
  //     showToast();

  //   // if (parse["status"] != "Success") {
  //   //   return Get.dialog(AlertDialog(
  //   //     title: const Text('This term it should not be visible '),
  //   //     content:
  //   //         const Text("Nuk mund te procedoni pa u rregjistruar fillimisht"),
  //   //     actions: [
  //   //       TextButton(
  //   //         child: const Text("Mbyll"),
  //   //         onPressed: () => Get.to(RegisterScreen()),
  //   //       ),
  //   //     ],
  //   //   ));
  //   // }

  // }
  create() async {
    final body = {
      "id": widget.id,
      "mob_no":widget.mobile,
    };
    // print("abc");
    try {
      final response = await http.post(
        Uri.parse(baseURL+"create"),
        body: body,
      );
      final parse = jsonDecode(response.body);
      print(parse);
      // print("parse====$parse");
      if (parse["status"] != "Success") {
        // idcontroller.clear();
        // namecontroller.clear();
        // mobilecontroller.clear();
        // setState(() {
        //   loading = false;
        // });
        return showToast2(parse["message"]);
        // showSnackBar(title: "Response", description: parse["message"]);
      }
      setState(() {
        if (parse["status"] == "Success") {
          startTimer();
          verifyloading=true;
          // print(parse["status"]);

          // Get.to(PinFieldssignup(
          //   username: namecontroller.text,
          //   id: idcontroller.text,
          //   mobile: mobilecontroller.text,
          //   countryCode: _selectedCountryCode,
          //   nav: "register",
          // ));
          // register();
        }
      });
    } on Exception catch (e) {
      // TODO
    }finally{
      // setState(() {
      //   loading = false;
      // });
    }
  }
void showToast() {
    Fluttertoast.showToast(
      msg: 'Otp Sent Successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  @override
  Widget build(BuildContext context) {
    final BoxDecoration _pinPutDecoration = BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(15.0), // Adjust the border radius
    );

    final defaultPinTheme = PinTheme(
      width:45,
      height: 45,
      textStyle: TextStyle(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10), // Adjust the border radius
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Colors.blue.shade900,
      border: Border.all(color: Colors.green),
      borderRadius: BorderRadius.circular(15.0), // Adjust the border radius
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0), // Adjust the border radius
      ),
    );

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text("Verification Screen"),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
        
                SizedBox(height: Get.height*0.2,),
                Center(
                  child: Text(
                    "Shkruani kodin e verifikimit\n       që ju kemi dërguar",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: height * .05,
                ),
                Container(
                  child: Center(
                    child: Pinput(
                      validator: (value) {
                        if (value!.isEmpty || value.length != 6) {
                          return "Ju lutemi shkruani kodin tuaj 6 shifror";
                        } else {
                          return null;
                        }
                      },
                      
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      pinContentAlignment: Alignment.topCenter,
                      length: 6,
                      autofocus: true,
                      useNativeKeyboard: true,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      onSubmitted: (String pin) => _showSnackBar(pin, context),
                      focusNode: _pinPutFocusNode,
                      controller: OtpVarificationControllerinstace,
                      followingPinTheme: defaultPinTheme,
                    ),
                  ),
                ),
                SizedBox(height: height * .05),
           if(verifyloading==false)     InkWell(
                  child: Center(
                    child: ResendOtpControllerInstanse == false
                        ? InkWell(
                          child: Text(
                              "Ridërgo Otp",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.blue),
                            ),onTap: (() {
                               create();
                            }),
                        )
                        : LoadingAnimationWidget.inkDrop(
                            color: Colors.white,
                            size: 20,
                          ),
                  ),
                  onTap: () {
                    setState(() {
                      startTimer();
                    });
                  },
                ),
if(verifyloading==true) Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(_start.toString(),style: TextStyle(color: Colors.black),),
  ],
),
SizedBox(height: Get.height*0.02,),


                  Center(
                      child: MyButton(
                        // loading: isloading,
                        width: 150,
                        height: 40,
                        title: "verifiko",
                        onTap: () {
                          
register();
                        },
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }

//  verifyotp() async {
//   var url = Uri.parse('https://api-payment.ibc.al/api/verify-otp');
//   var response = await http.post(url, body: {
//     'mob_no': mobilenumber,
//     'otp': OtpVarificationControllerinstace.text,
//   });
// print(OtpVarificationControllerinstace.text,);
//   if (response.statusCode == 200) {
//     final parse = jsonDecode(response.body);
//     print(parse);
//     setState(() {
//       MySharedPreferences.localStorage
//           ?.setString("fullName", parse["data"]["username"]);

//       MySharedPreferences.localStorage?.setString("mobile", parse['data']["mobile"]);
//       MySharedPreferences.localStorage
//           ?.setString("service", parse["data"]["service"]);

//       MySharedPreferences.localStorage
//           ?.setInt("customer_id", parse["data"]["id"]);

//       MySharedPreferences.localStorage?.setBool("login", true);

//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TabScreen(index: 0),
//           ));
//       // setState(() {
//       //   loading = false;
//       // });
//     });
     
//     print(response.body);
//   } else {
//     print(response.reasonPhrase);
//   }
// }
  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).highlightColor,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
void showToast2(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
register() async {
   setState(() {
      isloading=true;
    });
    print("on register");
    final body = {
      "cust_id": widget.id,
      "mobile": widget.mobile,
      "device_id": fcmToken,
      
      "otp": OtpVarificationControllerinstace.text,
    };
    print(body);
    final response = await http.post(
      Uri.parse(registerURL),
      body: body,
    );
    final parse = jsonDecode(response.body);
    // print(parse);
    if (parse['status']=="Failed") {
           Get.dialog(AlertDialog(
        title: const Text('This term it should not be visible '),
        content:
             Text("${parse['message']}"),
        actions: [
          TextButton(
            child: const Text("Mbyll"),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
        ],
      ));
    
      // setState(() {
      //   loading = false;
      // });
      print("dsfdsfdsfdsafsdfsdf");
       setState(() {
      isloading=false;
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
      // setState(() {
      //   loading = false;
      // });
       setState(() {
      isloading=false;
    });
    });
  }



}

