import 'dart:ffi';

import 'package:flutter/material.dart';

import 'order_history_model.dart';

class OrderDetail extends StatefulWidget {

  const OrderDetail({Key? key, }) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
   OrderHistoryModel OrderHistoryModelins=OrderHistoryModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5)),
            child: GestureDetector(
              child: Icon(Icons.arrow_back, color: Colors.white),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: Text( "Historia",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: Column(
        children: [],
      )),
    );
  }
}
