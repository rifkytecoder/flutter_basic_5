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
  late String datax;

  @override
  void initState() {
    datax = "Belum ada Data";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Http Delete"),
        centerTitle: true,
        actions: [
          // todo Icon Button get data name
          IconButton(
            tooltip: "Get data first_name",
            onPressed: () async {
              var response = await http.get(
                  Uri.parse("https://reqres.in/api/users/2")); //1 get response
              final dataJson = jsonDecode(response.body)
                  as Map<String, dynamic>; // 2 json mapping

              print(dataJson['data']['first_name']); // testing console

              setState(() {
                datax =
                    "Akun : ${dataJson['data']['first_name']}"; // 3 implementasi data json
              });
            },
            icon: const Icon(Icons.download_for_offline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(datax),
          const SizedBox(
            height: 35,
          ),

          // todo Button Delete data
          ElevatedButton(
              onPressed: () async {
                // todo: HTTP DELETE REQUEST
                var response = await http
                    .delete(Uri.parse("https://reqres.in/api/users/2"));
                print(response.statusCode); // testing console // 204 No-content

                // jika berhasil di hapus
                if (response.statusCode == 204) {
                  setState(() {
                    datax = "Akun : Berhasil dihapus";
                  });
                  // jika gagal menghapus
                } else {
                  setState(() {
                    datax = "Error : ${response.statusCode}";
                  });
                }
                // setState(() {
                //   datax = "Akun : Berhasil dihapus";
                // });
              },
              child: const Text("Delete"))
        ],
      ),
    );
  }
}
