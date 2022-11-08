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
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // todo untuk menampung AllList data user yg telah ter-Mapping
  List<Map<String, dynamic>> allUser = [];

  // todo fungsi Get All data users
  // Object yg beresiko Delay di suatu saat
  Future getAllUserx() async {
    // todo Testing Delay manual durasi 3 detik
    // await Future.delayed(const Duration(seconds: 3));
    try {
      // todo get AllList user dari server
      var response =
          await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
      // print(response.body); // testing console data String
      // todo Parsing data String ke data List Mapping
      List dataJson =
          (jsonDecode(response.body) as Map<String, dynamic>)["data"];
      // todo setiap data yg ter-looping(element) akan di masukkan ke variable allUser
      for (var element in dataJson) {
        allUser.add(element);
      }
      print(allUser); // testing console data Json
    } catch (e) {
      // jika terjadi error
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Future Builder"),
      ),

      // todo FutureBuilder / untuk Reload Get All/ List data automatis(secara Asyncronous)
      body: FutureBuilder(
          future:
              getAllUserx(), // wajib dimasukkan ke future Object yg berpotensi Jedah-waktu/delay/load-data dari server
          builder: (context, AsyncSnapshot) {
            // Jika masih terjadi Delay/Load-data tampilkan text Loading di layar
            if (AsyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("Loading..."),
              );
              // else if (AsyncSnapshot.connectionState == ConnectionState.done) // bisa juga
            } else {
              // jika tidak ada data yang terload/ data kosong tampilkan Tidak ada Data
              if (allUser.isEmpty) {
                return const Center(
                  child: Text("Tidak Ada Data"),
                );
              }
              // Jika waktu Delay/Load-data selesai
              return ListView.builder(
                // itemCount: 5,
                itemCount:
                    allUser.length, // panjang data sesuai jumlah list-data
                itemBuilder: (context, index) {
                  return ListTile(
                    // Circle photo avatar
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(allUser[index]['avatar']),
                      backgroundColor: Colors.grey[300],
                    ),
                    // todo text Name
                    title: Text(
                      "${allUser[index]['first_name']} ${allUser[index]['last_name']}",
                    ),
                    // todo subtitle Email
                    subtitle: Text(
                      "${allUser[index]['email']}",
                    ),
                  );
                },
              );
            }

            // return ListView.builder(
            //   itemCount: 5,
            //   itemBuilder: (context, index) {
            //     return const ListTile(
            //       leading: CircleAvatar(),
            //       title: Text("Nama Lengkap"),
            //       subtitle: Text("Email"),
            //     );
            //   },
            // );
          }),
    );
  }
}
