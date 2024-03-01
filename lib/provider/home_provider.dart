
import 'package:flutter/material.dart';
import 'package:ibc_telecom/views/home/multi_user_model.dart';

import '../home/home_model.dart';
import '../widget/all_list_widget.dart';
import 'api_services.dart';
 bool ?isBeforeFiveDaysBeforeExpiration;
class HomeProvider with ChangeNotifier{
  final  _allData = ApiService();
  bool isLoading = false;
  HomeModel? item;
  MultiUserModel? multiAccount;
  PrimaryAccount ? primaryAccount;
  String date ="";


  ApiService get getAllCate {
    return _allData;
  }
  Future<void> getHomeData() async {
    isLoading = true;
    notifyListeners();
    final response = await _allData.homeApi();
    item = response;
    print("==============date${item!.myPlan!.expiration.toString()}");
checkDate(item!.myPlan!.expiration.toString());

    print("item===$item");


    isLoading = false;
    notifyListeners();
  }

}


// Get the expiration date from value.item.myPlan, defaulting to an empty string if null
bool checkDate(String date) {
  // Parse the expiration date string into a DateTime object or default to the current date if parsing fails
  DateTime expirationDate = DateTime.tryParse(date) ?? DateTime.now();

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Calculate the date 5 days from now
  // DateTime fiveDaysFromNow = currentDate.add(const Duration(days: 0));

  // Check if the expiration date is equal to the current date, after the current date, or within the next 5 days
   isBeforeFiveDaysBeforeExpiration = expirationDate.isAtSameMomentAs(currentDate) || expirationDate.isBefore(currentDate);

  return isBeforeFiveDaysBeforeExpiration!;
}

class BannerProvider with ChangeNotifier{
  final  _allData = ApiService();
  bool isLoading = false;

  List<dynamic> banner = [];



  ApiService get getAllCate {
    return _allData;
  }

  Future<void> getBannerData() async {
    isLoading = true;
    notifyListeners();

    final response = await _allData.getBanner();


    banner = response;


    isLoading = false;
    notifyListeners();
  }

}