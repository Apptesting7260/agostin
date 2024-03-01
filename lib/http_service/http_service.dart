import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../utils/snack_bar.dart';

class HttpService {
  static serverError(error) =>
      showError(
          title: "Server Issue",
          description: "Unable Fetch Data with $error");

  static networkError() =>
      showError(
          title: "Internet Issue",
          description: "Please Check Network Connection");


  static Future<dynamic> postRequest<model>(
      {required String url, required Map body, }) async {
    try {
      final result = await http.post(
          Uri.parse(url), body: body,);
      if (result.statusCode != 200) {
//print ("$url Api Status Code of ${result.statusCode}");
        serverError(result.statusCode);
        return null;
      }
      final parse = jsonDecode(result.body);
//print("data == ${result.body}");
      return parse;
    } on SocketException {
      networkError;
      return null;
    } catch (e) {
      return null;
    }
  }
}