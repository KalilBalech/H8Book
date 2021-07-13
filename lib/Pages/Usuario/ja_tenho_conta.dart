import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import '../../config/my_colors.dart';
import 'recuperar_senha.dart';

class JaTenhoConta extends StatefulWidget {

  @override
  _JaTenhoContaState createState() => _JaTenhoContaState();
}

class _JaTenhoContaState extends State<JaTenhoConta> {

  TextEditingController _nomeDeBixoInputController = TextEditingController();
  TextEditingController _senhaInputController = TextEditingController();
  TextEditingController _turmaInputController = TextEditingController();

  bool _secureText = true;
  bool continuarConectado = false;
  bool _loginInvalido = false;

  String _senhaIncompativel;
  String nomeDeBixo;
  String turma;
  Stream usuariosCadastrados;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.navigate_before_rounded),
              onPressed: () { 
                Navigator.pop(context);
              },
            );
          }
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.corPrincipal, MyColors.corSecundaria],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ) 
          ),
        ),
        title: Text("Já tenho conta",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: "CaviarDreams",
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: MyColors.corBasica,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                titulo("Alto lá. Identifique-se!"),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _nomeDeBixoInputController,
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _turmaInputController,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: InputDecoration(
                      labelText: "Turma",
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 5),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    child: TextField(
                      controller: _senhaInputController,
                      obscureText: _secureText,
                      decoration: InputDecoration(
                        errorText: _senhaIncompativel,
                        labelText: "Senha",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 29,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DancingScript",
                        ),
                        icon: Icon(Icons.lock), 
                        suffixIcon: IconButton(
                          icon: Icon(
                            _secureText ? Icons.security : Icons.remove_red_eye),
                            onPressed: (){
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
                  margin: EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end ,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => RecuperarSenha()
                          ));
                        },
                        child: Text("Esqueceu a senha?",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "CaviarDreams", 
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                SizedBox(height: 40),
                _loginInvalido ? Text("Nome de Bixo, turma ou senha inválido(s)",
                style: TextStyle(
                  fontFamily: "CaviarDreams",
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 15,
                ),
                ) : Container(),
                /*SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      Checkbox(
                        value: continuarConectado, 
                        onChanged: (bool novoValor){
                          setState(() {
                            continuarConectado = novoValor;      
                          });
                        },
                        activeColor: MyColors.corSecundaria,
                      ),
                      Text("Continuar Conectado?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                          fontFamily: "CaviarDreams",
                        ),
                      )
                    ],
                  ),
                ),*/
                SizedBox(height:20),
                GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance.collection('Usuários').doc(_nomeDeBixoInputController.text+_turmaInputController.text).get().then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists && documentSnapshot['Senha'] == _senhaInputController.text) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  PaginaPrincipal(nomeDeBixo: _nomeDeBixoInputController.text, turma: _turmaInputController.text)
                        ));
                      }
                      else 
                        setState(() {
                            _loginInvalido = true;            
                        });
                    });
                  },
                  child: botao("Avançar ->"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget titulo (String texto){
  return Container(
    child: Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(texto,
            style: TextStyle(
              color: MyColors.corPrincipal,
              fontSize: 40,
              fontFamily: "DancingScript",
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    ),
  );
}

TextEditingController textEditingController = TextEditingController();

Widget campoDeTexto (String texto){
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[400],
      borderRadius: BorderRadius.circular(20),
    ),
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: texto,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 29,
          fontWeight: FontWeight.w400,
          fontFamily: "DancingScript",
        ),
      ),
    ),
  );
}

Widget botao (String texto){
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [MyColors.corPrincipal, MyColors.corSecundaria],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
    height: 45,
    width: 180,
    child: Center(
      child: Text(texto,
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontFamily: "CaviarDreams",
        ),
      ),
    ),
  );
}