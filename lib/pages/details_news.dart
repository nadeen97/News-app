import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/classes/news.dart';

class DetailsNews extends StatefulWidget {
  String catogryName;
  News currentNews;
  DetailsNews({this.catogryName,this.currentNews});
  @override
  _DetailsNewsState createState() => _DetailsNewsState(this.catogryName,this.currentNews);
}

class _DetailsNewsState extends State<DetailsNews> {
  String catogryName;
  News currentNews;
  _DetailsNewsState(this.catogryName,this.currentNews);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.catogryName),backgroundColor: Colors.red,),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 16.0,right: 16.0,top: 10.0),child: Text(currentNews.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.right,)),
          Container(
            child: Image.network(currentNews.imageUrl,height: 250,),
          ),
          Container(
            height: 2.0,
            color: Colors.black38,
          ),
          Padding(padding: EdgeInsets.all(16.0),child: Text(currentNews.description,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.right,)),

//Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child:  Text(currentNews.source??"No source",style:TextStyle(color: Colors.blueGrey,fontSize: 12) ,),

            ),
          ),
  Text(currentNews.author??"No author",style:TextStyle(color: Colors.blueGrey,fontSize: 12) ,),
  Padding(padding: EdgeInsets.only(bottom: 20.0),child: Text(currentNews.date??"No date",style:TextStyle(color: Colors.blueGrey,fontSize: 12) ,)),
//
//],)

//          FittedBox(child: AssetImage(currentNews.catogryImage),)
        ],
      ),

    );
  }
}
