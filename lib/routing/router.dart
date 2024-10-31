import 'package:auto_route/auto_route.dart';


import 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: "",
)
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
            transitionsBuilder: TransitionsBuilders.noTransition,
            page: UISplashScreenRoute.page,
            initial: true),

        AutoRoute(page: UIBottomNavigationBarRoute.page, children: [
          AutoRoute(
            page: UIHomeScreenRoute.page,
            initial: false,
          ),
          AutoRoute(
            page: UIMockScreenRoute.page,
            initial: false,
          ),
        ]),
      ];
}
