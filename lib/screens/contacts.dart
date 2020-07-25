import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts extends StatefulWidget{
  static const rout='contacts';
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  PermissionStatus status;
  List<Contact> _contacts=[];
  @override
  void initState(){
    requestper().then((_) => refreshContacts());
    //refreshContacts();
    super.initState();
  }

  Future<void> requestper()async{
     Map<Permission,PermissionStatus> statuses=await [
      Permission.contacts
    ].request();
  }

  refreshContacts()async{
    try{
      List<Contact> contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
      setState(() {
        _contacts=contacts;
      });
    }catch(error){
      print('error');
    }
    
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('All Contacts')
      ),
      body:_contacts.length==0?Center(child:Text('There are no contacts')):
      ListView.builder(
        itemCount:_contacts.length,
        itemBuilder:(ctx,i){
          Contact contact=_contacts[i];
          return ListTile(
            onTap:()=>Navigator.of(context).pop(contact.phones.elementAt(0).value),
            title:Text(contact.displayName),
            subtitle:Text(
              contact.phones.isEmpty?'':
              contact.phones.elementAt(0).value
            ),
          );
        }
        )
    );
  }
}