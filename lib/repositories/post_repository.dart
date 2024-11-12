import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc_learner/models/post_model.dart';

// firstly import http package as http
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<PostModel>> fetchPosts() async {
    const url = 'https://jsonplaceholder.typicode.com/comments';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body) as List;
        return data.map((post) => PostModel.fromJson(post)).toList();
      }
    } on SocketException {
      throw 'No Internet Connection';
    } on TimeoutException {
      throw 'Connection Timeout';
    }

    throw Exception('Failed to fetch posts');
  }

}
