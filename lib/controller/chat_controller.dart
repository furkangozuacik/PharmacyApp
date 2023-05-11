import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  Future<String> generateResponse(String prompt) async {
    const apiKey = "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";

    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $apiKey"
      },
      body: json.encode({
        "model": "text-davinci-003",
        "prompt": prompt,
        'temperature': 0,
        'max_tokens': 4000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    // Do something with the response
    Map<String, dynamic> newresponse = jsonDecode(response.body);

    return newresponse['choices'][0]['text'];
  }
}
