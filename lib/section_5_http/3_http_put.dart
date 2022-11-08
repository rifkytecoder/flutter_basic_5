import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameC = TextEditingController();
  final jobC = TextEditingController();

  late String hasilResponse;

  @override
  void initState() {
    hasilResponse = "Belum Ada Data";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Http Put / Patch"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // todo TextField Name
          TextField(
            controller: nameC,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Name",
            ),
          ),

          const SizedBox(
            height: 16,
          ),
          // todo TextField Job
          TextField(
            controller: jobC,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Job",
            ),
          ),
          const SizedBox(
            height: 16,
          ),

          // todo Button Update
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                // TODO: HTTP PUT REQUEST
                var response = await http.put(
                  Uri.parse("https://reqres.in/api/users/2"), // using users id
                  body: {"name": nameC.text, "job": jobC.text},
                );
                print(response.body); //(data masih string) testing di console

                // TODO response String parsing (Mapping) to Json
                final dataJson =
                    jsonDecode(response.body) as Map<String, dynamic>;
                print(dataJson["name"]); // testing jika namanya di ter-create

                setState(() {
                  // melihat response data dari server jika sudah terupdate
                  hasilResponse = "${dataJson['name']} - ${dataJson['job']}";
                });
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    //side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              child: const Text("UPDATE"),
            ),
          ),

          const SizedBox(
            height: 50,
          ),
          const Divider(
            height: 30,
            color: Colors.blue,
          ),
          // todo Text Show Response Data Create
          // const Text("Belum Ada Data")
          Text(hasilResponse),
        ],
      ),
    );
  }
}
