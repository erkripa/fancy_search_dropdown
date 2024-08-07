import 'package:flutter/material.dart';
import 'package:fancy_search_dropdown/src/fancy_builder.dart';
import 'package:fancy_search_dropdown/src/fancy_search_dropdown_controller.dart';
import 'fancy_search_dropdown_config.dart';

class FancySearchDropdown extends StatelessWidget {
  const FancySearchDropdown({
    super.key,
    this.onSelected,
    this.labelText,
    this.suggestions = const [],
    this.selectedValue,
    this.maxSuggestionHeight = 300,
    this.config,
    this.debugMode = true, // in production make false
  });

  final List<String> suggestions;
  final ValueChanged<String>? onSelected;
  final String? labelText;
  final String? selectedValue;
  final double maxSuggestionHeight;
  final FancySearchDropdownConfig? config;
  final bool debugMode;

  @override
  Widget build(BuildContext context) {
    return FancyBuilder<FancySearchDropdownController>(
      controller: FancySearchDropdownController(
        context: context,
        suggestions: suggestions,
        onSelected: onSelected,
        selectedValue: selectedValue,
        maxSuggestionHeight: maxSuggestionHeight,
        config: config,
        debugMode: debugMode,
      ),
      builder: (context, controller) {
        final config = controller.config;
        return CompositedTransformTarget(
          link: controller.layerLink,
          child: TextField(
            controller: controller.controller,
            focusNode: controller.focusNode,
            decoration: getDecoration(config, controller),
          ),
        );
      },
    );
  }

  InputDecoration getDecoration(FancySearchDropdownConfig? config, FancySearchDropdownController controller) {
    return config?.inputDecoration?.copyWith(
          labelText: labelText,
          floatingLabelStyle: config.labelTextStyle,
          prefixIcon: _buildPrefix(controller.hasFocus, config),
          suffixIcon: _getSuffix(controller, config),
        ) ??
        InputDecoration(
          floatingLabelStyle: config?.labelTextStyle,
          labelText: labelText,
          prefixIcon: _buildPrefix(controller.hasFocus, config),
          suffixIcon: _getSuffix(controller, config),
        );
  }

  Widget _getSuffix(
    FancySearchDropdownController controller,
    FancySearchDropdownConfig? config,
  ) {
    return _buildSuffix(
      controller.hasFocus,
      () => controller.onSuffixTap(),
      config,
    );
  }

  Widget _buildSuffix(
    bool hasFocus,
    VoidCallback onTap,
    FancySearchDropdownConfig? config,
  ) {
    return InkWell(
      onTap: onTap,
      child: config?.inActiveSuffix != null
          ? (hasFocus ? config?.activeSuffix : config?.inActiveSuffix)
          : Icon(
              hasFocus ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down,
            ),
    );
  }

  Widget? _buildPrefix(bool hasFocus, FancySearchDropdownConfig? config) {
    if (config?.inActiveLeading != null) {
      return (hasFocus ? config?.activeLeading : config?.inActiveLeading);
    } else {
      return null;
    }
  }
}
