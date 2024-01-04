import 'package:flutter/material.dart';
import 'package:safecty/feature/home/home_screen.dart';
import 'package:safecty/feature/inspection_check/inspection_check_screen.dart';
import 'package:safecty/feature/inspection_image/inspection_image_screen.dart';
import 'package:safecty/feature/inspection_person/inspection_person_screen.dart';
import 'package:safecty/feature/inspection_plan/inspection_plan_screen.dart';
import 'package:safecty/feature/login/login_screen.dart';
import 'package:safecty/feature/profile/profile_screen.dart';
import 'package:safecty/feature/splash/splash_screen.dart';
import 'package:safecty/feature/work_center/work_center_screen.dart';
import 'named_route.dart';
import 'slide_page_route.dart';

RouteFactory get generatedRoutes => (RouteSettings routeSettings) {
      ModalRoute<dynamic>? route;
      final Map<String, dynamic>? argumentsMap =
          routeSettings.arguments as Map<String, dynamic>?;
      Slide slide = Slide.left;

      switch (routeSettings.name) {
        case NamedRoute.inspectionPlanScreen:
          route = SlidePageRoute(
            offset: slide.slideSide,
            page: const InspectionPlanScreen(),
            routeName: routeSettings.name,
          );
          break;
        case NamedRoute.inspectionCheckScreen:
          route = SlidePageRoute(
            offset: slide.slideSide,
            page: const InspectionCheckScreen(),
            routeName: routeSettings.name,
          );
          break;
        case NamedRoute.inspectionImageScreen:
          route = SlidePageRoute(
            offset: slide.slideSide,
            page: const InspectionImageScreen(),
            routeName: routeSettings.name,
          );
          break;
        case NamedRoute.inspectionPersonScreen:
          route = SlidePageRoute(
            offset: slide.slideSide,
            page: const InspectionPersonScreen(),
            routeName: routeSettings.name,
          );
          break;
        case NamedRoute.profileScreen:
          route = SlidePageRoute(
            offset: slide.slideSide,
            page: const ProfileScreen(),
            routeName: routeSettings.name,
          );
          break;
        case NamedRoute.homeScreen:
          route = SlidePageRoute(
            offset: slide.slideSide,
            page: const HomeScreen(),
            routeName: routeSettings.name,
          );
          break;
        case NamedRoute.loginScreen:
          route = SlidePageRoute(
            offset: slide.slideSide,
            page: const LoginScreen(),
            routeName: routeSettings.name,
          );
          break;
        case NamedRoute.workCenterScreen:
          route = SlidePageRoute(
            offset: slide.slideSide,
            page: WorkCenterScreen(
              identificationCard:
                  argumentsMap!["identificationCard"].toString(),
            ),
            routeName: routeSettings.name,
          );
          break;
        default:
          route = MaterialPageRoute<dynamic>(
            builder: (_) => const SplashScreen(),
            settings: RouteSettings(
              name: routeSettings.name,
            ),
          );
          break;
      }
      return route;
    };
