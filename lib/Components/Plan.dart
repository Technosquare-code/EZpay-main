import 'package:billapp/Urls/Urls.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:flutter/material.dart';

class Plan extends StatefulWidget {
  final String index;
  final String? title;
  final String? image;
  final String? currency;
  final String selectedIndex;
  final Function() onTap;

  const Plan({
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    this.title,
    this.image,
    this.currency,
  });
  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: widget.index == widget.selectedIndex
              ? BorderSide(color: MyColor.primaryColor, width: 2)
              : BorderSide(color: Colors.grey.shade400, width: 1),
        ),
        child: Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 60,
                child: widget.image == null
                    ? Image.asset(
                        "assets/images/icon.png",
                        fit: BoxFit.fill,
                      )
                    : FadeInImage(
                        fit: BoxFit.fill,
                        placeholder: const AssetImage("assets/images/icon.png"),
                        image: NetworkImage("$planImageUrl${widget.image}"),
                        imageErrorBuilder: (ctx, obj, st) => Image.asset(
                          "assets/images/icon.png",
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  widget.title ?? "_",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black45,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "${widget.currency ?? "\$"} ${widget.index}",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
