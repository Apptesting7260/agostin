
import 'package:flutter/material.dart';
import 'package:new_pinput/new_pinput.dart';
// import 'package:pinput/pin_put/pin_put.dart';


import '../utils/device_size.dart';

class PinFields extends StatefulWidget {
  final Key formKey;
  final FocusNode pinPutFocusNode ;
  final TextEditingController controller;
  const PinFields({Key? key, required this.formKey, required this.controller, required this.pinPutFocusNode}) : super(key: key);

  @override
  State<PinFields> createState() => _PinFieldsState();
}

class _PinFieldsState extends State<PinFields> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();


  // BoxDecoration get _pinPutDecoration {
  //   return BoxDecoration(
  //     border: Border.all(color: Color(0xff2a319c)),
  //     borderRadius: BorderRadius.circular(15.0),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final BoxDecoration _pinPutDecoration = BoxDecoration(

      color: const Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all()
    );
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color(0xff2a319c), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff2a319c)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

   final  width = MediaQuery.of(context).size.width;
   final height = MediaQuery.of(context).size.height;
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /*Pinput(

            validator: (s) {
              if (s?.contains('1')??false) return null;
              return 'NOT VALID';
            },
            useNativeKeyboard: true,
            length: 6,
            // fieldsCount: 6,

            fieldsAlignment: MainAxisAlignment.spaceAround,
            textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
            eachFieldMargin: const EdgeInsets.all(0),
            eachFieldWidth: 45.0,
            eachFieldHeight: 55.0,
            onSubmit: (String pin) => DeviceUtils.hideKeyboard(context),
            focusNode: widget.pinPutFocusNode,
            controller: widget.controller,
            submittedFieldDecoration: pinPutDecoration.copyWith(
              color: Colors.white,

            ),
            selectedFieldDecoration: pinPutDecoration.copyWith(
              color: Colors.white,
              border: Border.all(
                width: 2,
                color:  Colors.black,
              ),
            ),

            followingFieldDecoration: pinPutDecoration.copyWith(color: Colors.white),
            pinAnimationType: PinAnimationType.scale,
          ),*/

          Pinput(
            length: 6,
            autofocus: true,

            // validator: (s) {
              //   if (s!.length < 6) return null;

              // if (s?.contains('1')??false) return null;
              // return 'NOT VALID';
            // },
            useNativeKeyboard: true,
            keyboardType: TextInputType.number,
            // textStyle: TextStyle(fontSize: width * 0.04, color: Palette.dark_blue),
            defaultPinTheme: defaultPinTheme,
            onSubmitted: (String pin) => _showSnackBar(pin, context),
            focusNode: _pinPutFocusNode,
            controller: widget.controller,
            submittedPinTheme: defaultPinTheme,
            focusedPinTheme:defaultPinTheme,
            followingPinTheme:defaultPinTheme,
          ),
        ],
      ),
    );
  }
  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pini u dorëzua. Vlera: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).highlightColor,
    );
    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

  }
}
