import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:softoriim/presenter/home/store/home_store.dart';
import 'package:softoriim/presenter/home/widgets/app_bar_widget.dart';
import 'package:softoriim/presenter/home/widgets/calendar_widget.dart';
import 'package:softoriim/shared/consts/assets.dart';
import 'package:softoriim/shared/consts/colors.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


//https://media.istockphoto.com/id/1392783238/ru/%D1%84%D0%BE%D1%82%D0%BE/%D0%BF%D0%BE%D1%80%D1%82%D1%80%D0%B5%D1%82-%D1%83%D0%BB%D1%8B%D0%B1%D0%B0%D1%8E%D1%89%D0%B5%D0%B9%D1%81%D1%8F-%D0%B6%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D1%8B-%D0%BF%D0%BE%D0%B4%D1%80%D0%BE%D1%81%D1%82%D0%BA%D0%B0-%D1%81%D0%BC%D0%BE%D1%82%D1%80%D1%8F%D1%89%D0%B5%D0%B9-%D0%B2-%D0%BA%D0%B0%D0%BC%D0%B5%D1%80%D1%83-%D0%BD%D0%B0-%D1%81%D0%B8%D0%BD%D0%B5%D0%BC-%D1%84%D0%BE%D0%BD%D0%B5.jpg?s=612x612&w=0&k=20&c=lKnj0o2PabShTGJuiDJFlXHpK4t8PM018fd5kvVIFps=

@RoutePage()
class UIHomeScreen extends StatefulWidget {
  const UIHomeScreen({super.key});

  @override
  State<UIHomeScreen> createState() => _UIHomeScreenState();
}

class _UIHomeScreenState extends State<UIHomeScreen> {
  final HomeStore homeStore = GetIt.I.get<HomeStore>();
  TextEditingController newTaskController = TextEditingController();

  @override
  void initState() {
    homeStore.loadTasks();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => Container(
      padding: EdgeInsets.only(left: 18, right: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            UIColors.cF9F3FC,
            UIColors.cFAF1E7,
          ],
        ),
      ),
      child: Column(
        children: [
          UIAppBarWidget(),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UICalendarWidget(homeStore: homeStore,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'План на день ${homeStore.selectedDate.day}.${homeStore.selectedDate.month}.${homeStore.selectedDate.year}',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  itemCount: homeStore.filteredTasks.length + 1, // Используем filteredTasks
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == homeStore.filteredTasks.length) {
                      // Поле для добавления новой задачи
                      return ListTile(
                        leading: Icon(Icons.circle, color:  UIColors.cEDEBF9,),

                        title: TextField(
                          controller: newTaskController,
                          maxLength: 20,
                          decoration: InputDecoration(
                            hintText: 'Новая задача',
                          ),
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              homeStore.addTask(value);
                              newTaskController.clear();
                            }
                          },
                        ),
                      );
                    } else if (homeStore.filteredTasks.isNotEmpty) {
                      // Проверка, что список не пустой
                      final task = homeStore.filteredTasks[index];
                      return GestureDetector(
                        onTap: () {
                          homeStore.selectedTaskIndex = (homeStore.selectedTaskIndex == index) ? null : index;
                          homeStore.tasks = [...homeStore.tasks];
                        },
                        onLongPress: () => homeStore.toggleTaskCompletion(index),
                        child: Container(
                          color: homeStore.selectedTaskIndex == index ? UIColors.cEDEBF9 : null,
                          child: ListTile(


                            leading: Icon(Icons.circle, color: task.isCompleted ?  UIColors.cCECECE: UIColors.cEDEBF9,),
                            title: Text(
                              task.title,
                              style: TextStyle(
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: task.isCompleted ? Colors.grey : Colors.black,
                                fontWeight: task.isCompleted ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                            trailing: homeStore.selectedTaskIndex == index
                                ? GestureDetector(
                                onTap: () {
                                  homeStore.removeTask(index);
                                  homeStore.selectedTaskIndex = null;
                                },
                                child: Text('Удалить', style: TextStyle(fontSize: 14, decoration: TextDecoration.underline, fontWeight: FontWeight.bold),))
                                : null,
                          ),
                        ),
                      );
                    } else {
                      // Если нет задач в filteredTasks
                      return SizedBox.shrink();
                    }
                  },
                )


              ],
            ),
          ),
        ],
      ),
    ),
    ),);
  }
}
