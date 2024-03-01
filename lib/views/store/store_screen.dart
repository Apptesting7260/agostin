import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/views/store/store_model.dart';
import 'package:ibc_telecom/widget/all_list_widget.dart';
import 'package:ibc_telecom/widget/cache_network_image.dart';

class StoreListScreen extends StatefulWidget {
  final bool? index;

  const StoreListScreen({Key? key, this.index}) : super(key: key);

  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  // List<AllStores> storesList = [];
  bool loading = false;



  @override
  void initState() {
    // apiGetStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.index == true
          ? AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              title: Text(
                "Dyqanet",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.black),
              ),
              centerTitle: true,
            )
          : null,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dyqanet",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Theme.of(context).errorColor),
            ),
            Text(
              "Ju prezantojmë rrjetin e dyqaneve tona",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Visibility(
                visible: !loading,
                replacement: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                child: Visibility(
                  visible: AllList.storesList.isNotEmpty,
                  replacement: Center(
                    child: Text(
                      "Dyqanet Not Available",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: AllList.storesList.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: MyCacheNetworkImages(
                                  imageUrl: AllList.storesList[index].image ?? "",
                                  radius: 10,
                                  height: 140,
                                  width: 170,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AllList.storesList[index].title ?? "",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.phone_in_talk_rounded,
                                            size: 25,
                                            color: Theme.of(context).errorColor,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            AllList.storesList[index].contactNo ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.location_on,
                                            size: 25,
                                            color: Theme.of(context).errorColor,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            AllList.storesList[index].address ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
