import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:softoriim/presenter/home/store/home_store.dart';
import 'package:softoriim/shared/consts/colors.dart';

class UICalendarWidget extends StatelessWidget {
  const UICalendarWidget({super.key, required this.homeStore});
  final HomeStore homeStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder:(_)=> Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(
            color: UIColors.cEDEBF9,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeStore.endDate.difference(homeStore.startDate).inDays + 1,
          itemBuilder: (context, index) {
            final date = homeStore.startDate.add(Duration(days: index));
            final isSelected = date.day == homeStore.selectedDate.day &&
                date.month == homeStore.selectedDate.month &&
                date.year == homeStore.selectedDate.year;
            final isToday = date.day == DateTime.now().day &&
                date.month == DateTime.now().month &&
                date.year == DateTime.now().year;

            return GestureDetector(
              onTap: () {
                  homeStore.selectedDate = date;
                  homeStore.tasks = [...homeStore.tasks];
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: isSelected ? 40 : 30,
                width: isSelected ? 50 : 40,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? UIColors.cBEB7EB : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ]
                      : [],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (isToday)
                        const Positioned(
                          top: 0,
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: UIColors.cD9D9D9,
                          ),
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            '${date.day}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isSelected ? FontWeight.normal : FontWeight.bold,
                              color: isSelected ? UIColors.white : Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            homeStore.getDayOfWeek(date),
                            style: TextStyle(
                              fontSize: 13,
                              color: isSelected ? UIColors.white : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
