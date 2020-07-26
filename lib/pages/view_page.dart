import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/classes/news.dart';
import 'package:newsapp/classes/progress.dart';
import 'package:newsapp/pages/catogries_page.dart';
import 'package:newsapp/pages/details_news.dart';

class ViewPage extends StatefulWidget {
  bool isCatogry=false;
  String catogryName="general";
  String catogryTitle="أحدث الأخبار";
  ViewPage({this.isCatogry,this.catogryName,this.catogryTitle});
  @override
  _ViewPageState createState() => _ViewPageState(this.isCatogry,this.catogryName,this.catogryTitle);
}

class _ViewPageState extends State<ViewPage> {
  var response;
  bool isCatogry=false;
  String catogryName="general";
  String categoryTitle="أحدث الأخبار";
  List<News> allNews=[];
  _ViewPageState(this.isCatogry,this.catogryName,this.categoryTitle);
  @override
  Widget build(BuildContext context) {


      return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(categoryTitle),
            actions: <Widget>[
              isCatogry ? Container() : IconButton(
                icon: Icon(Icons.category), onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CatogriesPage()
                    ));
              },)
            ],
          ),
          body:
allNews.isEmpty?circularProgress():
          GridView.count(crossAxisCount: 1,
            childAspectRatio: 0.9,
            mainAxisSpacing: 10.0,
            children: List.generate(allNews.length, (index) {
              return (
                  Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Image.network(
                            allNews[index].imageUrl, height: 250,),
                        ),
                        Padding(padding: EdgeInsets.all(16.0),
                            child: Text(allNews[index].title, style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,)),

                        Container(height: 1.0, color: Colors.black54,),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(allNews[index].source, style: TextStyle(
                                  color: Colors.black38, fontSize: 10),),
                              FlatButton(
                                child: Row(
                                  children: <Widget>[
                                    Text("أكمل قراءة",
                                      style: TextStyle(color: Colors.black54),),
//                            Container(width: 10,)
                                    Icon(Icons.chevron_right,
                                      color: Colors.black54, size: 40,)
                                  ],
                                ),
                                onPressed: () =>
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsNews(
                                              currentNews: allNews[index],
                                              catogryName: categoryTitle,))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              );
            }),)

      );

  }

  @override
  void initState() {
    super.initState();
    print("I am in iniiiit");
    fetchData();
    startTimer();
    print(allNews);

  }
  fetchData()async
  {
    print("iam in fetch data");
    allNews.clear();
    String url="http://newsapi.org/v2/top-headlines?country=eg&apiKey=97aa0b4d4bd94d50896b79f4b022449f";

    if(isCatogry)
  {
   url="http://newsapi.org/v2/top-headlines?category=$catogryName&country=eg&apiKey=97aa0b4d4bd94d50896b79f4b022449f";
  }
    else{
      url="http://newsapi.org/v2/top-headlines?country=eg&apiKey=97aa0b4d4bd94d50896b79f4b022449f";
    }
    response= await http.get(url);
    if(response.statusCode==200) {
      Map<String, dynamic>bodyResponse = json.decode(response.body);
      var articles = bodyResponse['articles'];
      for (int i = 0; i < articles.length; i++) {
        var article = articles[i];
        var src = article['source'];
        setState(() {
          allNews.add(News(
              source: src['name'],
              author: article['author'],
              title: article['title'],
              description: article['description'],
              imageUrl: article['urlToImage'],
              date: article['publishedAt']));
        });

      }
    }
    else{
      throw Exception("Faild to load Data");
    }
//    print(response.body);

  }
//  _checkInternetConnectivity() async {
//    var result = await Connectivity().checkConnectivity();
//    if (result == ConnectivityResult.none) {
//      setState(() {
//        connecting = false;
//
//      });
//    } else if (result == ConnectivityResult.wifi ||
//        result == ConnectivityResult.mobile) {
//      setState(() {
//        connecting = true;
//
//      });
//    }
//  }

int timeRefresh=10;
  Timer timer;
void startTimer()
{
  timeRefresh=10;
  timer=Timer.periodic(Duration(seconds: 1), (timer) {
    if(timeRefresh>0)
      {
        setState(() {
          timeRefresh--;

        });
      }
    else
      {
        fetchData();
        setState(() {
          allNews=allNews;
          timeRefresh=10;

        });
      }
  });
}
}
