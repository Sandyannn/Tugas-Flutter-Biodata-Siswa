import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:biodata/models/siswa.dart';
import 'package:biodata/models/api.dart';
import 'details.dart';
import 'create.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<SiswaModel>> sw;
  final swListKey = GlobalKey<HomeState>();

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<SiswaModel>> getSwList() async {
    try {
      final response = await http.get(Uri.parse(Api.list));

      print("Status Code: ${response.statusCode}");
      print("Data dari Server: ${response.body}");

      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        List<SiswaModel> sw = items.map<SiswaModel>((json) {
          return SiswaModel.fromJson(json);
        }).toList();
        return sw;
      } else {
        throw Exception('Gagal memuat data');
      }
    } catch (e) {
      print("Errornya adalah: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Data Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<SiswaModel>>(
          future: sw,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person, size: 50),
                    trailing: const Icon(Icons.info_outline),
                    title: Text(
                      "${data.nis} - ${data.nama}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Kelamin: ${data.kelamin} \nAlamat: ${data.alamat}",
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(sw: data),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Create(),
            ),
          );
        },
      ),
    );
  }
}