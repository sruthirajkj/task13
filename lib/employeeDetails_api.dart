import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class employeeDetails_api extends StatefulWidget {
  const employeeDetails_api({Key? key}) : super(key: key);

  @override
  State<employeeDetails_api> createState() => _employeeDetails_apiState();
}

class _employeeDetails_apiState extends State<employeeDetails_api> {
  Future<dynamic> employeedetails() async {
    final url = "https://dummy.restapiexample.com/api/v1/employees";
    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(body);
      return body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: employeedetails(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text("EMPLOYEE DETAILS", style: TextStyle(fontSize: 28)),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!["data"].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                  shape: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  title: Text(
                                      snapshot.data["data"][index]
                                              ["employee_name"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                  subtitle: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Age:",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Text(
                                                  snapshot.data["data"][index]
                                                          ["employee_age"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blue)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Salary:",
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Text(
                                                  snapshot.data["data"][index]
                                                          ["employee_salary"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blue))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    ),
                  ],
                );
              } else {
                return Text("something wrong");
              }
            }),
      ),
    );
  }
}
