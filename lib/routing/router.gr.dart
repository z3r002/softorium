// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:softoriim/presenter/home/screens/home_screen.dart' as _i1;
import 'package:softoriim/presenter/splash/screens/splash_screen.dart' as _i2;
import 'package:softoriim/shared/widgets/custom_navigation_bar.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    UIHomeScreenRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.UIHomeScreen(),
      );
    },
    UISplashScreenRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.UISplashScreen(),
      );
    },
    UIBottomNavigationBarRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.UIBottomNavigationBar(),
      );
    },
  };
}

/// generated route for
/// [_i1.UIHomeScreen]
class UIHomeScreenRoute extends _i4.PageRouteInfo<void> {
  const UIHomeScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(
          UIHomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UIHomeScreenRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.UISplashScreen]
class UISplashScreenRoute extends _i4.PageRouteInfo<void> {
  const UISplashScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(
          UISplashScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'UISplashScreenRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.UIBottomNavigationBar]
class UIBottomNavigationBarRoute extends _i4.PageRouteInfo<void> {
  const UIBottomNavigationBarRoute({List<_i4.PageRouteInfo>? children})
      : super(
          UIBottomNavigationBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'UIBottomNavigationBarRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
