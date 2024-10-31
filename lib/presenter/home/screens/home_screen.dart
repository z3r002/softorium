import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:softoriim/presenter/home/store/home_store.dart';
import 'package:softoriim/shared/consts/assets.dart';
import 'package:softoriim/shared/consts/colors.dart';

@RoutePage()
class UIHomeScreen extends StatefulWidget {
  const UIHomeScreen({super.key});

  @override
  State<UIHomeScreen> createState() => _UIHomeScreenState();
}

class _UIHomeScreenState extends State<UIHomeScreen> {
  final HomeStore homeStore = GetIt.I.get<HomeStore>();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
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
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              excludeHeaderSemantics: true,
              title: Text(
                'Привет, Джамшутушка',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              actions: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      'https://media.istockphoto.com/id/1392783238/ru/%D1%84%D0%BE%D1%82%D0%BE/%D0%BF%D0%BE%D1%80%D1%82%D1%80%D0%B5%D1%82-%D1%83%D0%BB%D1%8B%D0%B1%D0%B0%D1%8E%D1%89%D0%B5%D0%B9%D1%81%D1%8F-%D0%B6%D0%B5%D0%BD%D1%89%D0%B8%D0%BD%D1%8B-%D0%BF%D0%BE%D0%B4%D1%80%D0%BE%D1%81%D1%82%D0%BA%D0%B0-%D1%81%D0%BC%D0%BE%D1%82%D1%80%D1%8F%D1%89%D0%B5%D0%B9-%D0%B2-%D0%BA%D0%B0%D0%BC%D0%B5%D1%80%D1%83-%D0%BD%D0%B0-%D1%81%D0%B8%D0%BD%D0%B5%D0%BC-%D1%84%D0%BE%D0%BD%D0%B5.jpg?s=612x612&w=0&k=20&c=lKnj0o2PabShTGJuiDJFlXHpK4t8PM018fd5kvVIFps='),
                ),
              ],
            ),
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
                  Container(
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
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
                          },
                          child: Container(
                            height: 30,
                            width: 40,
                            // Reduced width for compact appearance
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? UIColors.cBEB7EB : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (isToday)
                                    Positioned(
                                      top: 0,
                                      child: Icon(
                                        Icons.circle,
                                        size: 6,
                                        color: UIColors.cD9D9D9, // Цвет точки
                                      ),
                                    ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${date.day}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: isSelected
                                              ?  FontWeight.normal
                                              :FontWeight.bold,
                                          color: isSelected
                                              ? UIColors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        _getDayOfWeek(date),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isSelected
                                              ? UIColors.white
                                              : Colors.black54,
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'План на день ${homeStore.selectedDate.day}.${homeStore.selectedDate.month}.${homeStore.selectedDate.year}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      _buildTaskItem('Задача 1', isCompleted: true),
                      _buildTaskItem('Задача 2'),
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayOfWeek(DateTime date) {
    const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return days[date.weekday - 1];
  }

  Widget _buildTaskItem(String title,
      {bool isCompleted = false,
      bool isDeletable = false,
      bool isItalic = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 12,
                color: isCompleted ? Colors.grey : Colors.purple,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isCompleted ? Colors.grey : Colors.black,
                ),
              ),
            ],
          ),
          if (isDeletable)
            Text(
              'Удалить',
              style: TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.underline,
              ),
            ),
        ],
      ),
    );
  }
}
