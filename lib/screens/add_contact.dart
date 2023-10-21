import 'dart:io';
import 'package:contapp/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AddContactScreen extends StatefulWidget {
  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  late File _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().getImage(source: source);

    if (pickedImage != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(pickedImage.path);
      final savedImage = await File(pickedImage.path).copy('${appDir.path}/$fileName');

      setState(() {
        _image = savedImage;
      });
    }
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newContact = Contact(
      name: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      image: _image,
    );

    // Adicione aqui a lógica para salvar o contato, incluindo a imagem, no Back4App.

    Navigator.of(context as BuildContext).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            _image != null
                ? Image.file(_image, height: 100)
                : SizedBox(
                    height: 100,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.camera),
                  label: Text('Take a Photo'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  label: Text('Choose from Gallery'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveForm,
              child: Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
