import 'package:flutter/material.dart';
import 'package:softoriim/shared/consts/assets.dart';

class UIAppBarWidget extends StatelessWidget {
  const UIAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      excludeHeaderSemantics: true,
      title: const Text(
        'Привет, John Doe',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      actions: [
        Container(
          width: 50,
          height: 50,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(Assets.woman),
        )
      ],
    );
  }
}
