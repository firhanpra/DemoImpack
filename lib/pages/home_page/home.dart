import 'package:demo_impack_pratama/constant.dart';
import 'package:demo_impack_pratama/pages/activity_info/activity_info.dart';
import 'package:demo_impack_pratama/pages/form_activity/form_activity.dart';
import 'package:demo_impack_pratama/pages/home_page/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  var controller = Get.put(HomeController());

  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
              title: Center(child: Text(controller.homeTitle.value)),
              backgroundColor: mainColor,
              elevation: 0),
          body: controller.selectedNavbar.value == 0
              ? const Center(child: Text('Coming Soon'))
              : controller.selectedNavbar.value == 1
                  ? controller.loading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            secondColor, //<-- SEE HERE
                          ),
                        ))
                      : Column(
                          children: [
                            Container(
                              height: 70,
                              color: mainColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.boolComplete.value = false;
                                    },
                                    child: Container(
                                      height: 40,
                                      width: Get.width * 0.42,
                                      child: Center(
                                          child: Text(
                                        'Open',
                                        style: TextStyle(
                                            color: controller.boolComplete.value
                                                ? Colors.white
                                                : mainColor,
                                            fontWeight: FontWeight.w600),
                                      )),
                                      decoration: BoxDecoration(
                                          color: controller.boolComplete.value
                                              ? mainColor
                                              : Colors.white,
                                          border: Border.all(
                                              width: 1, color: Colors.white),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50))),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.boolComplete.value = true;
                                    },
                                    child: Container(
                                      height: 40,
                                      width: Get.width * 0.42,
                                      child: Center(
                                          child: Text(
                                        'Complete',
                                        style: TextStyle(
                                            color: controller.boolComplete.value
                                                ? mainColor
                                                : Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )),
                                      decoration: BoxDecoration(
                                          color: controller.boolComplete.value
                                              ? Colors.white
                                              : mainColor,
                                          border: Border.all(
                                              width: 1, color: Colors.white),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50))),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: ListView.builder(
                                    itemCount: controller.listActivity.length,
                                    itemBuilder: (_, index) {
                                      //check same date
                                      bool isSameDate = true;
                                      final String dateString = controller
                                          .listActivity[index].when
                                          .toString();
                                      final DateTime date =
                                          DateTime.parse(dateString);
                                      if (index == 0) {
                                        isSameDate = false;
                                      } else {
                                        final String prevDateString = controller
                                            .listActivity[index - 1].when
                                            .toString();
                                        final DateTime prevDate =
                                            DateTime.parse(prevDateString);

                                        isSameDate = date.isSameDate(prevDate);
                                      }

                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (index == 0 || !(isSameDate))
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(
                                                    DateFormat(
                                                            'EEEE, dd MMMM yyyy')
                                                        .format(date),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                        DateFormat('HH:mm')
                                                            .format(controller
                                                                .listActivity[
                                                                    index]
                                                                .when!),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Get.to(() => ActivityInfo(
                                                                id: controller
                                                                    .listActivity[
                                                                        index]
                                                                    .id!,
                                                              ))!
                                                          .then((_) => controller
                                                              .getActivity());
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Text(
                                                          '${controller.listActivity[index].activityType} with ${controller.listActivity[index].institution}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                secondColor)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        )
                  : controller.selectedNavbar.value == 2
                      ? const Center(child: Text('Coming Soon'))
                      : const Center(child: Text('Coming Soon')),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'My Activitiy',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'My Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedNavbar.value,
            backgroundColor: mainColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white38,
            showUnselectedLabels: true,
            onTap: controller.changeSelectedNavBar,
          ),
          floatingActionButton: Visibility(
            visible: controller.showFab.value,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              backgroundColor: mainColor,
              onPressed: () {
                Get.to(() => FormActivity())!
                    .then((_) => controller.getActivity());
              },
            ),
          )),
    );
  }
}

extension DateHelper on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
