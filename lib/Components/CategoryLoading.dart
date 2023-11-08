import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: (MediaQuery.of(context).size.width / 4.2) / 95,
      ),
      itemCount: 9,
      itemBuilder: (ctx, i) => Shimmer(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade400,
            Colors.grey.shade200,
            Colors.grey.shade100,
          ],
        ),
        child: Container(
          height: 90,
          color: Colors.grey,
          width: MediaQuery.of(context).size.width / 4,
        ),
      ),
    );
  }
}
