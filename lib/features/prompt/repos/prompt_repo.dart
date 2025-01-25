import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class PromptRepo {
  static Future<List<int>?> generateImgae(String prompt) async {
    try {
      String url = "https://api.vyro.ai/v2/image/generations";
      Map<String, dynamic> headers = {
        "Authorization":
            "Bearer vk-i31DXDgAKxlzswSJuuEAkVbSmmG2BS0F6TkJizMmprnGkZ"
      };

      Map<String, dynamic> payload = {
        'prompt': prompt,
        'style': "anime",
        'aspect_ratio': "1:1",
        'seed': "1"
      };

      Dio dio = Dio();
      dio.options =
          BaseOptions(headers: headers, responseType: ResponseType.bytes);

      FormData formData = FormData.fromMap(payload);

      final response = await dio.post(url, data: formData);

      print(response.data);

      if (response.statusCode == 200) {
        print(response.data.runtimeType.toString());
        print(response.data.toString());
        Uint8List uint8list = Uint8List.fromList(response.data);
        return uint8list;
      } else {
        return null;
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
