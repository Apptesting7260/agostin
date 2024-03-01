
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static final light = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      shadowColor: Colors.white,
      canvasColor: Colors.black,

      highlightColor: Color(0xff2a319c),
      errorColor: Color(0xfff71921),
      scaffoldBackgroundColor: Color(0xE5ECEBEB),
      fontFamily: GoogleFonts.openSans().fontFamily,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Color(0xff2a319c)),
      primarySwatch: Colors.blueGrey,
      focusColor: Colors.grey,
      listTileTheme: ListTileThemeData(
        tileColor: MaterialStateColor.resolveWith((states) =>Colors.white),
        textColor: MaterialStateColor.resolveWith((states) =>Colors.black),
      ),
      checkboxTheme: CheckboxThemeData(
        // overlayColor: MaterialStateColor.resolveWith((states) =>Colors.red),
          checkColor: MaterialStateColor.resolveWith((states) =>Colors.white),
          fillColor:  MaterialStateColor.resolveWith((states) =>Color(0xff2a319c)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),
          ),
          side: BorderSide(color: Colors.green)
      ),
      radioTheme: RadioThemeData(
        fillColor:MaterialStateColor.resolveWith((states) =>Colors.blue),
        overlayColor: MaterialStateColor.resolveWith((states) =>Colors.grey),


      ),
      appBarTheme:  const AppBarTheme(
        backgroundColor: Color(0xE5ECEBEB),
          // color: Color(0xE5ECEBEB),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle( fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w700),
          iconTheme: IconThemeData(color: Color(0xff2a319c)),
          actionsIconTheme: IconThemeData(color: Color(0xff2a319c))),
      iconTheme: const IconThemeData(color: Color(0xff2a319c)),
      dividerColor: Color(0xff2a319c),


      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xff2a319c),
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Color(0xff2a319c)),
        unselectedIconTheme: IconThemeData(color: Colors.white),
        elevation: 8,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // foregroundColor: Colors.red,
          backgroundColor: Color(0xfff71921),

          textStyle: GoogleFonts.openSans(
              fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w500),
          // minimumSize: const Size(100, 45),
          // maximumSize:  Size(100, 45),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Color(0xfff71921),
        actionTextColor: Color(0xff2a319c),
        contentTextStyle: GoogleFonts.raleway(fontSize: 18,color: Color(0xff2a319c),fontWeight: FontWeight.w700),

      ),
      textTheme: TextTheme(
        headlineLarge:GoogleFonts.raleway(fontSize: 26, fontWeight: FontWeight.w700,color: Colors.black,),
        displayLarge: GoogleFonts.raleway(fontSize: 24, color: Colors.black,fontWeight: FontWeight.w700),
        displayMedium: GoogleFonts.raleway(fontSize: 22, color: Colors.black,fontWeight: FontWeight.w700),
        displaySmall: GoogleFonts.raleway(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
        headlineMedium: GoogleFonts.raleway(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w700),
        headlineSmall: GoogleFonts.raleway(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w700),
        titleLarge: GoogleFonts.raleway(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w700),
        labelMedium: GoogleFonts.raleway(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700),
        titleMedium: GoogleFonts.raleway(fontSize: 16, color: Colors.black),
        titleSmall: GoogleFonts.raleway(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
        bodyLarge: GoogleFonts.raleway(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.raleway(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
        bodySmall: GoogleFonts.raleway(fontSize: 12, color: Colors.black,fontWeight: FontWeight.normal),
        labelLarge: GoogleFonts.raleway(fontSize: 12, color: Colors.white),
        labelSmall: GoogleFonts.raleway(fontSize: 10, color: Colors.black),
      )



  );

  //  this is Dark theme for whole application .............
  static final dark = ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,

      highlightColor:Colors.green ,
      focusColor: Colors.grey,
      // iconTheme: const IconThemeData(color: Colors.white),
      listTileTheme: ListTileThemeData(
        tileColor: MaterialStateColor.resolveWith((states) =>Colors.black),
        textColor: MaterialStateColor.resolveWith((states) =>Colors.white),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        elevation: 8,
      ),

      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle( fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w700),
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black)),
      radioTheme: RadioThemeData(
        fillColor:MaterialStateColor.resolveWith((states) =>Colors.blue),
        overlayColor: MaterialStateColor.resolveWith((states) =>Colors.grey),


      ),
      checkboxTheme: CheckboxThemeData(
        // overlayColor: MaterialStateColor.resolveWith((states) =>Colors.red),
          checkColor: MaterialStateColor.resolveWith((states) =>Colors.black),
          fillColor:  MaterialStateColor.resolveWith((states) =>Colors.blue),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),
          ),
          side: BorderSide(color: Colors.green)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // foregroundColor: Colors.red,
          backgroundColor: Color(0xfff71921),
          textStyle: GoogleFonts.openSans(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w700),
          minimumSize: const Size(145, 40),
          maximumSize:  Size(200, 40),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
        ),
      ),
      textTheme:TextTheme(

        headlineLarge:GoogleFonts.raleway(fontSize: 26, color: Colors.white, fontWeight: FontWeight.w700),
        displayLarge: GoogleFonts.raleway(fontSize: 24, color: Colors.white,fontWeight: FontWeight.w700),

        displayMedium: GoogleFonts.raleway(fontSize: 22, color: Colors.white,fontWeight: FontWeight.w700),
        displaySmall: GoogleFonts.raleway(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700),
        headlineMedium: GoogleFonts.raleway(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w700),
        headlineSmall: GoogleFonts.raleway(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w700),
        titleLarge: GoogleFonts.raleway(fontSize: 18, color: Colors.white,fontWeight: FontWeight.w700),
        labelMedium: GoogleFonts.raleway(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700),



        titleMedium: GoogleFonts.raleway(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
        titleSmall: GoogleFonts.raleway(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),

        bodyLarge: GoogleFonts.raleway(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.raleway(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
        bodySmall: GoogleFonts.raleway(fontSize: 12, color: Colors.red.shade400),

        labelLarge: GoogleFonts.raleway(fontSize: 12, color: Colors.black),
        labelSmall: GoogleFonts.raleway(fontSize: 10, color: Colors.white),


      )
  );

//  Button Themes.....................
  static final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.red,
    backgroundColor: Colors.red,

    textStyle: GoogleFonts.raleway(
        fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w700),
    minimumSize: const Size(145, 40),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
  );

//
// Color darkModeGetWhiteColor({@required BuildContext context}) =>
//     MediaQuery.of(context).platformBrightness != Brightness.dark
//         ? Colors.black
//         : Colors.white;

// //  Text Style.....................static
//   static final TextTheme textThemesStyle = TextTheme(
//     headlineLarge:GoogleFonts.openSans(fontSize: 26, color: Colors.black, fontWeight: FontWeight.w700),
//     headline1: GoogleFonts.openSans(fontSize: 24, color: Colors.black,fontWeight: FontWeight.w700),
//
//     headline2: GoogleFonts.openSans(fontSize: 22, color: Colors.black,fontWeight: FontWeight.w700),
//     headline3: GoogleFonts.openSans(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
//     headline4: GoogleFonts.openSans(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w700),
//     headline5: GoogleFonts.openSans(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w700),
//     headline6: GoogleFonts.openSans(fontSize: 18, color: Colors.black,fontWeight: FontWeight.w700),
//     labelMedium: GoogleFonts.openSans(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w700),
//
//
//
//     bodyText1: GoogleFonts.openSans(fontSize: 16, color: Colors.black),
//     bodyText2: GoogleFonts.openSans(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
//
//     subtitle1: GoogleFonts.openSans(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
//     subtitle2: GoogleFonts.openSans(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
//     overline: GoogleFonts.openSans(fontSize: 12, color: Colors.red.shade400),
//
//     button: GoogleFonts.openSans(fontSize: 12, color: Colors.black),
//     caption: GoogleFonts.openSans(fontSize: 10, color: Colors.black),
//
//
//   );

/*static final PinTheme pinTheme = PinTheme(
    shape: PinCodeFieldShape.box,
    inactiveColor: Colors.white,
    inactiveFillColor: Colors.white,
    borderRadius: BorderRadius.circular(5),
    fieldHeight: 40,
    fieldWidth: 40,
    activeFillColor: Colors.white,
    activeColor: Colors.cornflowerBlue,
  );*/
}
