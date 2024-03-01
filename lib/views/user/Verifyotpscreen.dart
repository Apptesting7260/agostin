// import 'dart:async';




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:new_pinput/new_pinput.dart';




// class PinFields extends StatefulWidget {
//   // final Key formKey;
//   // final FocusNode pinPutFocusNode;

//   const PinFields(
//       {Key? key,
//       })
//       : super(key: key);

//   @override
//   State<PinFields> createState() => _PinFieldsState();
// }

// class _PinFieldsState extends State<PinFields> {
// bool ResendOtpControllerInstanse=false;

// final TextEditingController OtpVarificationControllerinstace=TextEditingController();
//   final FocusNode _pinPutFocusNode = FocusNode();
// @override
//   void initState() {
  
//     // TODO: implement initState
//     super.initState();
//     startTimer();
//   }
//   // BoxDecoration get _pinPutDecoration {
//   //   return BoxDecoration(
//   //     border: Border.all(color: Color(0xff2a319c)),
//   //     borderRadius: BorderRadius.circular(15.0),
//   //   );
//   // }
// var time=30;
// var count="00";
// late Timer _timer;
// void startTimer() {
//   const oneSecond = Duration(seconds: 1);
//   _timer = Timer.periodic(oneSecond, (timer) {

//   if(time>=1){
//     setState(() {
//       time--;
//      if( time.toString().length==2){
//        count=time.toString();
//      }
//      else{
//        count="0$time";
//      }

//     });
//   }


//   });
// }
//   @override
//   Widget build(BuildContext context) {
//     final BoxDecoration _pinPutDecoration = BoxDecoration(
//         color:  Colors.white,
//         // borderRadius: BorderRadius.circular(5.0),
//         border: Border.all());
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: TextStyle(
//           fontSize: 30, color: Colors.black, fontWeight: FontWeight.w600),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(40),
//       ),
//     );
//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       color: Colors.blue.shade900,
//       border: Border.all(color: Colors.green),
//       borderRadius: BorderRadius.circular(50),
//     );

//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration!.copyWith(
//           color:Colors.white,
//           borderRadius: BorderRadius.circular(50)
//       ),
//     );

//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Padding(
//           padding: const EdgeInsets.only(top: 10),
//           child: Text("Verification Screen"),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(

//         color: Colors.white,
//         child: Form(
//           // key: widget.formKey,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView(
//               children: [
//               //   SizedBox(
//               //     height: height * .1,
//               //   ),
//               //  Center(
//               //    child:Text(count.toString(),style: TextStyle(color: Color(0xffFE0091),fontWeight: FontWeight.bold,fontSize: 25),) ,
//               //  ),
//               //   SizedBox(
//               //     height: height * .05,
//               //   ),
//                 Center(
//                   child: Text(
//                     "Type the verification code\n         we've sent you",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium!
//                         .copyWith(color: Colors.black),
//                   ),
//                 ),
//                 SizedBox(
//                   height: height * .05,
//                 ),
//                 /*Pinput(
        
//                 validator: (s) {
//                   if (s?.contains('1')??false) return null;
//                   return 'NOT VALID';
//                 },
//                 useNativeKeyboard: true,
//                 length: 6,
//                 // fieldsCount: 6,
        
//                 fieldsAlignment: MainAxisAlignment.spaceAround,
//                 textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
//                 eachFieldMargin: const EdgeInsets.all(0),
//                 eachFieldWidth: 45.0,
//                 eachFieldHeight: 55.0,
//                 onSubmit: (String pin) => DeviceUtils.hideKeyboard(context),
//                 focusNode: widget.pinPutFocusNode,
//                 controller: widget.controller,
//                 submittedFieldDecoration: pinPutDecoration.copyWith(
//                   color: Colors.white,
        
//                 ),
//                 selectedFieldDecoration: pinPutDecoration.copyWith(
//                   color: Colors.white,
//                   border: Border.all(
//                     width: 2,
//                     color:  Colors.black,
//                   ),
//                 ),
        
//                 followingFieldDecoration: pinPutDecoration.copyWith(color: Colors.white),
//                 pinAnimationType: PinAnimationType.scale,
//               ),*/
//                 Center(
//                   child: Pinput(
//                     validator: (value) {
//                       if (value!.isEmpty && value.length != 6) {
//                         return "Please enter your 6 digit pin";
//                       } else {
//                         return null;
//                       }
//                     },
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     length: 6,
//                     autofocus: true,
//                     //
//                     // validator: (s) {
//                     //   if (s?.contains('1')??false) return null;
//                     //   return 'NOT VALID';
//                     // },
//                     useNativeKeyboard: true,
//                     keyboardType: TextInputType.number,
//                     defaultPinTheme: defaultPinTheme,
//                     focusedPinTheme: focusedPinTheme,
//                     submittedPinTheme: submittedPinTheme,
//                     onSubmitted: (String pin) => _showSnackBar(pin, context),
//                     focusNode: _pinPutFocusNode,
//                     controller: OtpVarificationControllerinstace,
                    
//                     // submittedPinTheme: PinTheme(
//                     //     height: 56,
//                     //     width: 56,
//                     //     decoration: BoxDecoration(
//                     //         borderRadius: BorderRadius.circular(40.0),
//                     //         border: Border.all(color: Color(0xffFE0091)),
//                     //         color: Color(0xffFe0091))),
//                     // focusedPinTheme: defaultPinTheme,
//                     followingPinTheme: defaultPinTheme,
//                   ),
//                 ),
//                 SizedBox(height: height * .05),
//               // Obx(() => Center(
//               //     child: MyButton(
//               //       loading: OtpVarificationControllerinstace.loading.value,
//               //       title: "Verify",
//               //       onTap: () {
//               //         OtpVarificationControllerinstace.OtpVerificationapiiHit(context);
                    
//               //       },
//               //     ),
//               //   ),)  ,
//                 SizedBox(height: height * .05),
//                InkWell(
//                   child: Center(
//                     child: ResendOtpControllerInstanse==false? Text(
//                       "Resend Otp",
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium!
//                           .copyWith(color:Colors.white),
//                     ):  LoadingAnimationWidget.inkDrop(
//          color:Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                   onTap: (){
//                     setState(() {
//                       startTimer();
//                     });
//                     // ResendOtpControllerInstanse.ResendOtpapiiHit();
//                   },
//                )
        
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showSnackBar(String pin, BuildContext context) {
//     final snackBar = SnackBar(
//       content: Container(
//         height: 80.0,
//         child: Center(
//           child: Text(
//             'Pin Submitted. Value: $pin',
//             style: const TextStyle(fontSize: 25.0),
//           ),
//         ),
//       ),
//       backgroundColor: Theme.of(context).highlightColor,
//     );
//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(snackBar);
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
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

class PinFieldssignin extends StatefulWidget {
  final String mobile;
   PinFieldssignin(this.mobile,{Key? key}) : super(key: key);

  @override
  State<PinFieldssignin> createState() => _PinFieldssigninState();
}

class _PinFieldssigninState extends State<PinFieldssignin> {
  bool ResendOtpControllerInstanse = false;
  bool isloading=false;
  final TextEditingController OtpVarificationControllerinstace =
      TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  var time = 30;
  var count = "00";
  late Timer _timer;

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      if (time >= 1) {
        setState(() {
          time--;
          if (time.toString().length == 2) {
            count = time.toString();
          } else {
            count = "0$time";
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

    loginApi() async {
      setState(() {
      isloading=true;
    });
    print("started");
    final body = {
      "cust_id": costomerid,
      "mob_no": mobilenumber,
      "country_code": mobilecode,
      "device_id": fcmToken
    };
    print(body);
    final response = await http.post(Uri.parse(loginURL), body: body);

    print("loginResponse== ${response.toString()}");
final parse = jsonDecode(response.body);
    if (response.statusCode != 200) {
      setState(() {
      isloading=false;
    });
     showToast(parse['message']);
      return;
    }else{
      setState(() {
      isloading=true;
    });
    }
    
    print("parse==$parse");
       showToast(parse['message']);

    // if (parse["status"] != "Success") {
    //   return Get.dialog(AlertDialog(
    //     title: const Text('This term it should not be visible '),
    //     content:
    //         const Text("Nuk mund te procedoni pa u rregjistruar fillimisht"),
    //     actions: [
    //       TextButton(
    //         child: const Text("Mbyll"),
    //         onPressed: () => Get.to(RegisterScreen()),
    //       ),
    //     ],
    //   ));
    // }

  }
void showToast(String msg) {
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
          child: Text("Ekrani i verifikimit"),
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
                Center(
                  child: Pinput(
                    validator: (value) {
                      if (value!.isEmpty || value.length != 6) {
                        return "Ju lutemi shkruani kodin tuaj 6 shifror";
                      } else {
                        return null;
                      }
                    },
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
                SizedBox(height: height * .05),
                InkWell(
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
                              loginApi();
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

SizedBox(height: Get.height*0.02,),


              if(isloading==false)    Center(
                      child: MyButton(
                        // loading: isloading,
                        width: 150,
                        height: 40,
                        title: "verifiko",
                        onTap: () {
                             setState(() {
                            isloading=true;
                         Timer(Duration(seconds: 2), () { 
                          setState(() {
                              isloading=false;
                          });
                           
                         });
                          });
                          verifyotp() ;
                        },
                      ),
                    ),
    if(isloading==true)Center(child: SizedBox(
      width: 150 ?? double.infinity,
      height: 40 ?? 60,
 
      
      child: ElevatedButton(
        onPressed: (() {
          
        }),
        child: CupertinoActivityIndicator(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
            alignment: Alignment.center,
            // textStyle: style ?? const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular( radius ?? 8))
        ),
      ),
    )),
                    // if(isloading==true)
              ],
            ),
          ),
        ),
      ),
    );
    
  }
 verifyotp() async {
     setState(() {
      isloading=true;
    });
    
  var url = Uri.parse('https://api-payment.ibc.al/api/verify-otp');
  var response = await http.post(url, body: {
    'mob_no': mobilenumber,
    'otp': OtpVarificationControllerinstace.text,
  });
print(OtpVarificationControllerinstace.text,);
    final parse = jsonDecode(response.body);
  if (response.statusCode == 200) {
       setState(() {
      isloading=false;
    });
  

    print(parse);
    setState(() {
      MySharedPreferences.localStorage
          ?.setString("fullName", parse["data"]["username"]);

      MySharedPreferences.localStorage?.setString("mobile", widget.mobile);
      MySharedPreferences.localStorage
          ?.setString("service", parse["data"]["service"]);

      MySharedPreferences.localStorage
          ?.setInt("customer_id", parse["data"]["id"]);

      MySharedPreferences.localStorage?.setBool("login", true);
     showToast(parse['message']);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TabScreen(index: 0),
          ));
      // setState(() {
      //   loading = false;
      // });
    });
     
    print(response.body);
  } else {
         showToast(parse['message']);
       setState(() {
      isloading=false;
    });
  
    print(response.reasonPhrase);
  }
}
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

// register() async {
//     print("on register");
//     final body = {
//       "cust_id": widget.id,
//       "mobile": widget.mobile,
//       "device_id": fcmToken
//     };
//     final response = await post(
//       Uri.parse(registerURL),
//       body: body,
//     );
//     final parse = jsonDecode(response.body);
//     print(parse);
//     if (response.statusCode != 200) {
//       setState(() {
//         loading = false;
//       });
//       return;
//     }
//     setState(() {
//       MySharedPreferences.localStorage
//           ?.setString("fullName", parse["details"]["username"]);

//       MySharedPreferences.localStorage?.setString("mobile", parse["mobile"]);
//       MySharedPreferences.localStorage
//           ?.setString("service", parse["details"]["service"]);

//       MySharedPreferences.localStorage
//           ?.setInt("customer_id", parse["details"]["id"]);

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
//   }



}

