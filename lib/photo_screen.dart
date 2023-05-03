import 'dart:convert';

import 'package:api_again/Model/PostModelPhoto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  List<PostModelPhoto> photolist = [];
  Future<List<PostModelPhoto>> getPhotoApi() async {
    final Response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(Response.body.toString());
    if (Response.statusCode == 200) {
      photolist.clear();
      for (Map i in data) {
        photolist.add(PostModelPhoto.fromJson(i));
      }
      return photolist;
    } else {
      return photolist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotoApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Lodaing');
                } else {
                  return ListView.builder(
                    itemCount: photolist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(photolist[index].url.toString()),
                        ),
                        title:
                            Text('Notes id ' + photolist[index].id.toString()),
                        subtitle: Text(photolist[index].title.toString()),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
