

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class Apis{
  var context;
  Apis(BuildContext context){
    this.context;
  }

  callProviderApi() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeProvider>(context, listen: false).getHomeData();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<BannerProvider>(context , listen: false).getBannerData();
    });


  }
}