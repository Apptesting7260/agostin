// import 'dart:convert';

// import 'package:currency_picker/currency_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
// import 'package:ibc_telecom/http_service/http_service.dart';
// import 'package:ibc_telecom/shared_pref/preference.dart';
// import 'package:ibc_telecom/stripe/payment_model.dart';
// import 'package:ibc_telecom/utils/snack_bar.dart';
// import 'package:ibc_telecom/utils/urls.dart';
// import 'package:ibc_telecom/widget/cache_network_image.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/number_symbols_data.dart';
// import '../home/home_model.dart';
// import '../widget/my_button.dart';
// import 'stripe_service.dart';

// class Stripe extends StatefulWidget {
//   final MyPlan selectedItem;
//   final String rechargeAmount;
//   final String selectedMonth;

//   const Stripe({
//     Key? key,
//     required this.selectedItem,
//     required this.rechargeAmount,
//     required this.selectedMonth,
//   }) : super(key: key);

//   @override
//   _StripeState createState() => _StripeState();
// }

// class _StripeState extends State<Stripe> {
//   final stripeSecretKey =
//       "sk_test_51HfICsEFwfZ1T0dytRNcZc5T1MY4sLn4xfgpAkt480ZwA7LFRL7hNQ7UNbG8DF36WkzQuaO0KKH3ziekdnI1xL4300LNgiqRja"; //self account

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   bool loading = true;
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   OutlineInputBorder? border;
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   String cardType = "";
//   Pay paymentModel = Pay();
//   var key;

//   String userId = "";
//   String notificationToken = "";
//   @override
//   void initState() {
//     userId = MySharedPreferences.localStorage
//             ?.getInt(MySharedPreferences.customerId)
//             .toString() ??
//         "";
//     notificationToken = MySharedPreferences.localStorage
//             ?.getString(MySharedPreferences.deviceId) ??
//         "";
//     print(notificationToken);
//     super.initState();
//     print(userId);
//     print(widget.selectedMonth);
//     List<String> x = widget.selectedMonth.split(" ");
//     print(x[0]);
//   }

//   Future<void> showPaymentSuccessDialog(
//       BuildContext context, PaymentData data) {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap OK button
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20), // Round corner dialog.
//           ),
//           title: Text(
//             'Payment Success',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 24,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min, // Dialog content width.
//             children: <Widget>[
//               Icon(
//                 Icons.check_circle_outline,
//                 size: 100,
//                 color: Theme.of(context).highlightColor,
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Text(
//                 'Thank you for your payment',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text(
//                 'OK',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.green,
//                 ),
//               ),
//               onPressed: () {
//                 Get.off(
//                     transition: Transition.cupertino,
//                     ThankYouScreen(data: data));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   paymentFunc(String cdNum, String expMonth, String expYear, String cvv,
//       String amt) async {
//     List<String> x = widget.selectedMonth.split(" ");
//     print(x[0]);
//     var body = {
//       'card_number': cdNum,
//       'exp_month': expMonth,
//       'exp_year': expYear,
//       'cvv': cvv,
//       'amount': amt,
//       'user_id': userId.toString(),
//       'month': x[0].removeAllWhitespace,
//     };
//     final url = 'http://130.0.25.62/api/payment';
//     final response = await http.post(Uri.parse(url), body: body);
//     print(response.body);

//     if (response.statusCode == 200) {
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       final snackBar = SnackBar(
//         content: Text('Success'),
//         backgroundColor: Colors.green,
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       setState(() {
//         payProcess = false;
//       });
//       var bodyRes = response.body;
//       String x = bodyRes.toString();
//       List<String> parts = x.split('}{');
//       String x1 = parts[0];
//       String x2 = parts[1];
//       Map<String, dynamic> map1 = jsonDecode(x1 + '}');
//       Map<String, dynamic> map2 = jsonDecode('{' + x2);

//       List<Map<String, dynamic>> responseList = [map1, map2];

//       showPaymentSuccessDialog(
//         context,
//         PaymentData(
//           id: responseList[1]['transaction_id'],
//           createTime: DateTime.now().toString(),
//         ),
//       );

//       // print(x1);
//       // print("object");
//       // print(x2);
//       // print(x);
//       // print(bodyRes);
//       // print(bodyRes[0]['type']);
//       // print(bodyRes[1]['transaction_id']);
//       // Get.back();
//       //  setState(() {
//       //   final tranData = PaymentModel.fromJson(response.body);
//       //   data = tranData.data;
//       //   transactions = data?.transactions ?? [];
//       //   print("notification key==${tranData.notification}");
//       //   // apiNotification();

//       // });
//     } else {
//       print("error");
//       final snackBar = SnackBar(
//         content: Text('Failed'),
//         backgroundColor: Colors.red,
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       setState(() {
//         payProcess = false;
//       });
//       Get.back();
//     }
//   }

//   String? selectedCurrency;
//   TextEditingController currencyController = TextEditingController();
//   bool payProcess = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//           leading: GestureDetector(
//               onTap: () {
//                 Get.back(result: false);
//               },
//               child: Icon(Icons.close)),
//           title: const Text("Paguaj"),
//           titleTextStyle: Theme.of(context).textTheme.headlineMedium),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Column(
//               children: <Widget>[
//                 CreditCardWidget(
//                   cardNumber: cardNumber,
//                   expiryDate: expiryDate,
//                   cardHolderName: cardHolderName,
//                   cvvCode: cvvCode,
//                   showBackView: isCvvFocused,
//                   // cardType: cardType,
//                   obscureCardNumber: true,
//                   obscureCardCvv: true,
//                   isHolderNameVisible: false,
//                   cardBgColor: Color(0xff2a319c),
//                   isSwipeGestureEnabled: true,
//                   onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {
//                     cardType =
//                         creditCardBrand.brandName!.toString().split(".").last;

//                     print(cardType);
//                   },

//                   customCardTypeIcons: [
//                     /*  CustomCardTypeIcon(
//                       cardType: CardType.mastercard,
//                       cardImage: Image.asset(
//                         'assets/mastercard.png',
//                         height: 48,
//                         width: 48,
//                       ),
//                     ),*/
//                   ],
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         CreditCardForm(
//                           formKey: formKey,
//                           obscureCvv: true,
//                           obscureNumber: true,
//                           cardNumber: cardNumber,
//                           cvvCode: cvvCode,
//                           isHolderNameVisible: true,
//                           isCardNumberVisible: true,
//                           isExpiryDateVisible: true,
//                           cardHolderName: cardHolderName,
//                           expiryDate: expiryDate,
//                           themeColor: Colors.blue,
//                           textColor: Colors.black,
//                           cardNumberDecoration: InputDecoration(
//                             labelText: 'Numri I Kartës',
//                             hintText: 'XXXX XXXX XXXX XXXX',
//                             hintStyle: const TextStyle(color: Colors.black),
//                             labelStyle: const TextStyle(color: Colors.black),
//                             focusedBorder: border,
//                             enabledBorder: border,
//                           ),
//                           expiryDateDecoration: InputDecoration(
//                             hintStyle: const TextStyle(color: Colors.black),
//                             labelStyle: const TextStyle(color: Colors.black),
//                             focusedBorder: border,
//                             enabledBorder: border,
//                             labelText: 'Data e skadences',
//                             hintText: 'XX/XX',
//                           ),
//                           cvvCodeDecoration: InputDecoration(
//                             hintStyle: const TextStyle(color: Colors.black),
//                             labelStyle: const TextStyle(color: Colors.black),
//                             focusedBorder: border,
//                             enabledBorder: border,
//                             labelText: 'CVV',
//                             hintText: 'XXX',
//                           ),
//                           cardHolderDecoration: InputDecoration(
//                             hintStyle: const TextStyle(color: Colors.black),
//                             labelStyle: const TextStyle(color: Colors.black),
//                             focusedBorder: border,
//                             enabledBorder: border,
//                             labelText: 'Emri I poseduesit',
//                           ),
//                           onCreditCardModelChange: onCreditCardModelChange,
//                         ),
//                         const SizedBox(height: 20),
//                         DropdownButtonHideUnderline(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     MediaQuery.of(context).size.width * .04),
//                             // child: TextFormField(
//                             //   controller: currencyController,
//                             //   onTap: () {
//                             //     showCurrencyPicker(
//                             //       context: context,
//                             //       showFlag: true,
//                             //       theme: CurrencyPickerThemeData(
//                             //         backgroundColor:
//                             //             Theme.of(context).primaryColor,
//                             //       ),
//                             //       showSearchField: true,
//                             //       showCurrencyName: true,
//                             //       showCurrencyCode: true,
//                             //       onSelect: (Currency currency) {
//                             //         currencyController.text = currency.code;
//                             //         print('Select currency: ${currency.code}');
//                             //       },
//                             //       favorite: ['SEK'],
//                             //     );
//                             //   },
//                             //   decoration: const InputDecoration(
//                             //       hintText: "Monedha",
//                             //       // enabled: false,

//                             //       hintStyle: TextStyle(
//                             //           color: Colors.white,
//                             //           fontWeight: FontWeight.w500),
//                             //       suffixIcon: Icon(Icons.arrow_drop_down)),
//                             // ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child:
//                                 // isPayment == false
//                                 // ? ElevatedButton(
//                                 //     onPressed: () {
//                                 //       // double d = 200.0;

//                                 //       final currencyFormatter =
//                                 //           NumberFormat.currency(
//                                 //               locale: 'IN',
//                                 //               // symbol: "\$",
//                                 //               decimalDigits: 1);
//                                 //       print(currencyFormatter.currencySymbol);

//                                 //       if (!formKey.currentState!.validate()) {
//                                 //         //print('check Details!');
//                                 //         return;
//                                 //       }

//                                 //       if (currencyController.text.isNotEmpty) {
//                                 //         makePayPalPayment();
//                                 //       } else {
//                                 //         showError(
//                                 //             title: "Error",
//                                 //             description:
//                                 //                 "Please select Monedha");
//                                 //       }
//                                 //       // createToken();
//                                 //     },
//                                 //     child: Text('Vazhdo'),
//                                 //   ):
//                                 ElevatedButton(
//                               onPressed: () async {
//                                 setState(() {
//                                   payProcess = true;
//                                 });
//                                 List<String> dateParts = expiryDate.split("/");

//                                 String month = dateParts[0];
//                                 String year = "20" + dateParts[1];

//                                 print(cardNumber.removeAllWhitespace);
//                                 print(cardHolderName);
//                                 print(cvvCode);
//                                 print(expiryDate);
//                                 print(currencyFractionDigits);
//                                 print(widget.rechargeAmount);
//                                 await paymentFunc(
//                                     cardNumber.removeAllWhitespace,
//                                     month,
//                                     year,
//                                     cvvCode,
//                                     widget.rechargeAmount);

//                                 print("*******done******");
//                               },
//                               child: payProcess
//                                   ? CupertinoActivityIndicator()
//                                   : Text('Vazhdo'),
//                             )

//                             // MyButton(
//                             //   title: ,
//                             //   onTap: () {
//                             //     if (!formKey.currentState!.validate()) {
//                             //       //print('check Details!');
//                             //       return;
//                             //     }
//                             //     createToken();
//                             //   },
//                             // ),
//                             ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (isPayment)
//               const Positioned(
//                   child: Center(
//                 child: CircularProgressIndicator.adaptive(),
//               ))
//           ],
//         ),
//       ),
//     );
//   }

//   String? dropDownValue; // Option 2
//   void onCreditCardModelChange(CreditCardModel? creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel!.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }

//   bool isPayment = false;

//   // PaymentData? data;
//   List<Transactions> transactions = [];

//   makePayPalPayment() async {
//     final body = {
//       'card_number': cardNumber.replaceAll(" ", ""),
//       'card_type': cardType,
//       'expiry_month': expiryDate.split("/").first,
//       'expiry_year': "20${expiryDate.split("/").last}",
//       'cvv': cvvCode,
//       'amount': widget.rechargeAmount,
//       'first_name': cardHolderName.split(" ").first,
//       'last_name': cardHolderName.split(" ").last,
//       'currency': currencyController.text,
//       'user_id': userId,
//       'month': widget.selectedMonth.split(" ").first
//     };
//     setState(() {
//       isPayment = true;
//     });
//     print(body);
//     try {
//       // final  response = HttpService.postRequest(url: paymentURL, body: body);
//       final response = await http.post(Uri.parse(paymentURL), body: body);

//       final parse = jsonDecode(response.body);

//       print(parse.toString());

//       if (parse["Status"] != "Success") {
//         print("asdfghj");
//       }
//       setState(() {
//         final tranData = PaymentModel.fromJson(parse);
//         data = tranData.data;
//         transactions = data?.transactions ?? [];
//         print("notification key==${tranData.notification}");
//         // apiNotification();
//         Get.off(ThankYouScreen(
//           data: PaymentData(
//             id: "",
//             createTime: DateTime.now().toString(),
//           ),
//         ));
//       });
//     } on Exception catch (e) {
//       // TODO
//     } finally {
//       // widget.selectedMonth
//     }
//   }

//   PaymentData? data;

//   // apiUpdate() async {
//   //   print("api callin for update");
//   //   var headers = {'accept': '*/*', 'Content-Type': 'application/json'};
//   //   var body = json.encode(
//   //       {"clientId": userId, "months": widget.selectedMonth.split(" ").first});
//   //   print(body);
//   //
//   //   final response = await http.post(
//   //       Uri.parse('http://130.0.25.62:8888/api/payment/v1/invoice/'),
//   //       body: body,
//   //       headers: headers);
//   //
//   //   // final parse = jsonDecode(response.body);
//   //
//   //   print(response.statusCode);
//   //   // print(parse.toString());
//   //
//   //   if (response.statusCode != 201) {
//   //     return;
//   //   } else {
//   //     // apiNotification();
//   //     Get.off(ThankYouScreen(
//   //       data: data!,
//   //     ));
//   //     print(response.reasonPhrase);
//   //     setState(() {
//   //       isPayment = false;
//   //     });
//   //   }
//   // }

//   apiNotification() async {
//     print("call notification api");
//     var headers = {
//       'Authorization':
//           'key=AAAA6ea2g5M:APA91bG9iRsSrF17_7YK0j0CzFMlAAh-mMmDUucDozgYg24McmP-acysQxPmde_PS4k5Hy0_lpsSU3kIt26Zkkz5xpXXmd7MAQRybVAYszmSby93PxVYVoG6JjeteE1Im1GY9hUesOmn',
//       'Content-Type': 'application/json'
//     };
//     print(notificationToken);
//     var request =
//         http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
//     request.body = json.encode({
//       "to": notificationToken,
//       "notification": {
//         "title": "Payment Success",
//         "body": " Successfully Recharged with amount"
//       }
//     });
//     request.headers.addAll(headers);

//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
// }

// class ThankYouScreen extends StatelessWidget {
//   final PaymentData data;

//   const ThankYouScreen({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: GestureDetector(
//             onTap: () {
//               Get.off(TabScreen(index: 0));
//             },
//             child: Icon(Icons.close)),
//         title: const Text(
//           "Transaction Successful",
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             MyCacheNetworkImages(
//               imageUrl:
//                   "https://cdn.dribbble.com/users/1987929/screenshots/4199053/media/b2dbdb5da987b2898edd5998f2af2dd5.jpg?compress=1&resize=800x600&vertical=top",
//               radius: 10,
//               height: MediaQuery.of(context).size.height * .275,
//               width: MediaQuery.of(context).size.width,
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 35.0),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .035,
//                     ),
//                     Text(
//                       "Payment Summary",
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .025,
//                     ),
//                     Divider(
//                       thickness: 2,
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Ref ID :",
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                         Text(
//                           data.id.toString().split("-").last,
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Date :",
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                         Text(
//                           data.createTime.toString().split("T").first,
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Date :",
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                         Text(
//                           data.createTime
//                               .toString()
//                               .split("T")
//                               .last
//                               .replaceAll("Z", ""),
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Method :",
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                         Text(
//                           data.payer?.paymentMethod == "credit_card"
//                               ? "Credit Card"
//                               : "Credit Card",
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Spacer(),
//                     MyButton(
//                       bgColor: Theme.of(context).highlightColor,
//                       title: "Done",
//                       onTap: () {
//                         Get.off(TabScreen(index: 0));
//                       },
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height * .1,
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
