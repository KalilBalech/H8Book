import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import 'package:h_book/config/my_colors.dart';

class MeusLivros extends StatefulWidget {
  MeusLivros();

  @override
  _MeusLivrosState createState() => _MeusLivrosState();
}

class _MeusLivrosState extends State<MeusLivros> {
  TextEditingController _livroInputController = TextEditingController();
  TextEditingController _autorInputController = TextEditingController();
  bool _dadosInvalidos = false;
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
      appBar: AppBar(
          leading: Container(),
          title: new Text(
            nome+turma,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: "CaviarDreams",
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
      backgroundColor: MyColors.corBasica,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: titulo("Meus livros")),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                controller: _livroInputController,
                decoration: InputDecoration(
                  labelText: "Título do livro",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 29,
                    fontWeight: FontWeight.w400,
                    fontFamily: "DancingScript",
                  ),
                  icon: Icon(Icons.local_library_outlined),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                controller: _autorInputController,
                decoration: InputDecoration(
                  labelText: "Autor",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 29,
                    fontWeight: FontWeight.w400,
                    fontFamily: "DancingScript",
                  ),
                  icon: Icon(Icons.person_outline_rounded),
                ),
              ),
            ),
            SizedBox(height: 20),
            _dadosInvalidos
                ? Text(
                    "Insira valores válidos nos campos de texto",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                if (_livroInputController.text.isNotEmpty && _autorInputController.text.isNotEmpty) {
                  FirebaseFirestore.instance
                  .collection("Usuários")
                  .doc(nome + turma)
                  .collection("Meus Livros")
                  .doc(_livroInputController.text)
                  .set({'nome do livro': _livroInputController.text, 'autor': _autorInputController.text, 'dono': nome, 'disponibilidade': true});
                  FirebaseFirestore.instance.collection("Livros Registrados")
                  .doc(nome+turma+_livroInputController.text)
                  .set({'nome do livro': _livroInputController.text, 'autor': _autorInputController.text, 'dono': nome, 'turma do dono': turma, 'disponibilidade': true});
                  _livroInputController.text = "";
                  _autorInputController.text="";
                  setState(() {
                    _dadosInvalidos = false;                             
                  });
                }
                else{
                  setState(() {
                    _dadosInvalidos = true;                             
                  });
                }
              },
              child: Container(
                height: 45,
                width: 200,
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
                      fontSize: 20,
                      fontFamily: "CaviarDreams",
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(height: 10),
            todosLivros()
          ],
        ),
      ),
    );
  }

  Widget livro(String nomedolivro, String autor) {
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
            child: Column(
              children: [
                Text(
                  nomedolivro,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "CaviarDreams",
                  ),
                ),
              Text(
              autor,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                //fontWeight: FontWeight.w400,
                fontFamily: "CaviarDreams",
              ),
            ),
              ],
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
              for (int i = 0; i < listaLivros.length; i++)
                livro(listaLivros[i]["nome do livro"], listaLivros[i]["autor"]),
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
