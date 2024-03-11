import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GetScreen extends StatefulWidget {
  @override
  _GetScreenState createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  late List<Map<String, dynamic>> data = [];
  late Dio dio;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      if (response.statusCode == 200) {
        setState(() {
          data = List<Map<String, dynamic>>.from(response.data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteData(int id) async {
    try {
      final response =
          await dio.delete('https://jsonplaceholder.typicode.com/posts/$id');
      if (response.statusCode == 200) {
        print('Data deleted successfully');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: data.isNotEmpty
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final post = data[index];
                  return ListTile(
                    title: Text(
                      'ID: ${post['id']}',
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['title'],
                          style:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        Text(
                          post['body'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteData(post['id']);
                        setState(() {
                          data.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
