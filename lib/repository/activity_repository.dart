import 'dart:convert';

import 'package:demo_impack_pratama/models./activity_model.dart';
import 'package:dio/dio.dart';

class ActivityRepository {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: 8000,
    sendTimeout: 8000,
    receiveTimeout: 8000,
  ));

  Future<dynamic> getActivity({String? id}) async {
    List<ActivityModel> activityModel;
    ActivityModel itemActivity;

    try {
      var response = await _dio.get(
        'https://627b37f7a01c46a8531a78e8.mockapi.io/activities/${id ?? ''}',
      );
      if (id == null) {
        activityModel = (response.data as List)
            .map((e) => ActivityModel.fromJson(e))
            .toList();

        return activityModel;
      } else {
        itemActivity = ActivityModel.fromJson(response.data);
        return itemActivity;
      }
    } on DioError catch (dioError) {
      if (dioError.type == DioErrorType.response) {
        switch (dioError.response!.statusCode) {
          case 404:
            throw 'Not found';
          case 401:
            throw 'Unauthorized';
          case 500:
            throw 'Internal Server Error';
          case 501:
            throw 'Not Implemented Server Error';
          case 502:
            throw 'Bad Gateway Server Error';
          default:
            throw '${dioError.response!.statusCode} - Something went wrong while trying to connect with the server';
        }
      } else if (dioError.type == DioErrorType.other) {
        throw 'Please check your internet connection. Try again switching to a different connection';
      }
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }

  Future<void> postActivity({
    String? id,
    required String activityType,
    required String institution,
    required String when,
    required String objective,
    required String remarks,
  }) async {
    Map data = {
      "activityType": activityType,
      "institution": institution,
      "when": when,
      "objective": objective,
      "remarks": remarks
    };
    var body = json.encode(data);

    try {
      if (id == null) {
        await _dio.post(
            'https://627b37f7a01c46a8531a78e8.mockapi.io/activities',
            data: body);
      } else {
        await _dio.put(
            'https://627b37f7a01c46a8531a78e8.mockapi.io/activities/$id',
            data: body);
      }
    } on DioError catch (dioError) {
      if (dioError.type == DioErrorType.response) {
        switch (dioError.response!.statusCode) {
          case 404:
            throw 'Not found';
          case 401:
            throw 'Unauthorized';
          case 500:
            throw 'Internal Server Error';
          case 501:
            throw 'Not Implemented Server Error';
          case 502:
            throw 'Bad Gateway Server Error';
          default:
            throw '${dioError.response!.statusCode} - Something went wrong while trying to connect with the server';
        }
      } else if (dioError.type == DioErrorType.other) {
        throw 'Please check your internet connection. Try again switching to a different connection';
      }
    } catch (e) {
      throw 'Something went wrong : $e';
    }
  }
}
