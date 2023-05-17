/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering

import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  static const AssetGenImage disneyPlus =
      AssetGenImage('assets/disney_plus.png');
  static const AssetGenImage mountainsAfternoon =
      AssetGenImage('assets/mountains_afternoon.png');
  static const AssetGenImage mountainsEvening =
      AssetGenImage('assets/mountains_evening.png');
  static const AssetGenImage mountainsMorning =
      AssetGenImage('assets/mountains_morning.png');
  static const AssetGenImage mountainsNight =
      AssetGenImage('assets/mountains_night.png');
  static const AssetGenImage mountainsNightFlash =
      AssetGenImage('assets/mountains_night_flash.png');
  static const AssetGenImage netflix = AssetGenImage('assets/netflix.png');
  static const AssetGenImage skyScrapperWindows =
      AssetGenImage('assets/sky_scrapper_windows.jpg');
  static const AssetGenImage spiderman = AssetGenImage('assets/spiderman.png');
  static const AssetGenImage stars = AssetGenImage('assets/stars.png');
  static const AssetGenImage watcha = AssetGenImage('assets/watcha.png');
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(super.assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
