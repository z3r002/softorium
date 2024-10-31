import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:softoriim/presenter/home/store/home_store.dart';
import 'package:softoriim/shared/consts/colors.dart';

class UITaskListWidget extends StatelessWidget {
   UITaskListWidget({super.key, required this.homeStore});
  final HomeStore homeStore;
  final TextEditingController newTaskController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Observer(
      builder:(_)=>  ListView.builder(
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
      ),
    );
  }
}
