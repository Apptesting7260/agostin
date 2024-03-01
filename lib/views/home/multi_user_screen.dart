



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibc_telecom/bottom_bar/tab_screen.dart';
import 'package:ibc_telecom/shared_pref/preference.dart';
import 'package:ibc_telecom/views/home/home_screen.dart';
import 'package:ibc_telecom/views/home/multi_user_model.dart';
import 'package:new_pinput/new_pinput.dart';

class BottomSheetScree extends StatefulWidget {
  // final MultiUserModel data;
  // final List<PrimaryAccount> secoundryAccount;
// required this.data, required this.secoundryAccount
  const BottomSheetScree(
      {Key? key, })
      : super(key: key);

  @override
  State<BottomSheetScree> createState() => _BottomSheetScreeState();
}

class _BottomSheetScreeState extends State<BottomSheetScree> {
  bool isSelected = false;
  int? ids;
  int currentIndex = 0;
  bool selectedid=false;
  int? selectedindex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shiko Llogari tjetër",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "",
              // widget.data.primaryAccount?.mobile ?? "",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Theme.of(context).highlightColor),
            ),
          ],
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.close,
                size: 40,
              )),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Llogaria primare",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()),

              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color: Colors.black),),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(Icons.sim_card),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user_id.toString()??
                        // widget.data.primaryAccount?.custId.toString() ?? "",
                        "",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        userName.toString()??
                        // widget.data.primaryAccount?.username ?? "",
                        "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        mobileNumber.toString()??
                        // widget.data.primaryAccount?.mobile ?? "",
                        "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.circle_outlined,color: Colors.blue,),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Llogaritë e lidhura",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            if (multiuserlist!=[])
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount:multiuserlist.length,
                  itemBuilder: (context, index) {
                    bool isSelected = multiuserlist[index]['id'] == ids;
                    return GestureDetector(
                      onTap: () {
                        ids=multiuserlist[index]['id'];
                        // ids = widget.secoundryAccount[index].id;
                        selectedindex = index;
                
                        MySharedPreferences.localStorage?.setInt("customer_id",
                        multiuserlist[index]['cust_id']??0);
                            // widget.secoundryAccount[index].custId ?? 0);
                        MySharedPreferences.localStorage
                            ?.setString(
                              MySharedPreferences.fullName, 
                               multiuserlist[index]['username']
                              // widget.secoundryAccount[index].username
                               ??"") ??
                            "";
                        Get.to(TabScreen(index: 0));
                
                        // Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              const Icon(Icons.sim_card,size: 30,),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    multiuserlist[index]['cust_id'].toString()??
                                    // multiuserlist[]
                                    // widget.secoundryAccount[index].custId
                                    //     .toString() ??
                                        "",
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                       multiuserlist[index]['username'].toString()??"",
                                    // widget.secoundryAccount[index].username ?? "",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                       multiuserlist[index]['mobile'].toString()??"",
                
                                    // widget.secoundryAccount[index].mobile ?? "",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Icon( Icons.circle_outlined,color: isSelected ? Theme.of(context).highlightColor:Theme.of(context).errorColor, ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
