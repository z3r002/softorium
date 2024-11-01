import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:softoriim/routing/router.gr.dart';
import 'package:softoriim/shared/consts/assets.dart';
import 'package:softoriim/shared/consts/colors.dart';

@RoutePage()
class UIBottomNavigationBar extends StatefulWidget {
  const UIBottomNavigationBar({super.key});

  @override
  State<UIBottomNavigationBar> createState() => _UIBottomNavigationBarState();
}

class _UIBottomNavigationBarState extends State<UIBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        UIHomeScreenRoute(),
       UIMockScreenRoute(title: 'Документы'),
       UIMockScreenRoute(title: 'Аналитика'),
       UIMockScreenRoute(title: 'Настройки'),
       UIMockScreenRoute(title: 'Профиль'),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final pageController = PageController(initialPage: tabsRouter.activeIndex);

        tabsRouter.addListener(() {
          if (pageController.hasClients &&
              tabsRouter.activeIndex != pageController.page?.round()) {
            pageController.jumpToPage(tabsRouter.activeIndex);
          }
        });

        return WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return false;
          },
          child:  Scaffold(
            extendBody: true, // Распространит градиент под навигационную панель
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    UIColors.cF9F3FC,
                    UIColors.cFAF1E7,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  tabsRouter.setActiveIndex(index);
                },
                children: tabsRouter.stack.map((page) => page.child).toList(),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    type: BottomNavigationBarType.fixed,
                    items: [
                      UIItemBar(Assets.home),
                      UIItemBar(Assets.cards),
                      UIItemBar(Assets.chart),
                      UIItemBar(Assets.notification),
                      UIItemBar(Assets.notification),
                    ],
                    currentIndex: tabsRouter.activeIndex,
                    selectedItemColor: Colors.purple,
                    unselectedItemColor: Colors.black54,
                    onTap: (index) {
                      tabsRouter.setActiveIndex(index);
                      pageController.jumpToPage(index);
                    },
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    enableFeedback: false,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem UIItemBar(String icon) {
    return BottomNavigationBarItem(

      label: '',
      activeIcon: Container(
        padding: EdgeInsets.all(15),
        child: SvgPicture.asset(icon, width: 24),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: UIColors.cBEB7EB,
        ),
      ),
      icon: Container(
        padding: EdgeInsets.all(15),
        child: SvgPicture.asset(icon, width: 24),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: UIColors.cF4F4F5,
        ),
      ),
    );
  }

}
