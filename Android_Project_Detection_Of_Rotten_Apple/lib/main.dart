import 'package:flutter/material.dart';
import 'package:tflite_image_classification/TfliteModel.dart';
import 'TfliteModel.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frapple',

      theme: ThemeData(
        primarySwatch: Colors.teal,),
      home: Homepage(),);}
}
class Homepage extends StatefulWidget{
  @override
  _HomepageState createState() => _HomepageState();
}
class _HomepageState extends State<Homepage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.menu,),),
        title: const Text("Frapple",
          style: TextStyle(
            fontFamily: 'PatrickHand-Regular',
            fontSize: 28,),),
        elevation: 10,backgroundColor: Colors.teal[900],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child:
              Image.asset('assets/images/apple_backgroud(1).jpg',
                fit:BoxFit.cover,
                width: double.infinity,),),
            Container(
                alignment: Alignment.center,
              child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> TfliteModel(),),);},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black12,
                          side: BorderSide(
                            width: 0.5,
                            color: Colors.white,),),
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                            fontFamily: 'PatrickHand-Regular',
                            fontSize: 24,),),),
              margin: EdgeInsets.only(left:50.0,right: 50.0,top: 180.0),),],),
      ),
    );
  }
}
