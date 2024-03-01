import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static const fullName="fullName";
  // static const userId="user_id";
  static const customerId = 'customer_id';
  static const mobile = 'mobile';
  static const isLogin = 'login';
  static const service = 'service';
  static const deviceId = "device_id";


  //Todo:--------
  static SharedPreferences? localStorage;
  static Future init() async => localStorage = await SharedPreferences.getInstance();

}




