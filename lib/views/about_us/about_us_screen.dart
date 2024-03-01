import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/widget/cache_network_image.dart';

import '../../utils/urls.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  bool loading = false;
  String about = "";
  String? image;


  apiAboutUs()async{
    setState(() {
      loading =true;
    });
    print("abc");
    final response = await get(Uri.parse(baseURL+"get-about"));
    final parse = jsonDecode(response.body);


    if(response.statusCode !=200){
      return;
    }
    setState(() {
   about = parse["about"]["aboutus"];
   image = parse["about"]["images"];

      setState(() {
        loading =false;
      });
    });
  }
@override
  void initState() {
  apiAboutUs();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
        title: Text(
          "Rreth Nesh",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: !loading,
          replacement: Center(child: CircularProgressIndicator.adaptive(),),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyCacheNetworkImages(
                    imageUrl: image ?? "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/lago-1257-home-office-36e8-with-air-desk-1593015859.jpg?crop=1.00xw:0.937xh;0,0.0537xh&resize=980:*",
                    radius: 15,
                    height: width * .53,
                    width: width,
                  ),
                  SizedBox(height: height*.03,),
                  Text("Rreth Kompanisë", style: Theme.of(context).textTheme.headline1!.copyWith(color: Color(0xff2a319c)),) ,
                  SizedBox(height: height*.01,),
                  Text(about,
                    style: Theme.of(context).textTheme.bodyText1,),
                  SizedBox(height: height*.02,),
                  Text("Informacion", style: Theme.of(context).textTheme.headline4,) ,
                  SizedBox(height: height*.015,),
                  Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 15005.",
                    style: Theme.of(context).textTheme.bodyText1,)
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
