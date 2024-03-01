import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Widget child;
  final bool loaderState;
  const Indicator({Key? key, required this.child, this.loaderState = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.passthrough,
      children: [
        child,
        if (loaderState)
          Container(
            height: double.infinity,
            width: double.infinity,
            child: const Center(child: CupertinoActivityIndicator()),
            color: Colors.black26,
          ),
      ],
    );
  }
}
