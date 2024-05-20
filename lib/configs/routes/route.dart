import 'package:flutter/material.dart';
import 'package:test_app/configs/constants/constant.dart';
import 'package:test_app/pages/home_page.dart';
import 'package:test_app/pages/savedata_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _materialRoute(const HomePage());
      case savedRoute:
        return _materialRoute(const SavedPage());
      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
