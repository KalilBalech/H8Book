import 'package:flutter/material.dart';
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
  final String bloco;
  final String apartamento;
  final String vaga;

  PaginaPrincipal({this.nomeDeBixo, this.turma, this.bloco, this.apartamento, this.vaga});

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int _selectedIndex = 0;

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
    bloco = widget.bloco;
    apartamento = widget.apartamento;
    vaga = widget.vaga;


    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Container(
          child: _children[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: MyColors.corPrincipal,
          backgroundColor: MyColors.corBasica,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              label: "Meus livros",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: "Perfil",
            ),
          ],
          currentIndex: _selectedIndex,
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
