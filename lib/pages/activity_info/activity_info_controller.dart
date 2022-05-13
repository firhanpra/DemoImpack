import 'package:demo_impack_pratama/models./activity_model.dart';
import 'package:demo_impack_pratama/repository/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityInfoController extends GetxController {
  var resultTextCon = TextEditingController();
  var activityModel = ActivityModel().obs;
  var loading = false.obs;


  void getActivityDetail(String id) {
    loading.value = true;
    ActivityRepository().getActivity(id: id).then((val) {
      ActivityModel value = val;
      activityModel.value = value;
      loading.value = false;
    }, onError: (e) {
      Get.snackbar('Alert', e.toString(),
          backgroundColor: Colors.black, colorText: Colors.white);
      loading.value = false;
    });
  }
}
