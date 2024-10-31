import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:softoriim/routing/router.gr.dart';
import 'package:softoriim/shared/consts/colors.dart';
import 'package:softoriim/shared/consts/global.dart';

@RoutePage()
class UISplashScreen extends StatefulWidget {
  const UISplashScreen({Key? key}) : super(key: key);

  @override
  State<UISplashScreen> createState() => _UISplashScreenState();
}

class _UISplashScreenState extends State<UISplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: UIColors.white,
    );
  }

  init() {
    appRouter.replace(const UIHomeScreenRoute());
  }
}
