import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_book/Pages/PaginaPrincipal/MeusLivros.dart';
import '../../config/my_colors.dart';
import 'Perfil.dart';
import 'Home.dart';

String nome = "";
String turma = "";
String bloco = "";
String apartamento = "";
String vaga = "";

class PaginaPrincipal extends StatefulWidget {
  final String nomeDeBixo;
  final String turma;

  PaginaPrincipal({this.nomeDeBixo, this.turma});

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int _selectedIndex = 0;
  DateTime timeBackPressed = DateTime.now();

  final List<Widget> _children = [
    Home(),
    MeusLivros(),
    Perfil(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    nome = widget.nomeDeBixo;
    turma = widget.turma;

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if(isExitWarning){
          final message = 'Pressione novamente para sair';
          Fluttertoast.showToast(
            msg: message,
            backgroundColor: Colors.white,
            textColor: MyColors.corPrincipal,
            fontSize: 18
            );
          return false;
        }
        else{
          Fluttertoast.cancel();
          exit(0);
        }
      },
      child: Scaffold(
        body: Container(
          child: _children[_selectedIndex],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          color: MyColors.corPrincipal,
          backgroundColor: MyColors.corBasica,
          buttonBackgroundColor: MyColors.corPrincipal,
          animationDuration: Duration(milliseconds: 350),
          animationCurve: Curves.bounceInOut,
          items: [
            Icon(
              Icons.home,
              color: Colors.black,
            ),
            Icon(
              Icons.local_library,
              color: Colors.black
              ),
            Icon(
              Icons.person_outline_rounded,
              color: Colors.black
              ),
          ],
          onTap: _onItemTap,
        ),
        backgroundColor: MyColors.corBasica,
      ),
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
}
