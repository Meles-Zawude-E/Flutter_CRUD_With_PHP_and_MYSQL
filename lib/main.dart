import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InsertRecordPage(),
    );
  }
}

class InsertRecordPage extends StatefulWidget {
  @override
  _InsertRecordPageState createState() => _InsertRecordPageState();
}

class _InsertRecordPageState extends State<InsertRecordPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  // insert record here
  Future<void> insertRecord() async {
    if (name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty) {
      try {
        String uri = "http:// localhost/phpapi/create_student.php";
        var response = await http.post(
          Uri.parse(uri),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            "name": name.text,
            "email": email.text,
            "phoneNumber": phoneNumber.text,
          },
        );

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          //print(responseBody);
          if (responseBody["success"]) {
            print("Record Inserted");
          } else {
            print("Some Issue occurred");
          }
        } else {
          print("Request failed with status: ${response.statusCode}");
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Please fill the form");
    }
  }

  //delete record here
  Future<void> deleteRecord(String name) async {
    try {
      String uri = "http://localhost/phpapi/delete_student.php";
      var response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "name": name,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        print(responseBody);
        if (responseBody["success"]) {
          print("Record Deleted");
        } else {
          print("Some Issue occurred");
        }
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  //update
  Future<void> updateRecord() async {
    if (name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty) {
      try {
        String uri = "http://localhost/phpapi/update_student.php";
        var response = await http.post(
          Uri.parse(uri),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            "name": name.text,
            "email": email.text,
            "phoneNumber": phoneNumber.text,
          },
        );

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          //print(responseBody);
          if (responseBody["success"]) {
            print("Record Updated");
          } else {
            print("Some Issue occurred");
          }
        } else {
          print("Request failed with status: ${response.statusCode}");
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Please fill the form");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Registration Form"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter the Name",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter the Email",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: phoneNumber,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter the Phone",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  insertRecord();
                },
                child: const Text("Insert"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (name.text.isNotEmpty) {
                    deleteRecord(name.text);
                  } else {
                    print("Please enter the student's name");
                  }
                },
                child: const Text("Delete"),
              ),
              ElevatedButton(
                onPressed: () {
                  updateRecord();
                },
                child: const Text("Update"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
