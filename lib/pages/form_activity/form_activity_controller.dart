import 'package:demo_impack_pratama/repository/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FormActivityController extends GetxController {
  var activityType = 'Meeting'.obs;
  var institution = TextEditingController();
  var dateValue = 'dd-MMM-yyyy HH:mm'.obs;
  var objective = 'New Order'.obs;
  var remarks = TextEditingController();

  addActivity(String id) {
    //check and handle data null
    if (institution.text == '' ||
        dateValue.value == 'dd-MMM-yyyy HH:mm' ||
        remarks.text == '') {
      return Get.snackbar('Alert', 'Data Wajib diisi',
          backgroundColor: Colors.black, colorText: Colors.white);
    }
    
    //convert string format to string dateIso
    var date = DateFormat('dd-MMM-yyyy HH:mm').parse(dateValue.value);
    DateTime myDatetime =
        DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:ss').format(date));
    var stringDateIso = myDatetime.toIso8601String();

    //check type new or update data
    if (id == '') {
      ActivityRepository()
          .postActivity(
              activityType: activityType.value,
              institution: institution.text,
              when: stringDateIso,
              objective: objective.value,
              remarks: remarks.text)
          .then((_) => Get.back());
    } else {
      ActivityRepository()
          .postActivity(
              id: id,
              activityType: activityType.value,
              institution: institution.text,
              when: stringDateIso,
              objective: objective.value,
              remarks: remarks.text)
          .then((_) => Get.back());
    }
  }
}
