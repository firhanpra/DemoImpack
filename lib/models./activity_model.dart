import 'dart:convert';

List<ActivityModel> activityModelFromJson(String str) =>
    List<ActivityModel>.from(
        json.decode(str).map((x) => ActivityModel.fromJson(x)));

String activityModelToJson(List<ActivityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityModel {
  ActivityModel({
    this.id,
    this.activityType,
    this.institution,
    this.when,
    this.objective,
    this.remarks,
  });

  String? id;
  String? activityType;
  String? institution;
  DateTime? when;
  String? objective;
  String? remarks;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json["id"] ?? '',
        activityType: json["activityType"] ?? '',
        institution: json["institution"] ?? '',
        when: json["when"] == null ? null : DateTime.parse(json["when"]),
        objective: json["objective"] ?? '',
        remarks: json["remarks"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "activityType": activityType ?? '',
        "institution": institution ?? '',
        "when": when == null ? null : when!.toIso8601String(),
        "objective": objective ?? '',
        "remarks": remarks ?? '',
      };
}
