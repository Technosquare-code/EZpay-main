import 'package:billapp/Utils/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class Utils {
  Future<void> showErrorDialog(BuildContext context, String msg) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, color: Colors.grey, size: 80),
            const SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: MyColor.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 8,
                ),
              ),
              child: const Text(
                "OK",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  showSuccessDialog(BuildContext context, String msg, Function accept,
      {double? fontSize, String? title, bool? html, String? subTitle}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline,
                color: Colors.green, size: 80),
            const SizedBox(height: 15),
            if (title != null)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (title != null) const SizedBox(height: 10),
            if (html != null && html == true)
              Html(
                data: msg,
                shrinkWrap: true,
                style: {
                  "*": Style(
                    alignment: Alignment.center,
                    textAlign: TextAlign.center,
                  ),
                },
              ),
            if (html == null || html == false)
              Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize ?? 22,
                  color: Colors.black,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (subTitle != null) const SizedBox(height: 5),
            if (subTitle != null)
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black87,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w600,
                ),
              ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: MyColor.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 8,
                ),
              ),
              child: const Text(
                "OK",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => accept(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDeleteDialog(
      BuildContext context, String msg, Function() onTap) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info_outline, color: Colors.grey, size: 80),
            const SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyColor.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    "NO",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyColor.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    "YES",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: onTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showSuccessPaymentDialog(
    BuildContext context,
    String title,
    String body1,
    String body2,
    Function accept, {
    double? fontSize,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black12,
      builder: (ctx) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 70,
            ),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 22,
                color: Colors.black,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              body1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 18,
                color: Colors.black,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              body2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 20,
                color: Colors.black,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: MyColor.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 8,
                ),
              ),
              child: const Text(
                "OK",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => accept(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showFavDelete(
      BuildContext context, String msg, Function() onTap) async {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      builder: (ctx) => AlertDialog(
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 70,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(color: Colors.grey.shade400, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyColor.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "NO",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyColor.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "YES",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: onTap,
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

InputDecoration phoneDecoration(
    {required Color fillColor, required Color error}) {
  return InputDecoration(
    filled: true,
    isDense: true,
    counter: const SizedBox(),
    fillColor: fillColor,
    suffixIconConstraints: const BoxConstraints(
      maxHeight: 45,
      minHeight: 45,
      maxWidth: 48,
      minWidth: 48,
    ),
    prefixIconConstraints: const BoxConstraints(
      maxHeight: 45,
      minHeight: 45,
      maxWidth: 100,
      minWidth: 100,
    ),
    contentPadding: const EdgeInsets.all(0),
    errorStyle: TextStyle(color: error),
    hintText: 'Phone Number',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.red),
    ),
  );
}
