import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  String hintText ;
  TextEditingController controller ;
  String? Function(String?)? validator ;
  TextInputType type ;
  final bool obscureText;
  Widget? suffixIcon;

  CustomTextFormField({
    required this.hintText,
    required this.controller,
    required this.validator ,
    required this.type ,
    this.suffixIcon,
    this.obscureText = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        fillColor: Colors.white,
        filled:  true ,
        hintText: hintText ,
        hintStyle: Theme.of(context).textTheme.titleSmall,
        suffixIcon: suffixIcon,


      ),
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Colors.black
      ),
      controller: controller,
      validator: validator,
      keyboardType: type ,
      obscureText: obscureText,

    );
  }
}