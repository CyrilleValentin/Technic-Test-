import 'package:flutter/material.dart';
import 'package:test_app/configs/constants/constant.dart';
import 'package:test_app/pages/homePage.dart';
import 'package:test_app/pages/saveDataPage.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _materialRoute(const HomePage());
       case savedRoute:
         return _materialRoute( const SavedPage());
      // case registerRoute:
      //   return _materialRoute( const RegisterPage());

      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}