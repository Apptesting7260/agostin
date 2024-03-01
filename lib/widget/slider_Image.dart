
import 'dart:async';
import 'package:flutter/material.dart';

import 'cache_network_image.dart';


class MySlider extends StatefulWidget {
  final List<dynamic> silderData;
  MySlider({ required this.silderData});

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {

  int sliderlength = 0;
  PageController? _pageController;
  int i = 60;
  Timer? _clockTimer;

  sliderTimer() {
    _clockTimer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (i == 60) {
        _pageController!.jumpToPage(i);
        i++;
      } else if (i < (widget.silderData.length * 20)) {
        _pageController!.animateToPage(i,
            duration: const Duration(milliseconds: 200), curve: Curves.decelerate);
        i++;
      } else {
        i = 60;
        _pageController!.jumpToPage(i);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    sliderTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _clockTimer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    sliderlength = widget.silderData.length;
    //MySlider(this._imgSlider);
    // print("Slider length == $sliderlength");
    double orientationHeight;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      orientationHeight = MediaQuery.of(context).size.height;
    }else{
      orientationHeight = MediaQuery.of(context).size.width * 1.1;
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: orientationHeight * 0.18,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
      ),
      child: PageView.builder(
        pageSnapping: true,
        controller: _pageController = PageController(initialPage: 0),
        allowImplicitScrolling: true,
        onPageChanged: (value) {
          i = value;
        },
        itemCount: widget.silderData.length * 50,
        itemBuilder: (ctx, index) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Colors.black),
          padding: const EdgeInsets.all(4),
          child: sliderlength == 0
              ? Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(20)
            ),
            child: const CircularProgressIndicator(
              strokeWidth: 5,
              // valueColor: AlwaysStoppedAnimation<Color>(Colors.black),backgroundColor: Colors.red,
            ),
          )
              : MyCacheNetworkImages(
              imageUrl:  "${widget.silderData[index % widget.silderData.length]}",
              radius: 15),
        ),
      ),
    );
  }
}
