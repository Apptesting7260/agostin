import 'package:flutter/material.dart';

class Bottom extends StatefulWidget {
  final int bottomSelectedIndex;
  final int user_id;
  final Function bottomTapped;


  const Bottom(
      {Key? key,
        required this.bottomSelectedIndex,
        required this.bottomTapped,
        required this.user_id})
      : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                label: "Menaxho",
                icon: Image.asset("assets/icon/manage.PNG",width: 25, color: widget.bottomSelectedIndex != 0 ?Colors.grey: null,)),
           if(widget.user_id !=0)
            BottomNavigationBarItem(
                label: "Paguaj",
                icon:Image.asset("assets/icon/pay.PNG",width: 25,color: widget.bottomSelectedIndex == 1 ?Color(0xff2a319c): null,)),
            BottomNavigationBarItem(
                label: "Dyqanet",
                icon: Image.asset("assets/icon/store.PNG",width: 25,color: widget.bottomSelectedIndex == 2 ?Color(0xff2a319c): null, )
            ),
            BottomNavigationBarItem(
                label: "Mbështetje",
                icon: Image.asset("assets/icon/support.PNG",width: 25,color: widget.bottomSelectedIndex == 3 ?Color(0xff2a319c): null,)),
          ],
          selectedItemColor: Color(0xff2a319c),
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(color: Color(0xff2a319c)),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          elevation: 8,
          backgroundColor: Colors.white,
          currentIndex: widget.bottomSelectedIndex,
          onTap: (index) {
            widget.bottomTapped(index);
            selectedIndex =index;
          },
          selectedFontSize: 14,
          unselectedFontSize: 12,

      ),
    );
  }
}

class NavItems {
  String title;
  Widget icon;

  NavItems({required this.title, required this.icon});
}

const projectAppName = "Ibc Telecom";
const stripeSecretKey = "sk_test_51HfICsEFwfZ1T0dytRNcZc5T1MY4sLn4xfgpAkt480ZwA7LFRL7hNQ7UNbG8DF36WkzQuaO0KKH3ziekdnI1xL4300LNgiqRja";  //self account
