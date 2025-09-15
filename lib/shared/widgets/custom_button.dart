import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isRequestAvaliable;
  const CustomButtonWidget({
    required this.onPressed,
    required this.text,
    this.isRequestAvaliable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 32.h * 1.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 16.h * 0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        onPressed: onPressed,
        child: isRequestAvaliable
            ? SizedBox(
                width: 16.w * 1.5,
                height: 16.h * 1.5,
                child: const CircularProgressIndicator.adaptive(
                  backgroundColor: AppColors.white,
                  valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
      ),
    );
  }
}
