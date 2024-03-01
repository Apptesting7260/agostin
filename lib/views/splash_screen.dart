import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
import 'package:ibc_telecom/views/user/option_screen.dart';
import 'package:ibc_telecom/shared_pref/preference.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    isLogin = MySharedPreferences.localStorage?.getBool(MySharedPreferences.isLogin) ?? false;
    Timer(Duration(seconds:3), () =>  checklogin());
  }

  checklogin(){
    setState(() {
      if(isLogin==true){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => TabScreen(index: 0)));
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>  OptionScreen()));
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/image/Splash.jpg"),
      ),
    );
  }
}
