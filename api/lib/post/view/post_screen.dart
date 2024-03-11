import 'package:api/get/get_screen.dart';
import 'package:api/post/model/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  PostScreen({super.key});

  void addUser(Text text) async {
    String name = nameController.text;
    String email = emailController.text;

    if (name.isEmpty || email.isEmpty) return;

    try {
      var response = await Dio().post(
        'https://reqres.in/api/posts',
        data: {'name': name, 'email': email},
      );
      print('response--------->$response');
      if (response.statusCode == 200) {
        User newUser = User.fromJson(response.data);
        print('New user added with ID: ${newUser.id}');
      }
      nameController.clear();
      emailController.clear();
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(GetScreen());
              },
              child: const Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
