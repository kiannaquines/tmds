import 'dart:convert';
import 'package:tdms_faculty/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

Future<String?> fetchUserName() async {
  final url = Uri.parse('$apiUrl/user');
  final token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    return responseBody['user']['name'];
  } else {
    return '';
  }
}

Future<String?> fetchUserRole() async {
  final url = Uri.parse('$apiUrl/user');
  final token = await getToken();

  final response = await http.post(
    url,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    return responseBody['user']['role'];
  } else {
    return '';
  }
}
