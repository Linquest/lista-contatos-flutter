import 'package:flutter/material.dart';
import 'package:your_app_name/models/contact.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:your_app_name/screens/contact_details.dart';
import 'package:your_app_name/screens/add_contact.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = []; // Carregue a lista de contatos do Back4App aqui

  @override
  void initState() {
    super.initState();
    loadContacts(); // Carregue os contatos quando a tela for iniciada
  }

  Future<void> loadContacts() async {
    // Implemente a lógica para carregar a lista de contatos do Back4App
    // Certifique-se de configurar corretamente o Parse Server no início do seu aplicativo
    final queryBuilder = QueryBuilder<Contact>(ParseObject('Contact'))
      ..orderByAscending('name');

    final apiResponse = await queryBuilder.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        contacts = apiResponse.results.map((e) => Contact.fromApi(e)).toList();
      });
    } else {
      // Trate erros de carregamento de contatos, se houver
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
      ),
      body: contacts.isEmpty
          ? Center(child: Text('Nenhum contato disponível.'))
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  leading: CircleAvatar(
                    backgroundImage: contact.image != null
                        ? NetworkImage(contact.image.url)
                        : AssetImage('assets/default_avatar.png'),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactDetailsScreen(contact),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
