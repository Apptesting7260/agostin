import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ibc_telecom/shared_pref/preference.dart';
import 'package:ibc_telecom/views/user/option_screen.dart';
import 'package:ibc_telecom/widget/cache_network_image.dart';
import 'package:ibc_telecom/widget/my_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/urls.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String? profileImage;

  bool loading = false;
  String about = "";
  int customerId = 0;
  String userName = '';


  apiGetProfile()async{
    setState(() {
      loading =true;
    });
    print("abc");
    try {
      final response = await http.get(Uri.parse(baseURL+"get-profile/cust-id/$customerId"));
      final parse = jsonDecode(response.body);


      if(response.statusCode !=200){
        return;
      }
      setState(() {
        // nameController.text = parse["data"]["username"];
        mobileController.text = parse["data"]["mobile"];
        profileImage = parse["data"]["image"] ;



      });
    } on Exception catch (e) {
      // TODO
    }finally{
      setState(() {
        loading =false;
      });
    }
  }
  @override
  void initState() {

    userName = MySharedPreferences.localStorage
        ?.getString(MySharedPreferences.fullName) ??
        "";
    nameController.text = userName;
    customerId  =MySharedPreferences.localStorage?.getInt(MySharedPreferences.customerId) ?? 0;
    apiGetProfile();
    // TODO: implement initState
    super.initState();
  }
   ImagePicker _picker = ImagePicker();
  File image  = File("");
  String selectedImage = "";
  
  getImage(source) async{
    final pickedFile = await _picker.pickImage(source: source);
    if(pickedFile !=null){
      setState(() {
        image = File(pickedFile.path);
        print(image);
        selectedImage = pickedFile.path;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).errorColor, borderRadius: BorderRadius.circular(5)),
            child: GestureDetector(
              child: Icon(Icons.arrow_back, color: Colors.white),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: Text(
          "Profili Im ",
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child:
          Visibility(
            visible: !loading,
            replacement: Center(child: CircularProgressIndicator.adaptive(),),
            child: Visibility(
              visible: customerId !=0,
              replacement: Center(
                child: RichText(text: TextSpan(text: "Now you don't have any data to show in Profile, for that you have to login the app",style: Theme.of(context).textTheme.titleLarge,
                    children: [
                  TextSpan(text: " Dyr",style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).highlightColor),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                        Get.off(OptionScreen());
                        }
                  )
                ])),
              ),
              child: ListView(
                children: [
                  Container(height: width*.55,
                    child: Stack(
                      children: [
                        Container(
                          height:width *.35,
                          width: width,
                          decoration: BoxDecoration(color: Theme.of(context).highlightColor),),
                        Positioned(left: width *.3,
                          right: width*.3,
                          top: width * .14,

                            child: image.path.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(width*.235),
                              child: Image.file(
                                image,
                                width: width *.4,
                                height: width *.4,
                                fit: BoxFit.cover,
                              ),
                            )
                                :   profileImage !=null ?
                            MyCacheNetworkImages(imageUrl: profileImage ?? "", radius: 100,height: width *.4,width: width*.4,) :
                            ClipRRect(
                                borderRadius: BorderRadius.circular(width*.235),
                                child: Image.asset("assets/image/user.png",height: width *.4,width: width*.4,)

                            ),
                            ),
                        Positioned(
                            left: width *.6,right: width*.26,top: height*.19,
                            child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: Text(
                                        'Choose Image',
                                        style: Theme.of(context).textTheme.headline6,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            getImage(ImageSource.camera);
                                            Get.back();
                                          },
                                          child: const Text('Camera'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            getImage(ImageSource.gallery);
                                            Get.back();
                                          },
                                          child: const Text('Gallery'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Icon(Icons.add_circle_outline,size: 35,color: Theme.of(context).highlightColor,)))
                      ],
                    ),
                  ),
                  SizedBox(height: height*.04,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Emri",style: Theme.of(context).textTheme.headline6,),
                          Container(
                            width: double.infinity,
                            margin:
                            const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 3.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: TextFormField(
                              enabled: false,
                              controller: nameController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10.0),
                                border:
                                const OutlineInputBorder(borderSide: BorderSide.none),
                                fillColor: Colors.white,

                                hintText: ' Emri',
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ),

                          SizedBox(height: height*.01,),
                          Text("Numri I telefonit",style: Theme.of(context).textTheme.headline6,),
                          Container(
                            width: double.infinity,
                            margin:
                            const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 3.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: TextFormField(
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10.0),
                                border:
                                const OutlineInputBorder(borderSide: BorderSide.none),
                                fillColor: Colors.white,

                                hintText: 'Contact No',
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height*.04,),
                  Center(
                    child: MyButton(

                      title: "Ndryshoje", onTap: () {
                      apiUpdateProfile();
                    },width: width*.4,height: 50,),
                  )



      ],),
            ),
          )),
    );
  }


  apiUpdateProfile()async{
    setState(() {
      loading =true;
    });

    final body = {

    };
    print("abc");
    // final response = await http.post(Uri.parse("https://urlsdemo.xyz/ibc-telecom/api/update-profile/cust-id/$customerId"));
    // final parse = jsonDecode(response.body);



    try {
      var request = http.MultipartRequest('POST', Uri.parse(baseURL+'update-profile/cust-id/$customerId'));
      request.fields.addAll({
        'username': nameController.text,
        'mobile': mobileController.text
      });
      request.files.add(await http.MultipartFile.fromPath('image', image.path));

      http.StreamedResponse response1 = await request.send();

      if (response1.statusCode == 200) {
        print(await "=========${response1.stream.bytesToString()}");
        setState(() {
          loading =false;
        });
      }
      else {
        print(response1.reasonPhrase);
      }
    } catch (e){

    }
      finally {
      setState(() {
        loading =false;
      });
    }
  }

}
