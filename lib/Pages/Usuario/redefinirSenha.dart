import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_book/Pages/Usuario/reconhecimento.dart';
import 'package:h_book/config/my_colors.dart';

class RedefinirSenha extends StatefulWidget {
  final String nomeDeBixo;
  final String turma;

  RedefinirSenha({this.nomeDeBixo, this.turma});

  @override
  _RedefinirSenhaState createState() => _RedefinirSenhaState();
}

class _RedefinirSenhaState extends State<RedefinirSenha> {
  bool _secureText = true;

  TextEditingController _novaSenha = TextEditingController();
  TextEditingController _confirmarNovaSenha = TextEditingController();

  final _novaSenhaKey = GlobalKey<FormState>();
  final _confirmarNovaSenhaKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      appBar: AppBar(
        leading: Container(),
        titleSpacing: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [MyColors.corPrincipal, MyColors.corSecundaria],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          )),
        ),
        title: Text(
          "Redefinir senha",
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
                  titulo("Redefina sua senha"),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Form(
                      key: _novaSenhaKey,
                      child: TextFormField(
                        validator: (valor) {
                          if (valor.isEmpty) {
                            return 'Redefina sua senha aqui';
                          }
                          if (_novaSenha.text.length < 8) {
                            return "A senha deve ter pelo menos 8 dígitos";
                          }
                          return null;
                        },
                        controller: _novaSenha,
                        obscureText: _secureText,
                        decoration: InputDecoration(
                          labelText: "Nova Senha",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 29,
                            fontWeight: FontWeight.w400,
                            fontFamily: "DancingScript",
                          ),
                          icon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_secureText
                                ? Icons.security
                                : Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                _secureText = !_secureText;
                              });
                            },
                          ),
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
                      key: _confirmarNovaSenhaKey,
                      child: TextFormField(
                        validator: (valor) {
                          if (valor.isEmpty) {
                            return 'Repita a sua senha aqui';
                          }
                          if (_novaSenha.text != _confirmarNovaSenha.text) {
                            return "Confirmação de senha inválida";
                          }
                          return null;
                        },
                        controller: _confirmarNovaSenha,
                        obscureText: _secureText,
                        decoration: InputDecoration(
                          labelText: "Confirmar senha",
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 29,
                            fontWeight: FontWeight.w400,
                            fontFamily: "DancingScript",
                          ),
                          icon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_secureText
                                ? Icons.security
                                : Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                _secureText = !_secureText;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(height: 130),
                  GestureDetector(
                      onTap: () {
                        if (_novaSenhaKey.currentState.validate() &&
                            _confirmarNovaSenhaKey.currentState.validate()) {
                          FirebaseFirestore.instance.collection("Usuários").doc(widget.nomeDeBixo + widget.turma).update({"Senha": _novaSenha.text});
                          Fluttertoast.showToast(
                            msg: "Senha redefinida com sucesso!",
                            backgroundColor: MyColors.corPrincipal,
                            textColor: MyColors.corSecundaria,
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            fontSize: 16
                          );
                          Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) =>  Reconhecimento()
                          ));
                        }
                      },
                      child: botao("Redefinir Senha")),
                ],
              ),
            ),
          ),
        ),
      ),
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
        SizedBox(height: 120),
      ],
    ),
  );
}