import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String body;
  late String id;
  late String email;
  late String name;

  @override
  void initState() {
    // todo Starting default value in Widget Screen
    body = "Belum ada Data";
    id = "";
    email = "";
    name = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Get Http"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //todo Text
              Text(
                // "Belum ada Data",
                body, // data server masuk ke dalam body ini
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "ID : $id", // data server masuk ke dalam id ini
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "Email : $email", // data server masuk ke dalam email ini
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "Full Name : $name", // data server masuk ke dalam name ini
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // todo BUTTON event click
              ElevatedButton(
                // TODO: HTTP GET REQUEST
                onPressed: (() async {
                  // Response object
                  var response = await http.get(Uri.parse(
                      "https://reqres.in/api/users/5")); // parsing string to URL
                  if (response.statusCode == 200) {
                    // berhasil get data
                    print("BERHASIL GET DATA");

                    // todo parsing Response to Json (Mapping)
                    // Map<String, dynamic> data
                    final dataJson =
                        jsonDecode(response.body) as Map<String, dynamic>;
                    print(dataJson['data']['email']); // print = testing console

                    // masuk State/threat Widget
                    setState(() {
                      // body dari server di simpan di variable body TextWidget(string)
                      body = response.body;
                      id = dataJson['data']['id'].toString();
                      email = dataJson['data']['email'].toString();
                      name =
                          "${dataJson['data']['first_name']} ${dataJson['data']['last_name']}";
                    });
                  } else {
                    // gagal get data
                    print("ERROR ${response.statusCode}"); // 404

                    setState(() {
                      body = "Error ${response.statusCode}";
                    });
                  }
                  // todo Testing GetData
                  // print("Datatype : $response \n");
                  // print("Status : ${response.statusCode} \n");
                  // print("Header : ${response.headers} \n");
                  // print("Body : ${response.body} \n");
                }),
                child: const Text("GET DATA"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
