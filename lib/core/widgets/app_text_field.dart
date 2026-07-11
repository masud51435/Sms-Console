import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int? maxLines;


  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black87
                : Colors.white70,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
