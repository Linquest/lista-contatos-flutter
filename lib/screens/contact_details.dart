import 'package:contapp/models/contact.dart';
import 'package:flutter/material.dart';

class ContactDetailsScreen extends StatelessWidget {
  final Contact contact;

  ContactDetailsScreen(this.contact);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: contact.image != null
                  ? Image.file(contact.image, height: 200, width: 200)
                  : Icon(
                      Icons.person,
                      size: 200,
                    ),
            ),
            SizedBox(height: 16),
            Text(
              'Name: ${contact.name}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Phone: ${contact.phone}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${contact.email}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
