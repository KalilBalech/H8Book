import 'package:flutter/material.dart';
import '../../config/my_colors.dart';
import 'Home.dart';
import 'Perfil.dart';

class PaginaPrincipal extends StatefulWidget {

  final String nomeDeBixo;
  final String turma;

  PaginaPrincipal({this.nomeDeBixo, this.turma});

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {

  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: new Text(
          "H8Book",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontFamily: "DancingScript",
          ),
        ),
        titleSpacing: 0, //it is 16 by default
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.corPrincipal, MyColors.corSecundaria],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
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
            icon: Icon(Icons.person_outline_rounded),
            label: "Perfil",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
      backgroundColor: MyColors.corBasica,
    );
  }
}
