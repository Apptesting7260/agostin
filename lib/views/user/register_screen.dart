import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
import 'package:ibc_telecom/utils/snack_bar.dart';
import 'package:ibc_telecom/views/user/VerifyOtpsignup.dart';
import 'package:ibc_telecom/views/user/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:ibc_telecom/shared_pref/preference.dart';

import '../../utils/urls.dart';
import 'OtpVerification.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  bool? isChecked = true;
  bool isValid = true;
  bool callApi = false;
  bool loading = false;
  String _selectedCountryCode = "355";
  Country countrys= Country(geographic: true, phoneCode: "355", countryCode: 'AL', e164Sc: 1, level: 1, name: 'Albania', example: '', displayName: '', displayNameNoCountryCode: '', e164Key: '');


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * .01),
                    Center(
                      child: Text("Create a new account!",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.black)),
                    ),
                    SizedBox(height: height * .005),
                    Center(
                      child: Text("lorem ipsum is simply dummy text",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.blue.shade900)),
                    ),
                    Image.asset(
                      "assets/image/ibclogo.png",
                    ),
                    Text("Customer Id",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black)),
                    SizedBox(
                      height: 7,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your Customer Id";
                              } else {
                                return null;
                              }
                            },
                            controller: idcontroller,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontSize: 14, backgroundColor: Colors.white60),
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Enter your customer id",
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: height * .02),
                         /* Text("Name",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.black)),
                          SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter your name";
                              } else {
                                return null;
                              }
                            },
                            controller: namecontroller,
                            decoration: InputDecoration(
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontSize: 14, backgroundColor: Colors.white60),
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Enter your name",
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: height * .02),*/
                          Text("Numri I telefonit",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.black)),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            width: double.infinity,
                            margin:
                            const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 3.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            // color: Colors.white,
                            child: TextFormField(
                              controller: mobilecontroller,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10.0),
                                border:
                                const OutlineInputBorder(borderSide: BorderSide.none),
                                fillColor: Colors.white,
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,

                                      countryListTheme: const CountryListThemeData(
                                        textStyle:
                                        TextStyle(fontSize: 16, color: Colors.blueGrey),
                                        //Optional. Sets the border radius for the bottomsheet.
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                        inputDecoration: InputDecoration(
                                          labelText: 'Search',
                                          hintText: 'Start typing to search',
                                          hintStyle: TextStyle(color: Colors.black),
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      onSelect: (Country country) {
                                        print('Select country: ${country.phoneCode}');
                                        setState(() {
                                          _selectedCountryCode = country.phoneCode;
                                          // _selectedCountryFlag = country.flagEmoji;
                                          countrys = country;
                                          print("_selectedCountryCode ==$_selectedCountryCode");
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
                                        right: 10.0, bottom: 3.0, top: 3.0, left: 3.0),
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      children: [
                                        // CountryPickerUtils.getDefaultFlagImage(country),
                                        Text("${countrys.flagEmoji} + ${countrys.phoneCode}",style: const TextStyle(
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
                                hintText: 'Enter Numri I telefonit',
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .07),
                    Center(
                      child: Visibility(
                        visible: loading == false,
                        replacement:
                            Center(child: CircularProgressIndicator.adaptive()),
                        child: ElevatedButton(
                            onPressed: () {
                              checkvalidate();
                            },
                            child: Text(
                              "Dergoje",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white),
                            )),
                      ),
                    ),
                    SizedBox(height: height * .17),
                    Center(
                      child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text(
                          "Already have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black,fontSize: 12)),
                              SizedBox(
                                width: Get.width * .02,
                              ),
                           GestureDetector(
                             onTap: () {
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) =>
                                     const LoginScreen(),
                                   ));
                             },
                             child: Container(
                               decoration: ShapeDecoration(

                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(15),
                                   side: BorderSide(width: 0.5,color: Colors.red)
                                 ),),
                               child:    Padding(
                                 padding: const EdgeInsets.only(left: 5,right: 7),
                                 child: Text(


                                   // Single tapped.

                                     "Hyr",
                                     style: TextStyle(
                                         fontSize: 15,
                                         fontWeight: FontWeight.w700,
                                         color: Colors.red)),
                               ),
                             ),
                           )
                            ]),
                      ),

                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: "By Continuing. I agree to the",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black,fontSize: 12),
                            children: [
                              TextSpan(
                                  text: " Terms and conditions",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.red,fontSize: 12)),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool? checkvalidate() {
    print("send");
    if (!_formKey.currentState!.validate()) {
      print("not Valid");
      return isValid = true;
    }
    if (callApi == false) {
      setState(() {
        loading = true;
      });
      callApi = true;
      // print("valid");
      create().then((value) => callApi = false);
      print(callApi);
    }
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
  create() async {
    final body = {
      "id": idcontroller.text,
      "mob_no":mobilecontroller.text,
    };
    print("abc");
    try {
      final response = await post(
        Uri.parse(baseURL+"create"),
        body: body,
      );
      print("abc2");
      print("hgugu${response.body}");
      final parse = jsonDecode(response.body);
      print("abc3");

      print(parse);
      print("rerrtg ${parse["status"]}");

      // print("parse====$parse");
      if (parse["status"] != "Success") {
        idcontroller.clear();
        namecontroller.clear();
        mobilecontroller.clear();
        setState(() {
          loading = false;
        });
        return showSnackBar(title: "Response", description: parse["message"]);
      }
      setState(() {
        if (parse["status"] == "Success") {
          
          Get.to(PinFieldssignup(
            username: namecontroller.text,
            id: idcontroller.text,
            mobile: mobilecontroller.text,
            countryCode: _selectedCountryCode,
            nav: "register",
          ));
          // register();
        }
      });
    } on Exception catch (e) {
      // TODO
      print("error ${e}");
    }finally{
      setState(() {
        loading = false;
      });
    }
  }


  


}
