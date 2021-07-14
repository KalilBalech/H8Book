import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/config/my_colors.dart';
import 'redefinirSenha.dart';

class RecuperarSenha extends StatefulWidget {
  final String nomeDeBixo;
  final String turma;

  RecuperarSenha({this.nomeDeBixo, this.turma});

  @override
  _RecuperarSenhaState createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  final _emailKey = GlobalKey<FormState>();
  final _nomeDeBixoKey = GlobalKey<FormState>();
  final _turmaKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _nomeDeBixo = TextEditingController();
  TextEditingController _turma = TextEditingController();

  bool _dadosIncorretos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      appBar: AppBar(
        titleSpacing: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.navigate_before_rounded),
                onPressed: () {
                  Navigator.pop(context);
                });
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [MyColors.corPrincipal, MyColors.corSecundaria],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          )),
        ),
        title: Text(
          "Recuperação de senha",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: "CaviarDreams",
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                titulo("Passa no ITA, mas não lembra uma senha..."),
                Text(
                  "Preencha seus dados",
                  style: TextStyle(
                    color: MyColors.corPrincipal,
                    fontSize: 35,
                    fontWeight: FontWeight.w400,
                    fontFamily: "DancingScript",
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: _nomeDeBixoKey,
                    child: TextFormField(
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Escreva o seu nome aqui';
                        }
                        return null;
                      },
                      controller: _nomeDeBixo,
                      decoration: InputDecoration(
                        labelText: "Nome de bixo",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 29,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DancingScript",
                        ),
                        icon: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: _turmaKey,
                    child: TextFormField(
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Escreva a sua turma aqui';
                        }
                        return null;
                      },
                      controller: _turma,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: InputDecoration(
                        labelText: "Turma (Ex: 25)",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 29,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DancingScript",
                        ),
                        icon: Icon(Icons.group_rounded),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: _emailKey,
                    child: TextFormField(
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Escreva seu email';
                        }
                        if (!valor.contains("@")) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                      controller: _email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 29,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DancingScript",
                        ),
                        icon: Icon(Icons.email_outlined),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                _dadosIncorretos
                    ? Container(
                        child: Text(
                          "Dados incorretos",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "CaviarDreams",
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 10),
                GestureDetector(
                    onTap: () {
                      FirebaseFirestore.instance.collection('Usuários').doc(_nomeDeBixo.text+_turma.text).get().then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists && documentSnapshot['Email'] == _email.text) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  RedefinirSenha(nomeDeBixo: _nomeDeBixo.text, turma: _turma.text)
                        ));
                      } 
                        else {
                          setState(() {
                            _dadosIncorretos = true;
                          });
                        }
                      });
                    },
                    child: botao("Recuperar Senha")),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget botao(String texto) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [MyColors.corPrincipal, MyColors.corSecundaria],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      height: 45,
      width: 230,
      child: Center(
        child: Text(
          texto,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: "CaviarDreams",
          ),
        ),
      ),
    );
  }
}

Widget titulo(String texto) {
  return Container(
    child: Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            texto,
            style: TextStyle(
              color: MyColors.corPrincipal,
              fontSize: 40,
              fontFamily: "DancingScript",
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}