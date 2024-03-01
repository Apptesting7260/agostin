import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/views/pay/plan_list_model.dart';
import 'package:ibc_telecom/widget/my_button.dart';
import 'package:ibc_telecom/widget/show_diolog.dart';

import '../../utils/urls.dart';
import '../../widget/all_list_widget.dart';
import '../store/store_screen.dart';

class AllPlanList extends StatefulWidget {
  const AllPlanList({Key? key}) : super(key: key);

  @override
  State<AllPlanList> createState() => _AllPlanListState();
}

class _AllPlanListState extends State<AllPlanList> {
  var segmentedControlGroupValue = 0;

  List<AllPlans> familyPlan = [];
  List<AllPlans> businessPlan = [];
  bool isLoading = false;

  @override
  void initState() {
    getAllPlan();
    getAllBusinessPlan();
    super.initState();
  }

  getAllPlan() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await get(
        Uri.parse(baseURL+"get-plans"),
      );
      final parse = jsonDecode(response.body);

      print(parse);
      if (response.statusCode != 200) {
        return;
      }
      final allList = PlanListModel.fromJson(parse);

      setState(() {
        AllList.familyPlan = allList.allPlans ?? [];
      });
    } on Exception catch (e) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  getAllBusinessPlan() async {
    final response = await get(
      Uri.parse(baseURL+"get-business-plans"),
    );
    final parse = jsonDecode(response.body);

    print(parse);
    if (response.statusCode != 200) {
      return;
    }
    final allList = PlanListModel.fromJson(parse);

    setState(() {
      AllList.businessPlan = allList.allPlans ?? [];
    });

    print("date====${AllList.familyPlan.length}");
    // return AllList.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).errorColor,
                borderRadius: BorderRadius.circular(5)),
            child: GestureDetector(
              child: const Icon(Icons.arrow_back, color: Colors.white),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: Text(
          "Të gjitha Paketat",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Visibility(
          visible: !isLoading,
          replacement:
              const Center(child: CircularProgressIndicator.adaptive()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25, left: 10, right: 10,bottom: 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.4, color: Colors.grey),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(40),
                        )),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                      child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: Theme.of(context).highlightColor,
                          thumbColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.zero,
                          groupValue: segmentedControlGroupValue,
                          onValueChanged: (value) {
                            setState(() {
                              segmentedControlGroupValue = value ?? 0;
                            });
                          },
                          children: {
                            0: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Plani Familjar",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color: segmentedControlGroupValue == 0
                                            ? Theme.of(context).highlightColor
                                            : Theme.of(context).primaryColor),
                              ),
                            ),
                            1: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Planet e Biznesit",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color: segmentedControlGroupValue == 1
                                            ? Theme.of(context).highlightColor
                                            : Theme.of(context).primaryColor),
                              ),
                            )
                          }),
                    ),
                  ),
                )),
               Expanded (
                 child:
                 segmentedControlGroupValue == 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: AllList.familyPlan.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              height: 120,
                              // width: 415,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // if(AllList.businessPlan[index].mrp != null)
                                            Text(
                                              "EMRI I PLANIT",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              "${AllList.familyPlan[index].planName}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .errorColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            const Spacer(),
                                            if (AllList
                                                    .familyPlan[index].mrp !=
                                                null)
                                              Text(
                                                "${AllList.familyPlan[index].mrp}",
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: Theme.of(
                                                                context)
                                                            .highlightColor,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            const Spacer()
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // if(AllList.familyPlan[index].mrp != null)
                                            Text(
                                              "VLEFSHMËRIA",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            // if(AllList.businessPlan[index].mrp != null)
                                            Text(
                                                "${AllList.familyPlan[index].validity}",
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge)
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // if(AllList.businessPlan[index].mrp != null)
                                            Text(
                                              "TË DHËNAT",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            // if(AllList.businessPlan[index].mrp != null)
                                            Text(
                                                "${AllList.familyPlan[index].totalData}",
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge)
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // if(AllList.businessPlan[index].mrp != null)
                                            Text(
                                              "ABONIM",
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              AllList.familyPlan[index]
                                                      .otherAddon ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),

                                            const Spacer(),
                                            MyButton(
                                              height: 30,
                                              width: 80,
                                              title: "Blej",
                                              onTap: () {
                                                CommonFunction.onPlanClick(
                                                    context);
                                              },
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: AllList.businessPlan.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              height: 120,
                              // width: 415,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // if(AllList.businessPlan[index].mrp != null)
                                            Text(
                                              "EMRI I PLANIT",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              "${AllList.businessPlan[index].planName}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .errorColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            const Spacer(),
                                            if (AllList.businessPlan[index]
                                                    .mrp !=
                                                null)
                                              Text(
                                                "${AllList.businessPlan[index].mrp}",
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: Theme.of(
                                                                context)
                                                            .highlightColor,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            const Spacer()
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (AllList.businessPlan[index]
                                                    .mrp !=
                                                null)
                                              Text(
                                                "VLEFSHMËRIA",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            // if(AllList.businessPlan[index].mrp != null)
                                            Text(
                                                "${AllList.businessPlan[index].validity}",
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge)
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (AllList.businessPlan[index]
                                                    .mrp !=
                                                null)
                                              Text(
                                                "TË DHËNAT",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            // if(AllList.businessPlan[index].mrp != null)
                                            Text(
                                                "${AllList.businessPlan[index].totalData}",
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge)
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (AllList.businessPlan[index]
                                                    .mrp !=
                                                null)
                                              Text(
                                                "ABONIM",
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              AllList.businessPlan[index]
                                                      .otherAddon ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            const Spacer(),
                                            MyButton(
                                              height: 30,
                                              width: 80,
                                              title: "Blej",
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: true,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Rimbushje!"),
                                                      content: const Text(
                                                          "Lidhu me Dyqanin"),
                                                      actions: [
                                                        TextButton(
                                                          child: const Text(
                                                              "Cancel"),
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: const Text(
                                                              "Ok"),
                                                          onPressed: () {
                                                            Get.back();
                                                            Get.to(
                                                                const StoreListScreen(
                                                              index: true,
                                                            ));
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
