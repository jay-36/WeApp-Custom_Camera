import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weapp_3/Refresh/UserDetail.dart';
import 'package:weapp_3/main.dart';

class wall extends StatefulWidget {
  @override
  _wallState createState() => _wallState();
}

class _wallState extends State<wall> {

  var wallpaperArray = List<WallpaperModel>();
  int _page = 1;
  var _gridController = ScrollController();


  getTrendingWallpaper(int page) async {
    var response = await http.get("https://api.pexels.com/v1/search?query=cars&per_page=15&page=$page", headers: {"Authorization": "563492ad6f91700001000001715d27a35191420bb2fd25eab0fe0853"});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaperArray.add(wallpaperModel);
    });
    wallpaperArray.length;
    setState(() {});
  }

  @override
  void initState() {
    getTrendingWallpaper(_page);
    _gridController.addListener(_scrollListener);
    super.initState();
  }

  _loadSearchImages() async {
    setState(() {
      _page = _page + 1;
    });
    var model = await getTrendingWallpaper(_page);
  }

  _scrollListener() {
    if (_gridController.offset >= _gridController.position.maxScrollExtent &&
        !_gridController.position.outOfRange) {
      _loadSearchImages();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (wallpaperArray.length > 0)
            ? Container(
          child:
          GridView.builder(
              controller: _gridController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.55,
              ),
              itemCount: wallpaperArray.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  child: GestureDetector(
                      onTap: () async{},
                      child:  ClipRRect(
                        child: FadeInImage(
                          placeholder: NetworkImage("https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80"),
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeIn,
                          image: NetworkImage(wallpaperArray[index].src.portrait,),
                        ),
                      )
                  ),
                );
              }),
        )
            : CircularProgressIndicator()
    );
  }
}




class Demo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoState();
  }
}

class DemoState extends State<Demo> {
  Future<List<ListData>> listDataJSON() async {
    final url = 'https://jsonplaceholder.typicode.com/photos';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List listData = json.decode(response.body);
      return listData
          .map((listData) => new ListData.fromJson(listData))
          .toList();
    } else {
      throw Exception('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pull To Refresh'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Demo(),)
          );
          return;
        },
        child: FutureBuilder<List<ListData>>(
          future: listDataJSON(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemBuilder: (BuildContext context, int currentIndex) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 60.0,
                              height: 60.0,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    snapshot.data[currentIndex].thumbnailUrl),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              width: 280.0,
                              child: Text(
                                snapshot.data[currentIndex].title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}

class ListData {
  final int albumId;
  final int id;

  final String title;
  final String url;
  final String thumbnailUrl;

  ListData({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});
  factory ListData.fromJson(Map<String, dynamic> jsonData) {
    return ListData(
      albumId: jsonData['albumId'],
      id: jsonData['id'],
      title: jsonData['title'],
      url: jsonData['url'],
      thumbnailUrl: jsonData['thumbnailUrl'],
    );
  }
}