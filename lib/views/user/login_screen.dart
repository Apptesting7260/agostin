import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
import 'package:ibc_telecom/shared_pref/preference.dart';
import 'package:ibc_telecom/views/home/home_screen.dart';
import 'package:ibc_telecom/views/user/Verifyotpscreen.dart';
import 'package:ibc_telecom/views/user/register_screen.dart';
import 'package:ibc_telecom/utils/device_size.dart';
import 'package:ibc_telecom/utils/snack_bar.dart';
import 'package:ibc_telecom/widget/my_button.dart';
import 'package:intl/intl.dart';

import '../../http_service/http_service.dart';
import '../../utils/urls.dart';
import 'OtpVerification.dart';
import 'package:http/http.dart'as http;

  String fcmToken = "";
String ?costomerid;
String ?mobilenumber;
String ?mobilecode;
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  bool isloading=false;
  String _selectedCountryCode = "355";
  Country countrys = Country(
      geographic: true,
      phoneCode: "355",
      countryCode: 'AL',
      e164Sc: 1,
      level: 1,
      name: 'Albania',
      example: '',
      displayName: '',
      displayNameNoCountryCode: '',
      e164Key: '');

// String deviceId = "";
  @override
  void initState() {
    getFcmToken();
    // TODO: implement initState
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: height * .01),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                                onTap: () {
                                  Get.to(TabScreen(index: 0));
                                },
                                child: Icon(Icons.arrow_back_ios_new))),
                        Expanded(
                          flex: 15,
                          child: Center(
                            child: Text(
                              "Mirësevini!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox())
                      ],
                    ),
                    SizedBox(
                      height: height * .002,
                    ),
                    Center(
                      child: Text(
                        "Buy . Recharge . Pay . Enjoy ",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.blue.shade900),
                      ),
                    ),
                    SizedBox(height: height * .015),
                    Image.asset(
                      "assets/image/ibclogo.png",
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Text("Id Juaj ",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black)),
                    const SizedBox(
                      height: 2,
                    ),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                top: 10.0, bottom: 10.0, right: 3.0),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            // color: Colors.white,
                            child: TextFormField(
                              controller: userIdController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                fillColor: Colors.white,
                                hintText: 'Vendosni Id Juaj ',
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Text("Numri I telefonit",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.black)),
                          const SizedBox(
                            height: 2,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                top: 10.0, bottom: 10.0, right: 3.0),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            // color: Colors.white,
                            child: TextFormField(
                              controller: mobilenumbercontroller,
                              keyboardType: TextInputType.phone,
                              // inputFormatters: [
                              //   if (denySpaces)
                              //     FilteringTextInputFormatter.deny(
                              //         RegExp(r'\s')),
                              // ],
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10.0),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                fillColor: Colors.white,
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      countryListTheme:
                                          const CountryListThemeData(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blueGrey),
                                        //Optional. Sets the border radius for the bottomsheet.
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        inputDecoration: InputDecoration(
                                          labelText: 'Search',
                                          hintText: 'Start typing to search',
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      onSelect: (Country country) {
                                        // print('Select country: ${country.phoneCode}');
                                        setState(() {
                                          _selectedCountryCode =
                                              country.phoneCode;
                                          // _selectedCountryFlag = country.flagEmoji;

                                          // print(format);
                                          countrys = country;
                                          // Locale locale = Localizations.localeOf(context);
                                          // var format = NumberFormat.simpleCurrency(locale: locale.countryCode, name: country.name);
                                          print("name===${country.name}");

                                          // String country = Locale.getDefault().getCountry();
                                          // String currency = Currency.getInstance(new Locale("", country)).getCurrencyCode();
                                          // String curr  = Currency(code: country.countryCode, name: countrys.displayName, symbol: "", flag: country.flagEmoji, number: country.name, decimalDigits: , namePlural: namePlural, symbolOnLeft: symbolOnLeft, decimalSeparator: decimalSeparator, thousandsSeparator: thousandsSeparator, spaceBetweenAmountAndSymbol: spaceBetweenAmountAndSymbol)

                                          // print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
                                          // print("CURRENCY NAME ${format.currencyName}"); //
                                        });
                                      },
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      right: BorderSide.none,
                                    )),
                                    height: 45.0,
                                    width: 70.0,
                                    margin: const EdgeInsets.only(
                                        right: 10.0,
                                        bottom: 3.0,
                                        top: 3.0,
                                        left: 3.0),
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      children: [
                                        // CountryPickerUtils.getDefaultFlagImage(country),
                                        Text(
                                            "${countrys.flagEmoji} + ${countrys.phoneCode}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal)),
                                        // SizedBox(
                                        //   width: 8.0,
                                        // ),
                                        // Text(
                                        //   "$_selectedCountryFlag +$_selectedCountryCode",
                                        //   textAlign: TextAlign.center,
                                        //   style: const TextStyle(
                                        //       color: Colors.black,
                                        //       fontSize: 15,
                                        //       fontWeight: FontWeight.normal),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                hintText: 'Vendosni Numri I telefonit',
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                 if(isloading==false)   Center(
                      child: MyButton(
                      
                        width: 150,
                        height: 40,
                        title: "Hyr",
                        onTap: () {
                          setState(() {
                            isloading=true;
                         Timer(Duration(seconds: 2), () { 
                          setState(() {
                              isloading=false;
                          });
                           
                         });
                          });
                          print("abc");
                          DeviceUtils.hideKeyboard(context);
                          if (mobilenumbercontroller.text.length < 6) {
                            showError(
                                title: "Phone validation",
                                description: "Please Vendosni Valid Number");
                            return;
                          }
                          // print(
                          //     "navigate on otp with \nphone = ${mobilenumbercontroller.text}\ncountry= ${_selectedCountryCode}");
                          setState(() {
      isloading=false;
                            loginApi();
                  
                          });


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
                    // Center(
                    //   child: ElevatedButton(
                    //       onPressed: () {
                    //         Get.to(OtpVerify(
                    //           mobile: mobilenumbercontroller.text,
                    //           countryCode: _selectedCountryCode,
                    //           nav: "login",
                    //         ));
                    //       },
                    //       child: Text(
                    //         "VERIFY",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .headline6!
                    //             .copyWith(color: Colors.white),
                    //       )),
                    // ),
                    SizedBox(
                      height: height * .19,
                    ),
                    Center(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Text("Nuk jeni të rregjistruar?",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black)),
                            SizedBox(
                              width: Get.width * .02,
                            ),
                        GestureDetector(
                          onTap: () {
                            Get.to(TabScreen(index: 0));
                            
                          },
                          child: Container(
                            decoration: ShapeDecoration(

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(width: 0.5,color: Colors.red,style: BorderStyle.solid)
                              ),),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5,right: 7),
                              child: Text(" Përdorues I thjeshtë",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red)),
                            ),
                          ),
                        )
                      ]),
                    ),

                    const SizedBox(height: 5),
                    Center(
                      child: RichText(
                        text: const TextSpan(
                            text: "Duke vazhduar. Unë pajtohem me",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " Termat dhe Kushtet",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red))
                            ]),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }


  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final _formKey = GlobalKey<FormState>();

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
  loginApi() async {
    print("started");
    setState(() {
      isloading=true;
    });
    final body = {
      "cust_id": userIdController.text,
      "mob_no": mobilenumbercontroller.text,
      "country_code": _selectedCountryCode,
      "device_id": fcmToken
    };
    print(body);
    final response = await http.post(Uri.parse(loginURL),body:body);

    // print("loginResponse== ${response.toString()}");
    print( jsonDecode(response.body));
   final parse = jsonDecode(response.body);
  //  print(parse);
    if (response.statusCode != 200) {
      showToast(parse['message']);
          setState(() {
      isloading=false;
    });
      return;
    }else{
   
    print("parse==$parse");

    if (parse["status"] != "Success") {
      return Get.dialog(AlertDialog(
        title: const Text('This term it should not be visible '),
        content:
            const Text("Nuk mund te procedoni pa u rregjistruar fillimisht"),
        actions: [
          TextButton(
            child: const Text("Mbyll"),
            onPressed: () => Get.to(RegisterScreen()),
          ),
        ],
      ));
    }
 showToast(parse['message']);
  setState((){
    costomerid=userIdController.text;
    mobilenumber=mobilenumbercontroller.text;
    mobilecode=_selectedCountryCode;

  });
Get.to(PinFieldssignin(mobilenumbercontroller.text));
          setState(() {
      isloading=true;
    });
    }

    // setState(() {
    //   final userId = userIdController.text.replaceAll(" ", "");
    //   final phone = mobilenumbercontroller.text.replaceAll(" ", "");

    //   Get.to(OtpVerify(
    //     id: userId,
    //     mobile: phone,
    //     countryCode: _selectedCountryCode,
    //     nav: "login",
    //   ));

    //   // Navigator.pushReplacement(
    //   //     context,
    //   //     MaterialPageRoute(
    //   //       builder: (context) => TabScreen(index: 0),
    //   //     ));
    // });
  }



}
