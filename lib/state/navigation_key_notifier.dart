import 'package:cap_navigation_bar/views/navigation_bar_view.dart';
import 'package:flutter/material.dart' show ValueNotifier, GlobalKey;

class CapNavigationKeyNotifier
    extends ValueNotifier<GlobalKey<CapNavigationBarState>?> {
  CapNavigationKeyNotifier._sharedInstance()
      : super(GlobalKey<CapNavigationBarState>());
  static final CapNavigationKeyNotifier _shared =
      CapNavigationKeyNotifier._sharedInstance();
  factory CapNavigationKeyNotifier() => _shared;

  void navigateToPage(int pageIndex) {
    final navigationState = value!.currentState!;
    navigationState.setPage(pageIndex);
    notifyListeners();
  }
}
