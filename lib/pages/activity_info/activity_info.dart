import 'package:demo_impack_pratama/constant.dart';
import 'package:demo_impack_pratama/pages/activity_info/activity_info_controller.dart';
import 'package:demo_impack_pratama/pages/form_activity/form_activity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
// ignore: must_be_immutable
class ActivityInfo extends StatelessWidget {
  final String id;

  var controller = Get.put(ActivityInfoController());

  ActivityInfo({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getActivityDetail(id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Info'),
        backgroundColor: mainColor,
      ),
      body: Obx(
        () => controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  secondColor,
                ),
              ))
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Details',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '${controller.activityModel.value.activityType} with ${controller.activityModel.value.institution} at ${DateFormat('dd-MMM-yyyy HH:mm').format(controller.activityModel.value.when!)} to discuss about ${controller.activityModel.value.objective}',
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: mainColor,
                                minimumSize: const Size.fromHeight(40),
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () {
                                Get.to(() => FormActivity(
                                          id: id,
                                          activityType: controller
                                              .activityModel.value.activityType,
                                          institution: controller
                                              .activityModel.value.institution,
                                          date: DateFormat('dd-MMM-yyyy HH:mm')
                                              .format(controller
                                                  .activityModel.value.when!),
                                          objective: controller
                                              .activityModel.value.objective,
                                          remarks: controller
                                              .activityModel.value.remarks,
                                        ))!
                                    .then((_) =>
                                        controller.getActivityDetail(id));
                              },
                              child: const Text('Edit Activity'))
                        ],
                      ),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Could you describe it mode details ?',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          enabled: false,
                          controller: controller.resultTextCon
                            ..text = controller.activityModel.value.remarks!,
                          maxLines: 4,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Enter your text here',
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            border: Border.all(
                                width: 1, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10))),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: thirdColor),
                        onPressed: () {
                          Get.back();
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
