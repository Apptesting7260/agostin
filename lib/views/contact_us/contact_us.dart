import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ibc_telecom/utils/snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/urls.dart';

class SupportScreen extends StatefulWidget {
  final bool? index ;
  const SupportScreen({Key? key, this.index}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messagecontroller = TextEditingController();

  @override
  void initState() {
    getDetail();
    super.initState();
  }

  String?  number ;
  String?  email;
  String?  address;
  bool loading = false;

  getDetail() async{
    setState(() {
      loading =true;
    });
    print("abc");
    final response = await get(Uri.parse(baseURL+"get-company-details"));
    final parse = jsonDecode(response.body);


    if(response.statusCode !=200){
      return;
    }
    setState(() {
      number = parse["data"]["mob_no"];
      email = parse["data"]["email"];
      address = parse["data"]["address"];

      setState(() {
        loading =false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.index==true? AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5)),
            child:  GestureDetector(
              child: Icon(Icons.arrow_back, color: Colors.white),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: Text(
          "Na kontaktoni",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ): null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible:!loading ,
          replacement: Center(child: CircularProgressIndicator.adaptive(),),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  leading: Icon(Icons.call, color:Theme.of(context).errorColor),
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  title: Text(
                    "Numri I telefonit",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.blue.shade900),
                  ),
                  subtitle: Text( number ?? ""),
                  trailing: GestureDetector(
                      onTap: () {


                        whatsapp();
                      },

                      child: Image.asset("assets/image/whatapp.png")),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(Icons.email, color: Theme.of(context).errorColor),
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  title: Text(
                    "Adresa e-mail",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.blue.shade900),
                  ),
                  subtitle: Text( email ??""),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Icon(Icons.location_on, color:Theme.of(context).errorColor),
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  title: Text(
                    "Adresa",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.blue.shade900),
                  ),
                  subtitle: Text(address ??""),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: TextFormField(
                            controller: namecontroller,
                            validator: (value) {
                              if (value == null) {
                                print("null");
                                return "Enter Value";
                              }
                              return null;
                            },
                            decoration:  InputDecoration(
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontSize: 14, backgroundColor: Colors.white60),
                              contentPadding: EdgeInsets.all(15),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                                // borderRadius: BorderRadius.circular(30.0)
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                // borderRadius: BorderRadius.circular(30.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                                // borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                // borderRadius: BorderRadius.circular(30.0),
                              ),
                              hintText: "Emri",
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child:TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null) {
                                print("null");
                                return "Vendosni numrin e telefonit";
                              } else if (value.length < 10) {
                                return "Vendosni valid Numri I telefonit";
                              }
                              return null;
                            },
                            decoration:  InputDecoration(
                              isDense: true,
                              hintStyle: TextStyle(
                                  fontSize: 14, backgroundColor: Colors.white60),
                              contentPadding: EdgeInsets.all(15),
                              disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                                // borderRadius: BorderRadius.circular(30.0)
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                // borderRadius: BorderRadius.circular(30.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                                // borderRadius: BorderRadius.circular(30.0),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                // borderRadius: BorderRadius.circular(30.0),
                              ),
                              hintText: "Email",
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                          ),
                        )
                      ]),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: messagecontroller,
                        validator: (value) {
                          if (value == null) {
                            print("null");
                            return "null";
                          } else if (value.length < 10) {
                            print("value kam h");
                            return "Fut numrin e vlefshëm të emailit";
                          }
                          return null;
                        },
                        decoration:  InputDecoration(
                          isDense: true,
                          hintStyle: TextStyle(
                              fontSize: 14, backgroundColor: Colors.white60),
                          contentPadding: EdgeInsets.all(15),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey),
                            // borderRadius: BorderRadius.circular(30.0)
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            // borderRadius: BorderRadius.circular(30.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey),
                            // borderRadius: BorderRadius.circular(30.0),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            // borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: "Mesazh",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .35,
                        height: MediaQuery.of(context).size.height * .05,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(60, 35),
                                maximumSize:
                                Size(MediaQuery.of(context).size.width * .6, 35)),
                            onPressed: () {
                              SendpostApi();
                            },
                            child: Text(
                              "DORËZOJ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            )),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SendpostApi() async {
    final body = {

      "email": emailController.text,
      "message": messagecontroller.text,
    };
    final response = await post(Uri.parse("https://api-payment.ibc.al/api/send-email"),
        body: body);
    final parse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        showError(title: "Success", description: parse["message"]);


      });
    }
    {

    }
  }

  postApi() async {
    final body = {
      "name": namecontroller.text,
      "email": emailController.text,
      "message": messagecontroller.text,
    };
    final response = await post(Uri.parse(baseURL+"contact-us"),
        body: body);
    final parse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
       showError(title: "Success", description: parse["message"]);


      });
    }
    {

    }
  }
 // var contact = "";
  whatsapp() async{

    // var androidUrl = "whatsapp://send?phone=$number&text=Hi, I need some help";
    var androidUrl = "https://wa.me/?text=YourTextHere";
    var iosUrl = "https://wa.me/$number?text=${Uri.parse('Hi, I need some help')}";
    // var iosUrl = "whatsapp://send?text=Hello World!";

    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl),mode: LaunchMode.externalApplication);
      }
      else{
        await launchUrl(Uri.parse(androidUrl),mode: LaunchMode.externalApplication);
      }
    } on Exception{
      showError(title: "Error",
      description: "WhatsApp nuk është i instaluar.");
    }
  }



}