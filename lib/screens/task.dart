import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import './contacts.dart';
import './share.dart';

class NewClient extends StatefulWidget{
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  static File image;
  static List<DropdownMenuItem<String>> types=[
      DropdownMenuItem<String>(value:'End User',child:Text('End User')),
      DropdownMenuItem<String>(value:'Distributors',child:Text('Distributors')),
      DropdownMenuItem<String>(value:'Vendor',child:Text('Vendor')),
      DropdownMenuItem<String>(value:'Client/Company',child:Text('Client/Company')),
      DropdownMenuItem<String>(value:'Others',child:Text('Others')),
    ];
   static List<DropdownMenuItem<String>> user=[
      DropdownMenuItem<String>(value:'BK',child:Text('BK')),
      DropdownMenuItem<String>(value:'Santy',child:Text('Santy')),
      DropdownMenuItem<String>(value:'SK',child:Text('SK')),
    ];
  String selctedType=types[0].value;
  String slectedUser=user[0].value;
  String hintmob='Mobile Number';
  Position position;
  String loc='Location';
  TextEditingController mob=TextEditingController();
  TextEditingController addr=TextEditingController();

  @override
  void initState(){
    locper();
    super.initState();
  }

  Future<void> locper()async{
     Map<Permission,PermissionStatus> statuses=await [
      Permission.location,
      Permission.contacts
    ].request();
  }

  Future<void> getloc()async{
    position=await Geolocator().getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
    final coordinates=Coordinates(position.latitude,position.longitude);
    var addresses=await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first=addresses.first;
    setState(() {
      addr.text=' ${first.addressLine}';
    });
  }

  void modifypic(File im){
    setState(() {
      image=im;
    });
  }

  @override
  Widget build(BuildContext context){
    void chooseno(){
      Navigator.of(context).pushNamed(Contacts.rout).then((value){
        if(value!=null){
          setState(() {
            mob.text=value;
          });
        }
      });
    }
    final wd=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:AppBar(
        title:Text('New Client')
      ),
      body:SingleChildScrollView(
        child:Padding(
          padding:EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Table(
                children:[
                  TableRow(
                    children:[
                      SizedBox(
                height:60,
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Text(
                      'Type',style:TextStyle(
                        color:Colors.black26,fontSize:15
                      ),
                    ),
                    SizedBox(
                      width: wd*0.4,
                      height:40,
                      child: DropdownButton(
                        value:selctedType,
                        items:types, 
                        onChanged:(newVal){
                          setState(() {
                            selctedType=newVal;
                          });
                        }
                        ),
                    ),
                  ]
                )
              ),
              SizedBox(
                height:60,
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Text(
                      'Assigned User',style:TextStyle(
                        color:Colors.black26,fontSize:15
                      ),
                    ),
                    SizedBox(
                      width: wd*0.4,
                      height:40,
                      child: DropdownButton(
                        value:slectedUser,
                        items:user, 
                        onChanged:(newVal){
                          setState(() {
                            slectedUser=newVal;
                          });
                        }
                        ),
                    ),
                  ]
                )
              ),
                    ]
                  ),
                ]
              ),
              SizedBox(height:20),
              SizedBox(
                height:60,
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Text(
                      'Name/Code',style:TextStyle(
                        color:Colors.black26,fontSize:15
                      )
                    ),
                    SizedBox(
                      height:40,
                      child: TextFormField(
                       decoration:InputDecoration(
                         hintText:'User Name',
                       ),
                      ),
                    ),
                  ]
                )
              ),
              SizedBox(height:20),
              Table(
                children:[
                  TableRow(
                    children:[
                      SizedBox(
                width:wd*0.4,
                height:78,
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Text(
                      'User Name',style:TextStyle(
                        color:Colors.black26,fontSize:15
                      )
                    ),
                    SizedBox(
                      height:40,
                      child: TextFormField(
                       decoration:InputDecoration(
                         suffixIcon:Icon(Icons.group_add),
                         hintText:'User Name'
                       ),
                       
                      ),
                    ),
                  ]
                )
              ),
              InkWell(
                onTap: chooseno,
                child: SizedBox(
                  width:wd*0.4,
                  height:78,
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:[
                      Text(
                        'Mobile Number',style:TextStyle(
                          color:Colors.black26,fontSize:15
                        )
                      ),
                      SizedBox(
                        height:40,
                        child: TextField(
                          controller:mob,
                         decoration:InputDecoration(
                           suffixIcon:IconButton(
                             icon:Icon(Icons.call),
                             onPressed:chooseno,),
                           hintText:hintmob,
                           hintStyle:TextStyle(
                             color:Colors.black
                           )
                         ),
                        ),
                      ),
                    ]
                  )
                ),
              ),
                    ]
                  ),
                  
                ]
              ),
              SizedBox(height:20),
              SizedBox(
                height:98,
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    Text(
                      'Location',style:TextStyle(
                        color:Colors.black26,fontSize:15
                      )
                    ),
                    SizedBox(
                      height:60,
                      child: TextField(
                        controller:addr,maxLines:3,
                        style:TextStyle(fontSize:15) ,
                       decoration:InputDecoration(
                         suffixIcon:IconButton(
                           icon:Icon(Icons.add_location),
                           onPressed:getloc,
                         ),
                         hintText:loc,
                         hintStyle:TextStyle(
                           color:Colors.black,fontSize:13
                         ),
                         hintMaxLines:3
                       ),
                       textInputAction:TextInputAction.done,
                      ),
                    ),
                  ]
                )
              ),
              Padding(
                padding:EdgeInsets.fromLTRB(0,20,0,0),
                child: SizedBox(
                  height:30,
                  width:150,
                  child:Text(
                    'Add More Details',style:TextStyle(
                      decoration:TextDecoration.underline,fontSize:15
                    ),
                    textAlign:TextAlign.center,
                  )
                ),
              ),
              Padding(
                padding:EdgeInsets.fromLTRB(0,5,0,0),
                child: SizedBox(
                  height:30,
                  width:150,
                  child:Text(
                    'Add More Contacts',style:TextStyle(
                      decoration:TextDecoration.underline,fontSize:15
                    ),
                    textAlign:TextAlign.center,
                  )
                ),
              ),
              Padding(
                padding:EdgeInsets.fromLTRB(0,5,0,0),
                child: FlatButton(
                  onPressed:(){
                    Navigator.of(context).pushNamed(Share.rout).then((value){
                      setState(() {
                        image=value;
                      });
                    });
                  },
                  child: SizedBox(
                    height:30,
                    width:150,
                    child:Text(
                      'Add Logo',style:TextStyle(
                        decoration:TextDecoration.underline,fontSize:15
                      ),
                      textAlign:TextAlign.center,
                    )
                  ),
                ),
              ),
              image==null?
              Icon(Icons.account_box,size:30,):
              SizedBox(
                height:80,
                width:80,
                child: Image.file(
                  image,fit:BoxFit.contain,
                ),
              ),
                
            ],
          ),
        )
      ),
    );
  }
}