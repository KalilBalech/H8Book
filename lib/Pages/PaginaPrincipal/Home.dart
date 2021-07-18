import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../config/my_colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _livroInputController = TextEditingController();
  String nomeLivro;
  Stream livros;
  int _contador = 1;

  @override
  void initState() {
    super.initState();
    livros =
        FirebaseFirestore.instance.collection("Livros Registrados").snapshots();

    _livroInputController.addListener(() {
      filtrarLivros();
    });
  }

  lerLivrosFirebase() {
    var dados = FirebaseFirestore.instance.collection("Livros Registrados");
    return dados;
  }

  filtrarLivros() {
    print(_livroInputController.text);
    setState(() {
      if (_livroInputController.text != "") {
        nomeLivro = _livroInputController.text;

        livros = FirebaseFirestore.instance
            .collection("Livros Registrados")
            .where("nome do livro", isEqualTo: nomeLivro)
            .snapshots();
      } else {
        livros = FirebaseFirestore.instance
            .collection("Livros Registrados")
            .snapshots();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                controller: _livroInputController,
                decoration: InputDecoration(
                  hintText: "Procurar livro no H8",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 29,
                    fontWeight: FontWeight.w400,
                    fontFamily: "DancingScript",
                  ),
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            todosLivros(),
          ],
        ),
      ),
    );
  }

  Widget livro(String nomedolivro, bool disp) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        //borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: MyColors.corPrincipal,
          ),
          SizedBox(width: 7),
          Expanded(
            child: Text(
              nomedolivro,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                //fontWeight: FontWeight.w400,
                fontFamily: "CaviarDreams",
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.circle),
              color: disp ? Colors.green : Colors.red,
              onPressed: () {})
        ],
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

  Widget todosLivros() {
    return StreamBuilder(
        stream: livros,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final listaLivros = snapshot.data.docs;
          return Column(
            children: [
              for (int i = 0;
                  i < (listaLivros.length) && (i < _contador * 10);
                  i++)
                livro(listaLivros[i]["nome do livro"],
                    listaLivros[i]["disponibilidade"]),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  child: botao("Mais livros"),
                  onTap: () {
                    setState(() {
                      _contador++;
                    });

                    print(_contador);
                  }),
              SizedBox(
                height: 10,
              ),
            ],
          );
        });
  }
}
