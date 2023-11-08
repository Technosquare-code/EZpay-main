import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  String? hint;
  IconData? icon;
  String? textIcon;
  Color? color;
  Widget? suffix;
  Color? borderColor;
  Color? errorTextColor;
  FocusNode? focusNode;
  bool? readOnly;
  String? initialValue;
  TextStyle? textStyle;
  TextInputType? type;
  TextEditingController? controller;
  Function(String)? onChanged;
  Function()? onTap;
  String? Function(String?)? validator;

  InputField({
    this.hint,
    this.color,
    this.controller,
    this.focusNode,
    this.icon,
    this.type,
    this.readOnly,
    this.errorTextColor,
    this.initialValue,
    this.borderColor,
    this.textStyle,
    this.suffix,
    this.onChanged,
    this.textIcon,
    this.validator,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      keyboardType: type,
      readOnly: readOnly ?? false,
      initialValue: initialValue,
      focusNode: focusNode,
      onTap: onTap,
      style: textStyle ?? const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: const TextStyle(),
        prefixIcon: textIcon == null
            ? icon != null
                ? Icon(icon, color: Colors.grey)
                : null
            : Container(
                width: 10,
                height: 45,
                alignment: Alignment.center,
                child: Text(
                  textIcon!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        // ignore: prefer_if_null_operators
        suffixIcon: suffix != null
            ? suffix
            : icon != null
                ? null
                : const SizedBox(),
        filled: true,
        fillColor: color,
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 45,
          minHeight: 45,
          maxWidth: 48,
          minWidth: 48,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 45,
          minHeight: 45,
          maxWidth: 48,
          minWidth: 48,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
