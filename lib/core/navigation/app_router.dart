import 'package:flutter/material.dart';
import 'package:safecty/feature/home/home_screen.dart';
import 'named_route.dart';
import 'slide_page_route.dart';

RouteFactory get generatedRoutes => (RouteSettings routeSettings) {
      ModalRoute<dynamic>? route;
      final Map<String, dynamic>? argumentsMap =
          routeSettings.arguments as Map<String, dynamic>?;
      Slide slide = Slide.left;

      switch (routeSettings.name) {
        case NamedRoute.homeScreen:
          route = SlidePageRoute(
            offset: slide.slideSide,
            page: HomeScreen(title: argumentsMap!['time'].toString()),
            routeName: routeSettings.name,
          );
          break;
        default:
          route = MaterialPageRoute<dynamic>(
            builder: (_) => HomeScreen(
                title: argumentsMap?['time'].toString() ?? "Initial default"),
            settings: RouteSettings(
              name: routeSettings.name,
            ),
          );
          break;
      }
      return route;
    };
