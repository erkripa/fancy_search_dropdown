import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fancy_search_dropdown/fancy_search_dropdown.dart';
import 'fancy_search_dropdown_config.dart';

class FancySearchDropdownController extends ChangeNotifier {
  // Private static instance
  static FancySearchDropdownController? _instance;

  // Private constructor
  FancySearchDropdownController._({
    required this.context,
    required this.suggestions,
    this.onSelected,
    this.selectedValue,
    required this.maxHeight,
    this.config,
  }) {
    initialization();
  }

  // Factory constructor to return the singleton instance
  factory FancySearchDropdownController({
    required BuildContext context,
    required List<String> suggestions,
    required double maxSuggestionHeight,
    ValueChanged<String>? onSelected,
    String? selectedValue,
    FancySearchDropdownConfig? config,
    bool debugMode = true,
  }) {
    if (debugMode == false) {
      _instance ??= FancySearchDropdownController._(
        context: context,
        suggestions: suggestions,
        onSelected: onSelected,
        selectedValue: selectedValue,
        maxHeight: maxSuggestionHeight,
        config: config,
      );
    } else {
      _instance = FancySearchDropdownController._(
        context: context,
        suggestions: suggestions,
        onSelected: onSelected,
        selectedValue: selectedValue,
        maxHeight: maxSuggestionHeight,
        config: config,
      );
    }
    return _instance!;
  }

  final BuildContext context;
  final List<String> suggestions;
  final ValueChanged<String>? onSelected;
  String? selectedValue;

  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _filteredSuggestions = [];
  double maxHeight;
  FancySearchDropdownConfig? config;
  // Getters
  LayerLink get layerLink => _layerLink;
  TextEditingController get controller => _controller;
  FocusNode get focusNode => _focusNode;
  List<String> get filteredSuggestions => _filteredSuggestions;
  bool get hasFocus => _focusNode.hasFocus;

  void initialization() {
    log("$runtimeType created");
    if (selectedValue != null) {
      controller.text = selectedValue!;
    }
    _focusNode.addListener(_focusListener);
    _controller.addListener(_onTextChanged);
  }

  void _focusListener() {
    if (_focusNode.hasFocus) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
    notifyListeners();
  }

  void _onTextChanged() {
    final query = _controller.text.toLowerCase();
    if (query != selectedValue?.toLowerCase()) {
      selectedValue = null;
    }
    _filteredSuggestions = suggestions.where((suggestion) => suggestion.toLowerCase().contains(query)).toList();
    notifyListeners();
    _updateOverlay();
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final borderRadius = BorderRadius.circular(config?.borderRadius ?? 8);
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: config?.optionBoxElevation ?? 3.0,
            color: Theme.of(context).cardColor,
            shape: config?.shape ?? RoundedRectangleBorder(borderRadius: borderRadius),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: Scrollbar(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: _filteredSuggestions.length,
                  itemBuilder: (context, int index) {
                    final suggestion = _filteredSuggestions[index];
                    if (config?.tileBuilder != null) {
                      return InkWell(
                        onTap: () => _onTileTap(suggestion),
                        child: config?.tileBuilder!(context, index, suggestion),
                      );
                    }
                    return config?.tileBuilder != null
                        ? InkWell(
                            onTap: () => _onTileTap(suggestion),
                          )
                        : _builTile(suggestion, config);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _builTile(String suggestion, FancySearchDropdownConfig? config) {
    final isSelected = suggestion == selectedValue;
    final theme = Theme.of(context);
    return ListTile(
      selectedTileColor: isSelected ? theme.primaryColor.withOpacity(0.1) : null,
      selected: isSelected,
      title: Text(
        suggestion,
        style: config?.optionTextStyle ?? TextStyle(color: theme.textTheme.bodyMedium?.color),
      ),
      onTap: () => _onTileTap(suggestion),
    );
  }

  void _onTileTap(String suggestion) {
    onSelected?.call(suggestion);
    _controller.text = suggestion;
    selectedValue = suggestion;
    _focusNode.unfocus();
    _removeOverlay();
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void onSuffixTap() {
    if (hasFocus) {
      _focusNode.unfocus();
      notifyListeners();
    } else {
      _focusNode.requestFocus();
      notifyListeners();
    }
  }
}
