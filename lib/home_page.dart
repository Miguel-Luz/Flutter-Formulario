import 'package:cnpj_cpf_formatter/cnpj_cpf_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Entities/Usuario.dart';
import 'helpers/helpers.dart';
import 'helpers/validation.dart';
import 'Entities/Adress.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _form = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();

  String name;
  String email;
  String cpf;
  String cep;
  String rua;
  String numero;
  String bairro;
  String cidade;
  String uf;
  String pais;

  final mailController = TextEditingController();
  final cepController = TextEditingController();
  final ruaController = TextEditingController();
  final bairroController = TextEditingController();
  final localidadeController = TextEditingController();
  final ufController = TextEditingController();

  @override
  void dispose() {
    mailController.dispose();
    cepController.dispose();
    ruaController.dispose();
    bairroController.dispose();
    localidadeController.dispose();
    ufController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text(
          'Formulário de Cadastro',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 130,
                    height: 130,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(getAvatar(email)),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nome',
                            ),
                            validator: (value) => validationName(value),
                            onSaved: (value) => name = value,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                            controller: mailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (value) => validationMail(value),
                            onSaved: (value) => email = value,
                            inputFormatters: [
                              LowerCaseTextFormatter(),
                            ]),
                      ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Cpf',
                            ),
                            validator: (value) => validationCpf(value),
                            inputFormatters: [
                              CnpjCpfFormatter(
                                eDocumentType: EDocumentType.CPF,
                              )
                            ],
                            onSaved: (value) => cpf = value,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Cep',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            controller: cepController,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp('[0-9]'))
                            ],
                            validator: (value) => validationCep(value),
                            onSaved: (value) => cep = value,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FlatButton.icon(
                          icon: Icon(Icons.search),
                          label: Text('Buscar CEP'),
                          color: Colors.grey[300],
                          onPressed: () async {
                            var result = validationCep(cepController.text);
                            if (result != null) {
                              messageSnackBar(_scaffold, result);
                              return;
                            }

                            Adress _cep =
                                await getAdressByCep(cepController.text);

                            if (_cep.error) {
                              messageSnackBar(_scaffold, 'Cep não localizado');
                              return;
                            }

                            localidadeController.text =
                                _cep.cidade ?? localidadeController.text;
                            bairroController.text =
                                _cep.bairro ?? bairroController.text;
                            ruaController.text = _cep.rua ?? ruaController.text;
                            ufController.text = _cep.uf ?? ufController.text;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextFormField(
                              controller: ruaController,
                              decoration: InputDecoration(
                                  labelText: 'Rua',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              validator: (value) => validationAdress(value),
                              onSaved: (value) => rua = value,
                            ),
                          )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Número',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            validator: (value) => localNumber(value),
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp('[0-9]'))
                            ],
                            onSaved: (value) => numero = value,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            controller: bairroController,
                            decoration: InputDecoration(
                                labelText: 'Bairro',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            validator: (value) => validationBairro(value),
                            onSaved: (value) => bairro = value,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            controller: localidadeController,
                            decoration: InputDecoration(
                                labelText: 'Cidade',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            validator: (value) => validationCity(value),
                            onSaved: (value) => cidade = value,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            controller: ufController,
                            decoration: InputDecoration(
                                labelText: 'UF',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            validator: (value) => validationUf(value),
                            onSaved: (value) => uf = value,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'País',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            validator: (value) => validationCountry(value),
                            onSaved: (value) => pais = value,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FlatButton(
                            onPressed: () => _form.currentState.reset(),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text('Limpar'),
                            ),
                            textColor: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 3,
                                    color: Theme.of(context).accentColor)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FlatButton(
                            onPressed: () {
                              if (_form.currentState.validate()) {
                                _form.currentState.save();
                                setState(() {});
                                Adress userAdress = Adress(
                                    cep, rua, numero, bairro, cidade, uf, pais);
                                Usuario user = Usuario(name, email,
                                    getAvatar(email), cpf, userAdress);
                                showUser(context, user);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text('Cadastrar'),
                            ),
                            textColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 3,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
