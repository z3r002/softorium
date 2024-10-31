import 'package:flutter/material.dart';

class UIAppBarWidget extends StatelessWidget {
  const UIAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      excludeHeaderSemantics: true,
      title: Text(
        'Привет, John Doe',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      actions: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(''),
        ),
      ],
    );
  }
}
