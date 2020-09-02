import 'package:flutter/material.dart';

class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function function;

  CustomPopupMenuItem({@required this.child, @required this.function});

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() =>
      CustomPopupMenuItemState();
}

class CustomPopupMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, CustomPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.function();
  }
}
