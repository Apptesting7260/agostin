import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyCacheNetworkImages extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double radius;
  final BoxBorder? border;
  const MyCacheNetworkImages({Key? key,
    required this.imageUrl, this.height, this.width,
    required this.radius, this.border}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
              const ColorFilter.mode(Colors.transparent, BlendMode.colorDodge)),
        ),
      ),
      placeholder: (context, url) => Container(
          height: height,
          width: width,
          child: Center(child: const CircularProgressIndicator.adaptive())),
      errorWidget: (context, url, error) => Container(
          height: height,
          width: width,
          child: Center(child:  Image.asset("assets/images/no_image.jpeg"))),
    );
  }
}
