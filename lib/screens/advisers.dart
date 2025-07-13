import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/components/utils.dart';
import 'package:http/http.dart' as http;
import 'package:tdms_faculty/screens/dashboard.dart';

class MyAdvisers extends StatefulWidget {
  const MyAdvisers({super.key});

  @override
  State<MyAdvisers> createState() => _MyAdvisersState();
}

class _MyAdvisersState extends State<MyAdvisers> {
  @override
  void initState() {
    super.initState();
    _fetchMyAdvisersAndPanel();
  }

  List<Map<String, dynamic>> myAdvisersAndPanel = [];

  Future<void> _fetchMyAdvisersAndPanel() async {
    final token = await getToken();
    final url = Uri.parse('$apiUrl/my-advisers-panels');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {});
    } else {
      showMessageSnackbar(context, responseBody['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppbar(
          title: 'Advisers',
          showActions: true,
          withLeading: true,
          locationScreen: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          },
        ),
      ),
      body: Center(child: Text('Advisers')),
    );
  }
}
