import 'package:flutter/material.dart';
import 'package:your_app_name/models/contact.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;

  ContactDetailsScreen(this.contact);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Contato'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditContactScreen(contact),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CircleAvatar(
            backgroundImage: contact.image != null
                ? NetworkImage(contact.image.url)
                : AssetImage('assets/default_avatar.png'),
            radius: 50,
          ),
          ListTile(
            title: Text('Nome'),
            subtitle: Text(contact.name),
          ),
          ListTile(
            title: Text('Telefone'),
            subtitle: Text(contact.phone),
          ),
          ListTile(
            title: Text('E-mail'),
            subtitle: Text(contact.email),
          ),
        ],
      ),
    );
  }
}
