import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class UserModel {
  final String name;
  final String job;

  UserModel({required this.name, required this.job});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'job': job,
    };
  }
}

class ApiCall {
  Dio dio = Dio();

  Future<void> patchUser(UserModel user) async {
    try {
      String url = "https://reqres.in/api/users/2";
      Response response = await dio.patch(url, data: user.toJson());
      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");
    } catch (error) {
      print("Error: $error");
    }
  }
}

class PatchScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  PatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: jobController,
              decoration: const InputDecoration(labelText: 'Job'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                UserModel user = UserModel(
                  name: nameController.text,
                  job: jobController.text,
                );

                ApiCall().patchUser(user);
              },
              child: const Text('PATCH Request'),
            ),
          ],
        ),
      ),
    );
  }
}
