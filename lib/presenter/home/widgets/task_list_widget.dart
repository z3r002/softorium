import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:softoriim/presenter/home/store/home_store.dart';
import 'package:softoriim/shared/consts/colors.dart';

class UITaskListWidget extends StatefulWidget {
  UITaskListWidget(
      {super.key,
      required this.homeStore,
      required this.focusNode,
      required this.newTaskController});

  final FocusNode focusNode;
  final HomeStore homeStore;
  final TextEditingController newTaskController;

  @override
  State<UITaskListWidget> createState() => _UITaskListWidgetState();
}

class _UITaskListWidgetState extends State<UITaskListWidget> {


  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.homeStore.filteredTasks.length + 1,
        itemBuilder: (context, index) {
          if (index == widget.homeStore.filteredTasks.length) {
            return ListTile(
              leading: Icon(Icons.circle, color: UIColors.cEDEBF9),
              title: TextField(
                controller: widget.newTaskController,
                focusNode: widget.focusNode,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: 'Новая задача',
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    widget.homeStore.addTask(value);
                    widget.newTaskController.clear();
                  }
                },
              ),
            );
          } else {
            final task = widget.homeStore.filteredTasks[index];
            final isSelected = widget.homeStore.selectedTaskIndex == index;

            return GestureDetector(
              onTap: () {
                  widget.homeStore.selectedTaskIndex =
                  isSelected ? null : index;
                  widget.homeStore.tasks = [...widget.homeStore.tasks];
              },
              onLongPress: () => widget.homeStore.toggleTaskCompletion(index),
              child: AnimatedContainer(
                curve: Curves.easeInOutCirc,
                duration: Duration(milliseconds: 600),
                color: isSelected ? UIColors.cEDEBF9 : Colors.transparent,
                child: ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: task.isCompleted ? UIColors.cCECECE : UIColors.cEDEBF9,
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isCompleted ? Colors.grey : Colors.black,
                      fontWeight: task.isCompleted
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  trailing: isSelected
                      ? GestureDetector(
                    onTap: () {
                      widget.homeStore.removeTask(index);
                      widget.homeStore.selectedTaskIndex = null;
                    },
                    child: Text(
                      'Удалить',
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : null,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
