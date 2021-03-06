import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/components/common_field.dart';
import 'package:bytebank/models/contato.dart';

class ContatosForm extends StatefulWidget {
  @override
  _ContatosFormState createState() => _ContatosFormState();
}

class _ContatosFormState extends State<ContatosForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContatoDao _contatoDao = ContatoDao();

  static const String _appBarTitle = 'Novo contato';
  static const String _fieldName = 'Full name';
  static const String _fieldAccount = 'Account number';
  static const String _buttonText = 'Create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
        ),
        body: _formBody());
  }

  Widget _formBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CommonField(
              label: _fieldName,
              controller: _fullNameController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CommonField(
                label: _fieldAccount,
                controller: _accountNumberController,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: _criarContatoButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _criarContatoButton(BuildContext context) {
    return RaisedButton(
      child: Text(_buttonText),
      onPressed: () {
        final int id = 9;
        final String name = _fullNameController.text.toString();
        final int accountNumber = int.tryParse(_accountNumberController.text);
        final Contato contato = Contato(id, name, accountNumber);

        _contatoDao.save(contato).then((id) => Navigator.pop(context));
      },
    );
  }
}
