import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:npstock/styles/app_colors.dart';

class DisabledSlider extends StatelessWidget {
  final double sliderValue;

  const DisabledSlider({super.key, required this.sliderValue});

  @override
  Widget build(BuildContext context) {
    return FlutterSlider(
      selectByTap: false,
      values: [sliderValue],
      max: 1,
      min: 0,
      tooltip: null,
      handler: FlutterSliderHandler(
          disabled: true,
          decoration: BoxDecoration(
              color: AppColors.sliderThumb,
              borderRadius: BorderRadius.circular(20)),
          child: const SizedBox.shrink()),
      handlerHeight: 20,
      handlerWidth: 20,
      trackBar: const FlutterSliderTrackBar(
        activeDisabledTrackBarColor: AppColors.sliderTrack,
        inactiveDisabledTrackBarColor: AppColors.sliderTrack,
        inactiveTrackBarHeight: 2,
        activeTrackBarHeight: 2,
      ),
      disabled: true,
    );
  }
}
