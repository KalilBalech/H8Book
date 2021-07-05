import 'package:flutter/material.dart';
import '../Usuario/reconhecimento.dart';
import '../../config/my_colors.dart';

class WelcomePage extends StatelessWidget {
  get children => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.corSecundaria,
        child: Icon(
          Icons.navigate_next_rounded,
          color: MyColors.corPrincipal,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Reconhecimento()));
        },
      ),
      backgroundColor: MyColors.corBasica,
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(height: 50),
            Text(
              "H8BooK",
              style: TextStyle(
                color: MyColors.corPrincipal,
                fontSize: 110,
                fontFamily: "DancingScript",
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Ninguém cresce sozinho\nDe iteano para iteano\nCompartilhe livros!",
              style: TextStyle(
                color: MyColors.corPrincipal,
                fontSize: 30,
                fontFamily: "DancingScript",
              ),
            ),
            /*SizedBox(height: 250),
              GestureDetector(
                onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Reconhecimento()
                      ));
                    },
                child: botao("avançar ->")
              )*/
          ]),
        ),
      ),
    );
  }
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
          fontSize: 30,
          fontFamily: "DancingScript",
        ),
      ),
    ),
  );
}
