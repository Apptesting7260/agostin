import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/views/order/orders_detail.dart';

import '../../shared_pref/preference.dart';
import '../../utils/urls.dart';
import 'order_history_model.dart';
int? Historyindex;
class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String userId = "";

  @override
  void initState() {
    userId = MySharedPreferences.localStorage
            ?.getInt(MySharedPreferences.customerId)
            .toString() ??
        "";
    getOrderApi();
    super.initState();
  }

  OrderHistoryModel _model = OrderHistoryModel();
  List<Data> orderHistory = [];
  bool isLoading = false;

  getOrderApi() async {
    setState(() {
      isLoading = true;
    });

    print("object");
    // final response =  await get(Uri.parse('https://urlsdemo.xyz/ibc-telecom/api/get-history'));
    final response = await get(Uri.parse(
        "https://api-payment.ibc.al/api/payment-history/user-id/$userId"));

    print(response.toString());

    final parse = jsonDecode(response.body);

    print(parse.toString());

    if (response.statusCode != 200) {
      return;
    }
    setState(() {
      _model = OrderHistoryModel.fromJson(parse);
      orderHistory = _model.data!;
      print(orderHistory.length);

      isLoading = false;
    });
  }

  trim(date) {
    final trimDate = date.toString().split(" ").first;
    return trimDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(5)),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          title: Text(
            "Historia",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Visibility(
          visible: !isLoading,
          replacement: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          child: Visibility(
            visible: orderHistory.isNotEmpty,
            replacement: const Center(
              child: Text(
                "Të dhënat nuk u gjetën",
              ),
            ),
            child: ListView.builder(
              itemCount: orderHistory.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                     
                      SizedBox(height: 5),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                             Historyindex=index;
                            });
                            // Get.to(OrderDetail(
                            // //  history:hoistory
                            // ));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .2,
                              width: MediaQuery.of(context).size.width * .94,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                         Text(
                        trim(orderHistory[index].createdAt) ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                                        SizedBox(height: 15),
                                        RichText(
                                            text: TextSpan(
                                                text: "I rimbushur",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Colors.black),
                                                children: [
                                              TextSpan(
                                                  text:
                                                      " ${orderHistory[index].amount}Leke",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: Colors.red))
                                            ])),
                                        Text(
                                            "ID-ja e porosisë : ${orderHistory[index].id}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color:
                                                        Colors.blue.shade900)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                  /*    SizedBox(
                                    width: MediaQuery.of(context).size.width * .28,
                                    height: MediaQuery.of(context).size.height * .04,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: Size(60, 35),
                                            maximumSize: Size(
                                                MediaQuery.of(context).size.width * .6,
                                                35)),
                                        onPressed: () {},
                                        child: Text(
                                          "REPEAT",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(color: Colors.white),
                                        )),
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
