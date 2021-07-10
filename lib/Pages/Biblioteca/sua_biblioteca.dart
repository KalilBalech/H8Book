import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import '../../config/my_colors.dart';

class SuaBiblioteca extends StatefulWidget {
  final String nomeBixo;
  final String turma;

  SuaBiblioteca({this.nomeBixo, this.turma});

  @override
  _SuaBibliotecaState createState() => _SuaBibliotecaState();
}

class _SuaBibliotecaState extends State<SuaBiblioteca> {

  TextEditingController _livro = TextEditingController();
  Stream livros;

  @override
  void initState(){
    livros = FirebaseFirestore.instance.collection("Usuários").doc(widget.nomeBixo+widget.turma).collection("Biblioteca").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      appBar: AppBar(
        titleSpacing: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.corPrincipal, MyColors.corSecundaria],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        leading: Container(),
        title: new Text(
          widget.nomeBixo + widget.turma,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: "CaviarDreams",
          ),
        ),
        backgroundColor: MyColors.corSecundaria,
        actions: [
          IconButton(
            icon: Icon(Icons.navigate_next_rounded),
            iconSize: 25, 
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  PaginaPrincipal()));
            }
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              titulo("Monte a sua biblioteca!"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "- Disponibilize alguns de seus livros!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "CaviarDreams",
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  controller: _livro,
                  decoration: InputDecoration(
                    hintText: "Título do livro",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 29,
                      fontWeight: FontWeight.w400,
                      fontFamily: "DancingScript",
                    ),
                    icon: Icon(Icons.local_library),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: MyColors.corPrincipal,
                      ),
                      onPressed: () {
                        if(_livro.text.isNotEmpty){
                          FirebaseFirestore.instance.collection("Usuários").doc(widget.nomeBixo+widget.turma).collection("Biblioteca").doc(_livro.text).set({'nomeDoLivro' : _livro.text});
                          _livro.text = "";
                        }
                      }
                    )
                  ),
                ),
              ),
              SizedBox(height: 30),
               todosLivros()
            ],
          ),
        ),
      ),
    );
  }

  Widget livro(String nomedolivro){
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
            onPressed: (){
              FirebaseFirestore.instance.collection("Usuários").doc(widget.nomeBixo+widget.turma).collection("Biblioteca").doc(nomedolivro).delete();
            })
        ],
      ),
    );
  }

  Widget todosLivros(){
    return StreamBuilder(
      stream: livros,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        final listaLivros = snapshot.data.docs;
        return Column(
          children: [
            for(int i = 0; i < listaLivros.length; i++)
              livro(listaLivros[i]["nomeDoLivro"]),
          ],
        );
      }
    );
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
        SizedBox(height: 30),
      ],
    ),
  );
}
