import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibc_telecom/views/store/store_screen.dart';

class CommonFunction {
  //Set Loader SignUp & Sign In
  static onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CupertinoActivityIndicator(),
                SizedBox(width: 20),
                Text("Please Wait"),
              ],
            ),
          ),
        );
      },
    );
  }

/*  static toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }*/

  static hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  //TODO: Check Internet Connection Data
  /*static Future<bool> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    else {
      Fluttertoast.showToast(
        msg: "No Internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    }
  }*/

  static onLogout(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CupertinoActivityIndicator(),
                SizedBox(width: 20),
                Text("Please Wait"),
              ],
            ),
          ),
        );
      },
    );
  }

  static onPlanClick(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("You want get a Plan!"),
          content: const Text("Please Contact to nearest Store!"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Get.back();
                Get.to(const StoreListScreen(
                  index: true,
                ));
              },
            ),
          ],
        );
      },
    );
  }
}
