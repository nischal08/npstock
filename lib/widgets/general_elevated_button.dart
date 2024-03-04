// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:npstock/styles/app_colors.dart';
import 'package:npstock/styles/text_styles.dart';

class GeneralElevatedButton extends StatelessWidget {
  final String title;
  final String? leadingPngPath;
  final bool isSmallText;
  final bool hasLeading;
  final bool loading;
  final bool isMinimumWidth;
  final Color? bgColor;
  final Color? fgColor;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final bool isDisabled;
  final double? height;
  final double? width;
  final BorderRadius? customBorderRadius;
  final double? elevation;
  TextStyle? textStyle;
  final FontWeight fontWeight;

  GeneralElevatedButton({
    Key? key,
    this.isSmallText = false,
    this.isMinimumWidth = false,
    this.hasLeading = false,
    required this.title,
    this.bgColor,
    this.fgColor,
    this.borderRadius,
    this.isDisabled = false,
    required this.onPressed,
    this.height,
    this.width,
    this.textStyle,
    this.elevation,
    this.loading = false,
    this.leadingPngPath,
    this.customBorderRadius,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (textStyle == null) {
      if (isSmallText) {
        textStyle = smallText.copyWith(
          color: fgColor ?? Colors.white,
          fontWeight: FontWeight.w600,
        );
      } else {
        textStyle = bodyText.copyWith(
          color: fgColor ?? Colors.white,
          fontWeight: fontWeight,
        );
      }
    }

    return SizedBox(
      height: height ?? 40,
      width:
          width ?? (isMinimumWidth ? null : MediaQuery.of(context).size.width),
      child: ElevatedButton(
        key: key,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation ?? 0),
          backgroundColor: MaterialStateProperty.all(
            isDisabled ? AppColors.disabledButton : bgColor ?? AppColors.blue,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: customBorderRadius ??
                  BorderRadius.circular(borderRadius ?? 100),
            ),
          ),
        ),
        onPressed: (isDisabled || loading) ? null : onPressed,
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : hasLeading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(leadingPngPath!),
                      Text(
                        title,
                        style: textStyle,
                      ),
                      const SizedBox(width: 20),
                    ],
                  )
                : Text(
                    title,
                    style: textStyle,
                  ),
      ),
    );
  }
}
