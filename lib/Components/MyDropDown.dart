import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyDropdown extends StatelessWidget {
  final List? items;
  final Function(Object?)? onChanged;
  final String? Function(Object?)? validator;
  final String? hint;
  final TextStyle? hintStyle;
  final IconData? icon;
  final Widget? suffix;
  final Color? color;
  final double? size;
  final double? borderRadius;
  final Color? errorTextColor;
  final Color? borderColor;
  final Object? value;

  const MyDropdown({
    @required this.items,
    @required this.onChanged,
    this.validator,
    this.borderColor,
    this.hint,
    this.hintStyle,
    this.size,
    this.suffix,
    this.icon,
    this.errorTextColor,
    this.color,
    this.value,
    this.borderRadius,
  });
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Object>(
      isExpanded: true,
      items: items != null
          ? List.generate(
              items!.length,
              (index) => DropdownMenuItem(
                value: items![index],
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (items![index].image != "")
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: items![index].image.toString().contains(".svg")
                            ? SvgPicture.network(
                                items![index].image,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                items![index].image,
                                fit: BoxFit.fill,
                              ),
                      ),
                    const SizedBox(width: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width - 110,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${items![index].name}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      value: value,
      onChanged: onChanged,
      validator: validator,
      isDense: true,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle:
            hintStyle ?? const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        suffixIcon: suffix,
        filled: true,
        fillColor: color,
        suffixIconConstraints: BoxConstraints(
          maxHeight: size ?? 35,
          minHeight: size ?? 35,
          maxWidth: size == null ? 38 : (size! + 3),
          minWidth: size == null ? 38 : (size! + 3),
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: size ?? 35,
          minHeight: size ?? 35,
          maxWidth: size == null ? 38 : (size! + 3),
          minWidth: size == null ? 38 : (size! + 3),
        ),
        contentPadding: EdgeInsets.only(
          top: icon == null
              ? suffix == null
                  ? size == null
                      ? 10
                      : (size! / 2)
                  : 0
              : 0,
          bottom: icon == null
              ? suffix == null
                  ? size == null
                      ? 10
                      : (size! / 2)
                  : 0
              : 0,
          right: 0,
          left: icon == null ? 15 : 0,
        ),
        errorStyle: errorTextColor != null
            ? TextStyle(color: errorTextColor)
            : const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: borderColor != null
              ? BorderSide(color: borderColor!)
              : const BorderSide(color: Colors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: borderColor != null
              ? BorderSide(color: borderColor!)
              : const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: borderColor != null
              ? BorderSide(color: borderColor!)
              : const BorderSide(color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: borderColor != null
              ? BorderSide(color: borderColor!)
              : const BorderSide(color: Colors.transparent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
