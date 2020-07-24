import 'dart:io';
import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Share extends StatefulWidget{
  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  File _image;
  final picker=ImagePicker();
  TextEditingController cont=TextEditingController();
  Future<void> getimage(ImageSource source)async{
    PickedFile image = await picker.getImage(source: source);
    setState(() {
      _image=File(image.path);
    });
  }

  Future<void> cropImage()async{
    File cropped=await ImageCropper.cropImage(
      sourcePath:_image.path,
      androidUiSettings:AndroidUiSettings(
        toolbarTitle:'Crop The Image',
        toolbarColor:Colors.purple,
        toolbarWidgetColor:Colors.white
      )
    );
    setState(() {
      _image=cropped??_image;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('Share photo')
      ),
      body:SingleChildScrollView(
        child: Column(
          children:[
            Center(
              child: FlatButton(
                child:Text(
                  'Choose from gallery',style:TextStyle(
                    fontSize:15,fontWeight:FontWeight.bold
                  ),
                ),
                onPressed:(){
                  getimage(ImageSource.gallery);
                },
              ),
            ),
            Center(
              child: FlatButton(
                child:Text(
                  'Choose a camera picture',style:TextStyle(
                    fontSize:15,fontWeight:FontWeight.bold
                  ),
                ),
                onPressed:(){
                  getimage(ImageSource.camera);
                },
              ),
            ),
            _image!=null?Image.file(_image):SizedBox(),
            Center(
              child: FlatButton(
                child:Text(
                  'Crop the image',style:TextStyle(
                    fontSize:15,fontWeight:FontWeight.bold
                  ),
                ),
                onPressed:(){
                  cropImage();
                },
              ),
            ),
            Center(
              child: FlatButton(
                child:Text(
                  'Clear image',style:TextStyle(
                    fontSize:15,fontWeight:FontWeight.bold
                  ),
                ),
                onPressed:(){
                  setState(() {
                    _image=null;
                  });
                },
              ),
            ),
            Padding(
              padding:EdgeInsets.all(20),
              child: TextField(
                controller:cont,
                decoration:InputDecoration(
                  labelText:'Give your comments'
                ),
              ),
            ),
            Center(
              child: FlatButton(
                child:Text(
                  'Share to all media',style:TextStyle(
                    fontSize:15,fontWeight:FontWeight.bold
                  ),
                ),
                onPressed:(){
                  SocialShare.shareOptions(cont.text,imagePath:_image.path);
                },
              ),
            ),
          ]
        ),
      )
    );
  }
}