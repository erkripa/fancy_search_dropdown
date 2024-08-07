import 'package:flutter/material.dart';

typedef FancyWidgetBuilder = Widget? Function(BuildContext context, int index, String? suggestion);

class FancySearchDropdownConfig {
  final double maxSuggestionHeight;
  final ShapeBorder? shape;
  final InputDecoration? inputDecoration;
  final Widget? inActiveSuffix;
  final Widget? activeSuffix;
  final Widget? activeLeading;
  final Widget? inActiveLeading;
  final TextStyle? optionTextStyle;
  final TextStyle? labelTextStyle;
  final double borderRadius;
  final double? optionBoxElevation;
  final FancyWidgetBuilder? tileBuilder;

  FancySearchDropdownConfig({
    this.maxSuggestionHeight = 300,
    this.borderRadius = 8,
    this.shape,
    this.inputDecoration,
    this.inActiveSuffix,
    this.activeSuffix,
    this.activeLeading,
    this.inActiveLeading,
    this.optionTextStyle,
    this.labelTextStyle,
    this.tileBuilder,
    this.optionBoxElevation,
  });
}
