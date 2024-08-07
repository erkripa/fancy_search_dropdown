import 'package:flutter/material.dart';

class FancyBuilder<T> extends InheritedWidget {
  final T controller;
  final Widget Function(BuildContext context, T controller) builder;

  FancyBuilder({
    required this.controller,
    required this.builder,
    super.key,
  }) : super(child: _FancyBuilderChild(builder: builder, controller: controller));

  @override
  bool updateShouldNotify(covariant FancyBuilder oldWidget) {
    return true;
  }
}

class _FancyBuilderChild<T> extends StatelessWidget {
  final T controller;
  final Widget Function(BuildContext context, T controller) builder;

  const _FancyBuilderChild({required this.controller, required this.builder});

  @override
  Widget build(BuildContext context) {
    final controll = controller as ChangeNotifier;
    controll.addListener(() => (context as Element).markNeedsBuild());
    return builder(context, controller);
  }
}
