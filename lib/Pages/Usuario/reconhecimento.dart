import 'package:flutter/material.dart';
import 'package:h_book/Pages/Usuario/ja_tenho_conta.dart';
import 'package:h_book/Pages/Usuario/novo_usuario.dart';
import '../../config/my_colors.dart';

class Reconhecimento extends StatefulWidget {
  @override
  _ReconhecimentoState createState() => _ReconhecimentoState();
}

class _ReconhecimentoState extends State<Reconhecimento> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: MyColors.corBasica,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        "Diz aí, iteano!",
                        style: TextStyle(
                          color: MyColors.corPrincipal,
                          fontSize: 45,
                          fontFamily: "DancingScript",
                        ),
                      ),
                      Text(
                        "A gente já se conhece?",
                        style: TextStyle(
                          color: MyColors.corPrincipal,
                          fontSize: 43,
                          fontFamily: "DancingScript",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 170),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  NovoUsuario()
                          ));
                        },
                        child: botao("Novo usuário")
                      ),
                    SizedBox(height: 30),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)  => JaTenhoConta()
                          ));
                        },
                        child: botao("Já tenho conta")
                    ),
                    //Image.asset('assets/images/harry_potter.png'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget botao(String texto) {
  return Container(
    width: 230,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [MyColors.corPrincipal, MyColors.corSecundaria],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
    margin: EdgeInsets.only(left: 10),
    padding: EdgeInsets.all(10),
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
