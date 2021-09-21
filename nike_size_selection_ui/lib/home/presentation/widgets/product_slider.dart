import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductSlider extends StatelessWidget {
  const ProductSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.divisions,
    required this.sliderValue,
    required this.sliderSteps,
    this.onValueChanged,
  }) : super(key: key);

  final double min;
  final double max;
  final int divisions;
  final double sliderValue;
  final List<double> sliderSteps;
  final Function(double)? onValueChanged;

  TextStyle _getSliderStyle(bool isSelected) {
    if (isSelected) {
      return const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
    } else {
      return const TextStyle(
        fontSize: 16,
        color: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 325,
          child: SliderTheme(
            data: const SliderThemeData(
              showValueIndicator: ShowValueIndicator.always,
              activeTrackColor: Color(0xFF484848),
              inactiveTrackColor: Color(0xFF484848),
              activeTickMarkColor: Color(0xFF484848),
              inactiveTickMarkColor: Color(0xFF484848),
              valueIndicatorColor: Color(0xFF484848),
              thumbColor: Color(0xFFFF2D4C),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 8),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
            ),
            child: Slider(
              value: sliderValue <= 0 ? min : sliderValue,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: (value) => onValueChanged!(value),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: sliderSteps.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 40,
                width: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedDefaultTextStyle(
                      child: Text(
                        sliderSteps[index].toString(),
                      ),
                      style: _getSliderStyle(
                        sliderSteps[index] == sliderValue,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: const Duration(milliseconds: 100),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
