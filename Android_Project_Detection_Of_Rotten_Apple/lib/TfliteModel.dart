import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key}) : super(key: key);
  @override
  _TfliteModelState createState() => _TfliteModelState();
}
class _TfliteModelState extends State<TfliteModel> {
  late File _image;
  late List _results;
  bool imageSelect = false;
  @override
  void initState() {
    super.initState();
    loadModel();
  }
  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
        model: "assets/CnnModel.tflite", labels: "assets/labels.txt"))!;
    print("Models loading status: $res");
  }
  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,);
    setState(() {
      _results = recognitions!;
      _image = image;
      imageSelect = true;});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.menu,),),
        title: const Text("Frapple",
          style: TextStyle(
            fontFamily: 'PatrickHand-Regular',
            fontSize: 28,),),
        elevation: 10,backgroundColor: Colors.teal[900],),
      body: ListView(
        children: [
          Image.asset('assets/images/appletop.png',
            fit:BoxFit.cover,),
          (imageSelect) ? Container(
            height: 200,
            width: 200,
            // margin: const EdgeInsets.all(20),
            margin: EdgeInsets.only(left:10.0,right: 10.0,top: 20,bottom: 0),
            child: Image.file(_image),
          ) : Container(
            // margin: const EdgeInsets.all(10),
            child: const Opacity(
              opacity: 0.8,
              child: Center(
                child: Text("No image selected, only select Apple images"),),),),
          SizedBox(height: 20,),
          SingleChildScrollView(
            child: Column(
              children: (imageSelect) ? _results.map((result) {
                return Card(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      "${result['label']}",
                      style: const TextStyle(color: Colors.red,
                           // backgroundColor: Colors.lightGreen,
                          fontFamily: 'PatrickHand-Regular',
                          fontSize: 33,
                        fontWeight: FontWeight.bold,),),),);
              }).toList() : [],),),
          CustomButton(
            title: 'Pick from Gallery',
            icon: Icons.image_outlined,
            onClick: pickImage,),
          CustomButton(
            title: 'Click Image',
            icon: Icons.camera,
            onClick: () => pickImagefromcamera(),),],),);}
  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,);
    File image = File(pickedFile!.path);
    imageClassification(image);}
  Future pickImagefromcamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,);
    File image = File(pickedFile!.path);
    imageClassification(image);}}
Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,}){
  return Container(
    width:80,
    child:ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        primary: Colors.teal[900],),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width:20,),
          Container(
              width: 10,),
          Text(title,style: TextStyle(
            fontFamily: 'PatrickHand-Regular',
            fontSize: 24,),)],),),
    margin: EdgeInsets.only(left:50.0,right: 50.0),);
}