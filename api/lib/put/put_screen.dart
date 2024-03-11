import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}

class PutScreen extends StatefulWidget {
  const PutScreen({super.key});

  @override
  State<PutScreen> createState() => _PutScreenState();
}

class _PutScreenState extends State<PutScreen> {
  Dio dio = Dio();
  String url = "https://jsonplaceholder.typicode.com/posts/1";

  void updatePost() async {
    try {
      var response = await dio.get(url);
      Map<String, dynamic> postData = response.data;
      Post post = Post.fromJson(postData);
      Post updatedPost =
          Post(userId: post.userId, id: post.id, title: "", body: "");

      updatedPost.toJson();
      var result = await dio.put(url, data: postData);
      print("response------>${response.statusCode}");
      print("response data------>${result.data}");
    } catch (e) {
      print("Eorro: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: updatePost,
          child: const Text('Update Post'),
        ),
      ),
    );
  }
}
