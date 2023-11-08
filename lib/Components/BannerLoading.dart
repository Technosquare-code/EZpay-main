import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BannerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Colors.grey.shade400,
          Colors.grey.shade200,
          Colors.grey.shade100,
        ],
      ),
      child: Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6,
      ),
    );
  }
}
