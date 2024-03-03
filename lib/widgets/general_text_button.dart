// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:npstock/styles/app_colors.dart';
import 'package:npstock/styles/text_styles.dart';

class GeneralTextButton extends StatelessWidget {
  final String title;
  final Color? bgColor;
  final Color? fgColor;
  final Color? prefixColor;
  final Color? borderColor;
  final double? borderSize;
  final bool isMinimumWidth;

  final bool isSmallText;
  final double? imageH;
  final IconData? prefixIcon;
  final bool loading;
  final VoidCallback? onPressed;
  final String? prefixImage;
  final double? borderRadius;
  final double? height;
  final bool isDisabled;
  final double? width;
  final FontWeight fontWeight;
  TextStyle? textStyle;
  GeneralTextButton({
    Key? key,
    this.isSmallText = false,
    required this.title,
    this.isDisabled = false,
    this.borderSize,
    this.isMinimumWidth = false,
    this.borderColor,
    this.textStyle,
    this.loading = false,
    this.bgColor,
    this.fgColor,
    this.onPressed,
    this.borderRadius,
    this.height,
    this.width,
    this.prefixImage,
    this.prefixColor,
    this.imageH,
    this.fontWeight = FontWeight.w500,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (textStyle == null) {
      if (isSmallText) {
        textStyle = smallText.copyWith(
          color: fgColor ?? AppColors.primaryGreen,
          fontWeight: FontWeight.w600,
        );
      } else {
        textStyle = bodyText.copyWith(
          color: fgColor ?? AppColors.primaryGreen,
          fontWeight: fontWeight,
        );
      }
    }

    return SizedBox(
      height: height ?? 56,
      width:
          width ?? (isMinimumWidth ? null : MediaQuery.of(context).size.width),
      child: OutlinedButton(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor:
              MaterialStateProperty.all(bgColor ?? Colors.transparent),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: borderColor ?? AppColors.primaryGreen,
              width: borderSize ?? 1,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 100),
            ),
          ),
        ),
        onPressed: (isDisabled || loading) ? null : onPressed,
        child: loading
            ? const CircularProgressIndicator(
                color: AppColors.primaryGreen,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null)
                    Icon(
                      prefixIcon,
                      color: prefixColor,
                      size: imageH ?? 24,
                    ),
                  if (prefixImage != null)
                    Image.asset(
                      prefixImage!,
                      height: imageH ?? 24,
                      color: prefixColor,
                    ),
                  if (prefixImage != null || prefixIcon != null)
                    const SizedBox(
                      width: 5,
                    ),
                  Text(
                    title,
                    style: textStyle,
                  ),
                ],
              ),
      ),
    );
  }
}
