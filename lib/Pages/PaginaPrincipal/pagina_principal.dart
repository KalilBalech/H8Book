import 'package:flutter/material.dart';
import '../../config/my_colors.dart';
import 'Home.dart';
import 'Biblioteca.dart';

class PaginaPrincipal extends StatefulWidget {

  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {

  
  //TextEditingController _nomeDeBixoInputController = TextEditingController();
  //TextEditingController _livroInputController = TextEditingController();

  int _selectedIndex = 0;
  List<Widget>_widgetOptions = <Widget>[
    Home(),
    Biblioteca(),
  ];

  void _onItemTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: new Text("H8Book",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontFamily: "DancingScript",  
          ),
        ),
        titleSpacing: 0,//it is 16 by default
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
            label:  "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label:  "Biblioteca",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
      backgroundColor: MyColors.corBasica,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

