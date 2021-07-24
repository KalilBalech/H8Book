import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import '../../config/my_colors.dart';

class SuaBiblioteca extends StatefulWidget {
  final String nomeBixo;
  final String turma;
  final String bloco;
  final String apartamento;
  final String vaga;

  SuaBiblioteca({this.nomeBixo, this.turma, this.bloco, this.apartamento, this.vaga});

  @override
  _SuaBibliotecaState createState() => _SuaBibliotecaState();
}

class _SuaBibliotecaState extends State<SuaBiblioteca> {

  TextEditingController _livroInputController = TextEditingController();
  TextEditingController _autorInputController = TextEditingController();
  bool _dadosInvalidos = false;
  Stream livros;

  @override
  void initState(){
    livros = FirebaseFirestore.instance.collection("Usuários").doc(widget.nomeBixo+widget.turma).collection("Meus Livros").snapshots();
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
                context, MaterialPageRoute(builder: (context) =>  PaginaPrincipal(nomeDeBixo: widget.nomeBixo, turma: widget.turma, bloco: widget.bloco, 
                apartamento: widget.apartamento ,vaga: widget.vaga)
              )
            );
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
                  .doc(widget.nomeBixo + widget.turma)
                  .collection("Meus Livros")
                  .doc(_livroInputController.text)
                  .set({'nome do livro': _livroInputController.text, 'autor': _autorInputController.text, 'dono': widget.nomeBixo, 'disponibilidade': true});
                  FirebaseFirestore.instance.collection("Livros Registrados")
                  .doc(widget.nomeBixo+widget.turma+_livroInputController.text)
                  .set({'nome do livro': _livroInputController.text, 'autor': _autorInputController.text, 'dono': widget.nomeBixo, 'turma do dono': widget.turma, 'disponibilidade': true});
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
              SizedBox(height: 10),
               todosLivros()
            ],
          ),
        ),
      ),
    );
  }

  Widget livro(String nomedolivro, String autor){
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
            onPressed: (){
              FirebaseFirestore.instance.collection("Usuários").doc(widget.nomeBixo+widget.turma).collection("Meus Livros").doc(nomedolivro).delete();
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
              livro(listaLivros[i]["nome do livro"], listaLivros[i]["autor"]),
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
