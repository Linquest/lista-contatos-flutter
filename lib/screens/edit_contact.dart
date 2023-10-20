import 'package:flutter/material.dart';
import 'package:your_app_name/models/contact.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EditContactScreen extends StatefulWidget {
  final Contact contact;

  EditContactScreen(this.contact);

  @override
  _EditContactScreenState createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.contact.name;
    phoneController.text = widget.contact.phone;
    emailController.text = widget.contact.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Contato'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                    // Atualize os dados do contato
                    final updatedContact = Contact(
                      objectId: widget.contact.objectId,
                      name: nameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      image: widget.contact.image,
                    );

                    final response = await updatedContact.save();

                    if (response.success) {
                      Navigator.pop(context, updatedContact);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Erro ao atualizar o contato.'),
                      ));
                    }
                  }
                },
                child: Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
