import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordInputField extends StatefulWidget {
  String? hint;
  IconData? icon;
  Color? color;
  Color? borderColor;
  Color? errorTextColor;
  TextEditingController? controller;
  Function(String)? onChanged;
  String? Function(String?)? validator;

  PasswordInputField({
    this.hint,
    this.color,
    this.controller,
    this.icon,
    this.borderColor,
    this.onChanged,
    this.validator,
    this.errorTextColor,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool isHidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: isHidePassword,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hint,
        filled: true,
        fillColor: widget.color,
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
        contentPadding: const EdgeInsets.all(0),
        prefixIcon: Icon(widget.icon, color: Colors.grey),
        suffixIcon: IconButton(
          icon: isHidePassword == true
              ? Icon(
                  Icons.visibility,
                  color: Colors.blueAccent.shade400,
                )
              : Icon(
                  Icons.visibility_off,
                  color: Colors.blueAccent.shade400,
                ),
          onPressed: () => setState(() {
            isHidePassword = !isHidePassword;
          }),
        ),
        errorStyle: TextStyle(color: widget.errorTextColor ?? Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
