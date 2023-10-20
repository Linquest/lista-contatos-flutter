import 'package:flutter/material.dart';
import 'package:your_app_name/models/contact.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AddContactScreen extends StatefulWidget {
  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Contato'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: _selectedImage != null
                    ? FileImage(_selectedImage)
                    : AssetImage('assets/default_avatar.png'),
                radius: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Implemente a seleção de imagem aqui
                  // _selectedImage = await selectImage();
                  // setState(() {});

                  // Exemplo de seleção de imagem simulada
                  _selectedImage = File('/path/to/selected/image.jpg');
                  setState(() {});
                },
                child: Text('Selecionar Imagem'),
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Telefone (com DDD)'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    // Faça o upload da imagem para o Back4App
                    final ParseFile imageFile = ParseFile(_selectedImage);
                    final response = await imageFile.save();

                    if (response.success) {
                      final newContact = Contact(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        image: imageFile,
                      );

                      final saveResponse = await newContact.save();

                      if (saveResponse.success) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Erro ao salvar o contato.'),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Erro ao enviar a imagem.'),
                      ));
                    }
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
