import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';

class SelectContactUser extends StatefulWidget {
  const SelectContactUser({super.key});

  @override
  State<SelectContactUser> createState() => _SelectContactUserState();
}

class _SelectContactUserState extends State<SelectContactUser> {
  @override
  void initState() {
    super.initState();
    _contactsFuture = getContactList();
  }

  late Future _contactsFuture;

  List<Contact> contacts = [];

  Future getContactList() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      await Permission.contacts.request().isGranted;
    }
    List<Contact> list = await FastContacts.getAllContacts();
    setState(() {
      contacts = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _contactsFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return AppSceenSize.loadingIcon;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final phones =
                      contacts[index].phones.map((e) => e.number).join(', ');
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pop(contacts[index]);
                      },
                      leading: Icon(Icons.person),
                      title: Text(contacts[index].displayName),
                      subtitle: Text(phones),
                    ),
                  );
                },
                itemCount: contacts.length,
                shrinkWrap: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
