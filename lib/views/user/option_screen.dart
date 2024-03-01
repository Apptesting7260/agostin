import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
import 'package:ibc_telecom/views/user/login_screen.dart';
import 'package:ibc_telecom/views/user/register_screen.dart';
import 'package:ibc_telecom/widget/my_button.dart';


class OptionScreen extends StatefulWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              // SizedBox(height: height * .01),
              Center(
                child: Text(
                  "Mirësevini",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.black, fontSize: 30),
                ),
              ),

              SizedBox(
                height: height * .006,
              ),
              Center(
                child: Text(
                  "Blej . Abonohu . Paguaj . Shijoje ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.blue.shade900),
                ),
              ),
              SizedBox(height: height * .18),
              Image.asset(
                "assets/image/ibclogo.png",
              ),
                  SizedBox(height: height * .01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    width: 150,
                    height: 45,
                    title: "Hyr",
                    style: Theme.of(context).textTheme.bodyMedium,
                    onTap: () {

                      Get.to(LoginScreen());

                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width* .03,),
                  MyButton(
                    bgColor: Theme.of(context).highlightColor,
                    width: 150,
                    height: 45,
                    title: "Rregjistrohu",
                    style: Theme.of(context).textTheme.bodyMedium,
                    onTap: () {

                      Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ));

                    },
                  ),
                ],
              ),
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


            ]),
          ),
        ),
      ),
    );
  }

}
