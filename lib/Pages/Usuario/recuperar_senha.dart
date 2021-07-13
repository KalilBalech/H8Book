import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/config/my_colors.dart';

class RecuperarSenha extends StatefulWidget {

  final String nomeDeBixo;
  final String turma;

  RecuperarSenha({this.nomeDeBixo, this.turma});

  @override
  _RecuperarSenhaState createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(
              icon: Icon(Icons.navigate_before_rounded), 
              onPressed: (){
                Navigator.pop(context);
              }
            );
          },
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
        title: Text("Recuperação de senha",
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
            child: Column(
              children: [
                SizedBox(height: 10),
                titulo("Passa no ITA, mas não lembra uma senha...")
                Text(FirebaseFirestore.instance.collection("Usuários").doc(widget.nomeDeBixo+widget.turma).get("email"))
              ],
            ),
          ),
        )
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

