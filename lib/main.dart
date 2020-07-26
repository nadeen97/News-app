import 'package:flutter/material.dart';
import 'package:newsapp/pages/view_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' News',
      home: ViewPage(isCatogry: false,catogryTitle: "أحدث الأخبار",catogryName: "general",),
    );
  }
}


