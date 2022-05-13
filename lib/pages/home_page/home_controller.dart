import 'package:demo_impack_pratama/models./activity_model.dart';
import 'package:demo_impack_pratama/repository/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedNavbar = 0.obs;
  var homeTitle = 'Home'.obs;
  var boolComplete = false.obs;
  var showFab = false.obs;
  var loading = false.obs;
  var listActivity = <ActivityModel>[].obs;

  void changeSelectedNavBar(int index) {
    selectedNavbar.value = index;
    showFab.value = false;
    switch (index) {
      case 0:
        homeTitle.value = 'Home';
        break;
      case 1:
        homeTitle.value = 'Activities';
        showFab.value = true;
        getActivity();
        break;
      case 2:
        homeTitle.value = 'Orders';
        break;
      case 3:
        homeTitle.value = 'Profile';
        break;
    }
  }

  void getActivity() {
    loading.value = true;
    ActivityRepository().getActivity().then((val) {
      if (val == null) return;
      List<ActivityModel> value = val;
      value.sort((a, b) => a.when!.compareTo(b.when!));
      listActivity.value = value;

      loading.value = false;
    }, onError: (e) {
      Get.snackbar('Alert', e.toString(),
          backgroundColor: Colors.black, colorText: Colors.white);
      loading.value = false;
    });
  }
}
