import 'package:flutter/material.dart';
import 'package:h_book/Pages/Usuario/reconhecimento.dart';
import '../../config/my_colors.dart';

class Perfil extends StatefulWidget {
  Perfil();

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: titulo("Perfil")),
              GestureDetector(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Container(
                  height: 45,
                  width: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [MyColors.corPrincipal, MyColors.corSecundaria],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 29,
                        fontFamily: "CaviarDreams",
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continuaButton = FlatButton(
    child: Text("Continar"),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Reconhecimento()));
    },
  );
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: MyColors.corSecundaria,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Text("Deseja fazer o Logout?"),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget botao(String texto) {
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
              fontSize: 41,
              fontFamily: "DancingScript",
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}
