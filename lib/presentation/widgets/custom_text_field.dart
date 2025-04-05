import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safqa_app/core/utils/app_icons.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final int maxLines;
  final bool issuff;
  final Widget? suff;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator; // إضافة التحقق

  const CustomTextField(
      {super.key,
      required this.hintText,
      this.isPassword = false, // افتراضيًا ليس حقل كلمة مرور
      this.maxLines = 1,
      this.issuff = false,
      this.textEditingController,
      this.validator,
      this.suff});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword; // ضبط حالة الإخفاء بناءً على `isPassword`
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: widget.maxLines == 1 ? 53.h : null,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffEBECED)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          controller: widget.textEditingController,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          obscureText: widget.isPassword ? _isObscure : false,
          validator: widget.validator, // ربط التحقق

          decoration: InputDecoration(
            suffix: widget.issuff ? widget.suff : null,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    child: SvgPicture.asset(
                      _isObscure ? AppIcons.eyeDisable : AppIcons.eyeEnable,
                      color: const Color(0xffD0D1D2),
                    ),
                  )
                : null, // لا تعرض الأيقونة إذا لم يكن `TextField` لكلمة المرور
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xffD0D1D2),
              fontWeight: FontWeight.normal,
            ),
          ),
          clipBehavior: Clip.antiAlias,
        ),
      ),
    );
  }
}
