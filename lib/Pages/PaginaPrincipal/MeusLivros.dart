import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import 'package:h_book/config/my_colors.dart';
import 'adicionarLivro.dart';

class MeusLivros extends StatefulWidget {
  MeusLivros();

  @override
  _MeusLivrosState createState() => _MeusLivrosState();
}

class _MeusLivrosState extends State<MeusLivros> {
  Stream livros;

  @override
  void initState() {
    livros = FirebaseFirestore.instance
        .collection("Usuários")
        .doc(nome + turma)
        .collection("Meus Livros")
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              titulo("Meus livros"),
              todosMeusLivros(),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdicionarLivro()));
                },
                child: Container(
                  height: 45,
                  width: 230,
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
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    Text(
                      "Adicionar livro",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: "CaviarDreams",
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget livro(String nomedolivro) {
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
              icon: Icon(Icons.delete_outlined),
              color: Colors.grey,
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("Usuários")
                    .doc(nome + turma)
                    .collection("Meus Livros")
                    .doc(nomedolivro)
                    .delete();
                FirebaseFirestore.instance
                    .collection("Livros Registrados")
                    .doc(nome + turma + nomedolivro)
                    .delete();
              })
        ],
      ),
    );
  }

  Widget todosMeusLivros() {
    return StreamBuilder(
        stream: livros,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final listaLivros = snapshot.data.docs;
          return Column(
            children: [
              for (int i = 0; i < listaLivros.length; i++)
                livro(listaLivros[i]["nome do livro"]),
            ],
          );
        });
  }
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
