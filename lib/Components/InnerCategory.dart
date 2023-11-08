import 'package:billapp/Urls/Urls.dart';
import 'package:flutter/material.dart';

class InnerCategory extends StatelessWidget {
  final String image;
  final String name;

  const InnerCategory(this.image, this.name);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.grey, width: 1),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width / 3.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder:
                      const AssetImage("assets/images/placeholder.png"),
                  image: NetworkImage("$categoryImgUrl$image"),
                  imageErrorBuilder: (ctx, obj, st) {
                    return Image.asset(
                      "assets/images/placeholder.png",
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 4.5,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
