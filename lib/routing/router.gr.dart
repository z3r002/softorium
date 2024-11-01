// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:softoriim/presenter/home/screens/home_screen.dart' as _i1;
import 'package:softoriim/presenter/mock/screens/mock_screen.dart' as _i2;
import 'package:softoriim/presenter/splash/screens/splash_screen.dart' as _i3;
import 'package:softoriim/shared/widgets/custom_navigation_bar.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    UIHomeScreenRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.UIHomeScreen(),
      );
    },
    UIMockScreenRoute.name: (routeData) {
      final args = routeData.argsAs<UIMockScreenRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.UIMockScreen(
          key: args.key,
          title: args.title,
        ),
      );
    },
    UISplashScreenRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.UISplashScreen(),
      );
    },
    UIBottomNavigationBarRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.UIBottomNavigationBar(),
      );
    },
  };
}

/// generated route for
/// [_i1.UIHomeScreen]
class UIHomeScreenRoute extends _i5.PageRouteInfo<void> {
  const UIHomeScreenRoute({List<_i5.PageRouteInfo>? children})
      : super(
          UIHomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UIHomeScreenRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.UIMockScreen]
class UIMockScreenRoute extends _i5.PageRouteInfo<UIMockScreenRouteArgs> {
  UIMockScreenRoute({
    _i6.Key? key,
    required String title,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          UIMockScreenRoute.name,
          args: UIMockScreenRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'UIMockScreenRoute';

  static const _i5.PageInfo<UIMockScreenRouteArgs> page =
      _i5.PageInfo<UIMockScreenRouteArgs>(name);
}

class UIMockScreenRouteArgs {
  const UIMockScreenRouteArgs({
    this.key,
    required this.title,
  });

  final _i6.Key? key;

  final String title;

  @override
  String toString() {
    return 'UIMockScreenRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [_i3.UISplashScreen]
class UISplashScreenRoute extends _i5.PageRouteInfo<void> {
  const UISplashScreenRoute({List<_i5.PageRouteInfo>? children})
      : super(
          UISplashScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UISplashScreenRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.UIBottomNavigationBar]
class UIBottomNavigationBarRoute extends _i5.PageRouteInfo<void> {
  const UIBottomNavigationBarRoute({List<_i5.PageRouteInfo>? children})
      : super(
          UIBottomNavigationBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'UIBottomNavigationBarRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
