import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:softoriim/presenter/home/store/home_store.dart';
import 'package:softoriim/presenter/home/widgets/app_bar_widget.dart';
import 'package:softoriim/presenter/home/widgets/calendar_widget.dart';
import 'package:softoriim/presenter/home/widgets/task_list_widget.dart';
import 'package:softoriim/shared/consts/colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

@RoutePage()
class UIHomeScreen extends StatefulWidget {
  const UIHomeScreen({super.key});

  @override
  State<UIHomeScreen> createState() => _UIHomeScreenState();
}

class _UIHomeScreenState extends State<UIHomeScreen> {
  final HomeStore homeStore = GetIt.I.get<HomeStore>();
  TextEditingController newTaskController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();


  @override
  void initState() {
    homeStore.loadTasks();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollToTextField();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    newTaskController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToTextField() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _unfocusAndSubmit() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
      final value = newTaskController.text;
      if (value.isNotEmpty) {
        homeStore.addTask(value);
        newTaskController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => GestureDetector(
          onTap: _unfocusAndSubmit,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [UIColors.cF9F3FC, UIColors.cFAF1E7],
              ),
            ),
            child: Column(
              children: [
                const UIAppBarWidget(),
                Expanded(
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 9,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            UICalendarWidget(homeStore: homeStore),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'the_plan_for_the_day'.tr(namedArgs: {
                                  'day': homeStore.selectedDate.day.toString(),
                                  'month': homeStore.selectedDate.month.toString(),
                                  'year': homeStore.selectedDate.year.toString(),
                                }),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            UITaskListWidget(
                              homeStore: homeStore,
                              focusNode: _focusNode,
                              newTaskController: newTaskController,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
