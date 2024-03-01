import 'dart:convert';

import 'package:http/http.dart';
import 'package:ibc_telecom/shared_pref/preference.dart';
import 'package:ibc_telecom/utils/urls.dart';

import '../home/home_model.dart';
import '../views/home/multi_user_model.dart';

class ApiService {
  HomeModel _homeModel = HomeModel();
  MyPlan? myPlan;
  Services? services;
  int user_id = 0;

  List<dynamic> banner = [];



  Future homeApi() async {
    print("call home Api");
    user_id = MySharedPreferences.localStorage
            ?.getInt(MySharedPreferences.customerId) ??
        0;
    print("user_id==$user_id");
    final response = await get(Uri.parse("$homeURL${user_id.toString()}"));
    print("$homeURL+${user_id.toString()}");
    print("response==$response");
    final parse = jsonDecode(response.body);
    print(parse);
    print("parse");
    if (response.statusCode != 200) {
      return;
    }
    _homeModel = HomeModel.fromJson(parse);
    myPlan = _homeModel.myPlan;

    // myPlan =parse["my_plan"];
    print(myPlan?.amount);

    return _homeModel;
  }



  Future getBanner() async {
    final response = await get(Uri.parse(baseURL + "get-images"));
    final parse = jsonDecode(response.body);

    if (response.statusCode != 200) {
      return;
    }
    banner = parse["Slider_images"];
    print(banner.length);
    return banner;
  }
}
