import 'package:demo_impack_pratama/constant.dart';
import 'package:demo_impack_pratama/pages/form_activity/form_activity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class FormActivity extends StatelessWidget {
  final String? id;
  final String? activityType;
  final String? institution;
  final String? date;
  final String? objective;
  final String? remarks;
  var controller = Get.put(FormActivityController());

  FormActivity(
      {Key? key,
      this.id,
      this.activityType,
      this.institution,
      this.date,
      this.objective,
      this.remarks})
      : super(key: key);

  void addData() {
    controller.activityType.value = activityType!;
    controller.institution.text = institution!;
    controller.dateValue.value = date!;
    controller.objective.value = objective!;
    controller.remarks.text = remarks!;
  }

  @override
  Widget build(BuildContext context) {

    if (id != null) addData();
    return Scaffold(
      appBar: AppBar(
        title: Text(id != null ? 'Update Activity' : 'New Activity'),
        backgroundColor: mainColor,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const Text('What do you want to do ?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      focusColor: Colors.white,
                      value: controller.activityType.value,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.grey,
                      items: <String>[
                        'Meeting',
                        'Calling',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        if (value == null) return;
                        controller.activityType.value = value;
                      },
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10))),
              const Text('Who do you want to meet/call ?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  child: Center(
                    child: TextField(
                      controller: controller.institution,
                      decoration:
                          const InputDecoration.collapsed(hintText: 'Institution'),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10))),
              const Text('When do you want to meet/call CV Anugrah Jaya ?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract((const Duration(days: 365))),
                          lastDate:
                              DateTime.now().add((const Duration(days: 365))))
                      .then((dateValue) {
                    if (dateValue == null) return;
                    showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 00, minute: 00))
                        .then((timeValue) {
                      if (timeValue == null) return;
                      controller.dateValue.value =
                          '${DateFormat('dd-MMM-yyyy').format(dateValue)} ${timeValue.format(context)}';
                    });
                  });
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.dateValue.value),
                        const Icon(
                          Icons.date_range,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border:
                            Border.all(width: 1, color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10))),
              ),
              const Text('Why do you want to meet/call CV Anugrah Jaya ?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      focusColor: Colors.white,
                      value: controller.objective.value,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.grey,
                      items: <String>[
                        'New Order',
                        'Invoice',
                        'New Leads',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: const Text(
                        "Please choose a langauage",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String? value) {
                        if (value == null) return;
                        controller.objective.value = value;
                      },
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10))),
              const Text('Could you describe it mode details ?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: controller.remarks,
                    maxLines: 4,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Enter your text here',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 15),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: thirdColor),
                  onPressed: () {
                    controller.addActivity(id ?? '');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Submit'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
