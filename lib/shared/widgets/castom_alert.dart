import 'package:flutter/material.dart';
import 'package:softoriim/shared/consts/global.dart';


class UICustomAlert extends StatelessWidget {
  const UICustomAlert({super.key,  this.text, this.isError = true});
  final String? text;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isError?'Ошибка!':'Успешно!'),
      content: Text(
          isError ? 'Что-то пошло не так, попробуйте еще раз' : text!),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(
                  appRouter.navigatorKey.currentState!.context)
                  .pop();
            },
            child: Text('ОК'))
      ],
    );
  }
}