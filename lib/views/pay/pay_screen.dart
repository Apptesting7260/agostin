import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ibc_telecom/Webview/Webview.dart';
import 'package:provider/provider.dart';
import '../../provider/home_provider.dart';
import '../../shared_pref/preference.dart';
import '../../stripe/stripe_Payment.dart';
import '../../widget/my_button.dart';
import 'package:http/http.dart' as http;
 String ?url;
class PayScreen extends StatefulWidget {
  final bool? isShowable;

  const PayScreen({Key? key, this.isShowable = false}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  trim(date) {
    final newdate = DateTime.parse(date ?? "");
    final trimDate = newdate.toString().split(" ").first;
    return trimDate;
  }

  @override
  void initState() {
    // amountController.text =
    Future.delayed(Duration(microseconds: 200)).then((value) => c());
    super.initState();
  }

  c() {
    amountController.text = controllerValue ?? "";
  }

  TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // bool _autoValidate = false;
  int monthValidity = 0;
  String data = "";
  List month = ["1 Muaj", "3 Muaj", "6 Muaj", "12 Muaj"];
  String selectedValue = "1 Muaj";

  amountValue(value) {
    if (selectedValue == "1 Muaj") {
      amountController.text = (value * 1).toString();
    } else if (selectedValue == "3 Muaj") {
      amountController.text = (value * 3).toString();
    } else if (selectedValue == "6 Muaj") {
      amountController.text = (value * 6).toString();
    } else {
      amountController.text = (value * 12).toString();
    }
  }

  validity(value) {
    if (selectedValue == "1 Muaj") {
      monthValidity = 1;
      data = (int.parse(value.toString().split("g").first) * monthValidity)
          .toString();
    } else if (selectedValue == "3 Muaj") {
      monthValidity = 3;
      data = (int.parse(value.toString().split("g").first) * monthValidity)
          .toString();
    } else if (selectedValue == "6 Muaj") {
      monthValidity = 6;
      data = (int.parse(value.toString().split("g").first) * monthValidity)
          .toString();
    } else {
      monthValidity = 12;
      data = (int.parse(value.toString().split("g").first) * monthValidity)
          .toString();
    }
    return data;
  }

  int user_id = MySharedPreferences.localStorage
          ?.getInt(MySharedPreferences.customerId) ??
      0;

  String? controllerValue = "";
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: widget.isShowable == true ? AppBar() : null,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Consumer<HomeProvider>(
            builder: (context, value, child) {
              controllerValue = value.item?.myPlan?.amount.toString();
              return Visibility(
                visible: !value.isLoading,
                replacement: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                child: Visibility(
                  visible: value.item != null,
                  replacement: Center(
                    child: Text(
                      "Informacioni i pagesës nuk disponohet",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if( DateTime.parse(value.item!.myPlan!.createdAt!).add(Duration(days: 25,)).isBefore(DateTime.now()))
                      Card(
                        elevation: 8,
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage("assets/image/bg.PNG"),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Riabonohu",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color:
                                              Theme.of(context).highlightColor),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "L ${value.item?.myPlan?.amount}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.black),
                                ),
                                const SizedBox(height: 5),
                                const Spacer(),
                                if (value.item?.myPlan?.expiration != null)
                                  Text(
                                    "Mbarimit: ${trim(value.item?.myPlan?.expiration)} ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color:
                                                Theme.of(context).errorColor),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height * .1,
                      ),
                      Text(
                        "Muaj",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      DropdownButtonFormField<String>(
                        itemHeight: 50,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 15),
                          enabled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).highlightColor),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).highlightColor),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).highlightColor),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                        ),
                        iconSize: 22,
                        borderRadius: BorderRadius.circular(10),
                        alignment: Alignment.center,
                        dropdownColor: Colors.white,
                        // hint: const Text("1 Muaj"),
                        value: selectedValue,
                        isDense: true,
                        items: month.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedValue = val ?? "1 Muaj";
                            print(selectedValue);

                            amountValue(value.item?.myPlan?.amount);
                          });
                        },
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Text(
                        "Shuma",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Ju lutem zgjidhni Muaj te auto Shuma";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: amountController,
                          decoration: InputDecoration(
                            // hintText:  value.item?.myPlan?.amount.toString() ?? "",
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 15),
                            enabled: false,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height * .1,
                      ),
                      // if (DateTime.parse(value.item?.myPlan?.expiration ?? "")
                      //     .subtract(const Duration(
                      //       days: 15,
                      //     ))
                      //     .isBefore(DateTime.now()))
                      //   if (value.item?.myPlan?.expiration != null)
                      //     if (DateTime.parse(
                      //             value.item?.myPlan?.expiration ?? "")
                      //         .subtract(const Duration(
                      //           days: 5,
                      //         ))
                      //         .isBefore(DateTime.now()))
                      Center(
                        child: MyButton(
                            title: "Paguaj tani",
                            width: MediaQuery.of(context).size.width * .7,
                            height: 50,
                            onTap: () {
                          
                              //                                Navigator.of(context).push(
                              // MaterialPageRoute(
                              //   builder: (BuildContext context) =>    UsePaypal(
                              //       sandboxMode: true,
                              //       clientId:
                              //           "ATfJmt26VhHKN6NX_0BDxHxNz60sEbrMAjpziRYOkzSIsv6BLBN2r152PxXD67LTFKwirg9ezcCgAPbZ",
                              //       secretKey:
                              //           "EBPOIoQazFBOEvbjSTNxLqS5xXhG4BaqWZMUA2huBcahcx00FUyeYBJgN0npMftQXRKZrkSQCV1g5WuV",
                              //       returnURL: "https://samplesite.com/return",
                              //       cancelURL: "https://samplesite.com/cancel",
                              //       transactions: const [
                              //         {
                              //           "amount": {
                              //             "total": '10.12',
                              //             "currency": "USD",
                              //             "details": {
                              //               "subtotal": '10.12',
                              //               "shipping": '0',
                              //               "shipping_discount": 0
                              //             }
                              //           },
                              //           "description":
                              //               "The payment transaction description.",
                              //           // "payment_options": {
                              //           //   "allowed_payment_method":
                              //           //       "INSTANT_FUNDING_SOURCE"
                              //           // },
                              //           // "item_list": {
                              //           //   // "items": [
                              //           //   //   {
                              //           //   //     "name": "A demo product",
                              //           //   //     "quantity": 1,
                              //           //   //     "price": '10.12',
                              //           //   //     "currency": "USD"
                              //           //   //   }
                              //           //   // ],

                              //           //   // shipping address is not required though
                              //           //   // "shipping_address": {
                              //           //   //   "recipient_name": "Jane Foster",
                              //           //   //   "line1": "Travis County",
                              //           //   //   "line2": "",
                              //           //   //   "city": "Austin",
                              //           //   //   "country_code": "US",
                              //           //   //   "postal_code": "73301",
                              //           //   //   "phone": "+00000000",
                              //           //   //   "state": "Texas"
                              //           //   // },
                              //           // }
                              //         }
                              //       ],
                              //       note: "Contact us for any questions on your order.",
                              //       onSuccess: (Map params) async {
                              //         print("onSuccess: $params============================");
                              //       },
                              //       onError: (error) {
                              //         print("onError: $error");
                              //       },
                              //       onCancel: (params) {
                              //         print('cancelled: $params');
                              //       })));
                              if (!_formKey.currentState!.validate()) {
                                return;
                              } else {
                                Get.defaultDialog(
                                    barrierDismissible: false,
                                    title: "",
                                    confirm: MyButton(
                                      width: 100,
                                      height: 30,
                                      bgColor: Theme.of(context).highlightColor,
                                      title: "Vazhdo",
                                      onTap: () async {
                                       
 onPay();
                                        // final response = await Get.to(
                                        //     Stripe(
                                        //         rechargeAmount:
                                                    // amountController.text,
                                        //         selectedMonth: selectedValue,
                                        //         selectedItem:
                                        //             value.item!.myPlan!),
                                        //     fullscreenDialog: true);
                                      },
                                    ),
                                    confirmTextColor:
                                        Theme.of(context).highlightColor,
                                    cancel: MyButton(
                                      width: 110,
                                      height: 30,
                                      bgColor: Theme.of(context).errorColor,
                                      title: "Anullo",
                                      onTap: () {
                                        Get.back();
                                      },
                                    ),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 8,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: .5),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 15),
                                            child: Column(
                                              children: [
                                                Text("Paketa",
                                                    // widget.selectedItem.name ?? "",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .025,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Cmimi paketes ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1),
                                                    Text(
                                                        "L ${amountController.text}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("E vlefshme",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1),
                                                    Text(selectedValue,
                                                        // widget.selectedItem.validate.toString() + " days",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Sasia e GB",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1),
                                                    Text(
                                                        "${validity(value.item!.myPlan!.totalData)} Gb",
                                                        // widget.selectedItem.validate.toString() + " days",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Shpejtesio",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1),
                                                    Text(
                                                        value.item!.myPlan!
                                                                .speed ??
                                                            "",
                                                        // widget.selectedItem.validate.toString() + " days",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(10));
                              }
                            }),
                      ),
                      SizedBox(
                        height: height * .05,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

Future<void> onPay() async {
  final String apiUrl = 'http://130.0.25.62/api/user-payment';
  final Map<String, String> headers = {
    'Cookie':
        'XSRF-TOKEN=eyJpdiI6IlhlMjliTTNSamQ0Yk9hWkNqcXlqZFE9PSIsInZhbHVlIjoiSlpsMnp6WWVXQkZCTmZJajMrQm80V0lYajVFWEZoM1V4VDFyYktRT09aQ0R6ZW9ha3FINy9xa1kvT1dyRnhrWWlUQ3RIb3ZLZU1OTGRYUjBLbXdwamdMYTJURTNEZFJQNkljZXYwTzJDZkFQUFoxeWN2aVE0WWVrNnNsWFVuY2IiLCJtYWMiOiI5MTY0M2ZmMTFkMTExN79A'
        // Add your cookie value here
  };

  final Map<String, String> body = {
    'user_id': user_id.toString(),
    "month":getNumericPart(selectedValue.toString()),
    'amount':   
     amountController.text,

    // '10'
  };
print("${body}==paument body");
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: headers,
    body: body,
    encoding: Encoding.getByName('utf-8'), // Add this line to specify the encoding
  );

  if (response.statusCode == 200) {
    var respo=jsonDecode(response.body);
    String payurl=respo["url"].toString();
    url=payurl;
    print("$payurl======================");
    print(respo);
    setState(() {
      payurl;
    });
Navigator.of(context).push(MaterialPageRoute(builder: (context) => InAppWebViewPage(url: payurl,)));
   
    // print(response.body);
  } else {
    print(response.reasonPhrase);
  }
}

String getNumericPart(String input) {
  RegExp regExp = RegExp(r'\d+');
  Match? match = regExp.firstMatch(input);
  
  if (match != null) {
    return match.group(0)!; // Explicitly cast to Match and use the ! operator to assert non-null
  } else {
    return ''; // Handle the case where no numeric part is found
  }
}

}
