import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/classes/catogry.dart';
import 'package:newsapp/pages/view_page.dart';

class CatogriesPage extends StatefulWidget {
  @override
  _CatogriesPageState createState() => _CatogriesPageState();
}

class _CatogriesPageState extends State<CatogriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Catogries"),backgroundColor: Colors.red,),
    body: GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 4.0,
      mainAxisSpacing: 3.0,
      children:
      List.generate(catogries.length, (index)
      {
        return
             GestureDetector(
               child: (Container(
            decoration: BoxDecoration(
                  gradient: new LinearGradient(colors: [Colors.black,Colors.indigo],
                      begin: Alignment.centerLeft,
                      end: new Alignment(1.0, 1.0))
            ),
            child: Stack(children: <Widget>[
                Opacity(opacity: 0.3,child: Container(decoration: new BoxDecoration(
//                borderRadius: BorderRadius.circular(24.0),
                    image:DecorationImage(
                        image:AssetImage(catogries[index].catogryImage),
                      fit: BoxFit.fill
                    )
                ),),),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all( 16.0),
                    child: Text(catogries[index].catogryTitle,style: TextStyle(
                      color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
                    ),),
                  ),
                )
            ],
            ),
        )
          ),
               onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPage(isCatogry: true,catogryName: catogries[index].catogryName,catogryTitle: catogries[index].catogryTitle,))),

             );
      }
      )
    ),


    );
  }
}