import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TransactionLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      shrinkWrap: true,
      itemBuilder: (ctx, i) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.shade400,
                            Colors.grey.shade200,
                            Colors.grey.shade100,
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: MediaQuery.of(context).size.width / 4,
                          height: 8,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Shimmer(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.shade400,
                            Colors.grey.shade200,
                            Colors.grey.shade100,
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: MediaQuery.of(context).size.width / 2,
                          height: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                Shimmer(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade400,
                      Colors.grey.shade200,
                      Colors.grey.shade100,
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 60,
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade400, thickness: 0.5),
        ],
      ),
    );
  }
}
