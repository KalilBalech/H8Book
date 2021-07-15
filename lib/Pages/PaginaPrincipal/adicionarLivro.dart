import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import 'package:h_book/config/my_colors.dart';

class AdicionarLivro extends StatefulWidget {
  AdicionarLivro();

  @override
  _AdicionarLivroState createState() => _AdicionarLivroState();
}

class _AdicionarLivroState extends State<AdicionarLivro> {
  TextEditingController _livroInputController = TextEditingController();
  TextEditingController _autorInputController = TextEditingController();
  bool livroErro = false;

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
      body: SafeArea(
        child: Column(
          children: [
            titulo("Adicionar Livro"),
            SizedBox(
              height: 10,
            ),
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
                  hintText: "Título do livro",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 29,
                    fontWeight: FontWeight.w400,
                    fontFamily: "DancingScript",
                  ),
                  icon: Icon(Icons.local_library),
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
                  hintText: "Autor",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 29,
                    fontWeight: FontWeight.w400,
                    fontFamily: "DancingScript",
                  ),
                  icon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 30),
            livroErro
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
                if (_livroInputController.text.isNotEmpty &&
                    _autorInputController.text.isNotEmpty) {
                  registrarLivro(
                    _livroInputController.text,
                    _autorInputController.text,
                    nome,
                    turma,
                  );
                  setState(() {
                    livroErro = false;
                    _livroInputController.text = "";
                    _autorInputController.text = "";
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaginaPrincipal()));
                } else {
                  setState(() {
                    livroErro = true;
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
          ],
        ),
      ),
    );
  }

  void registrarLivro(
      String nomeLivro, String autorLivro, String nomedebixo, String turma) {
    var informacoesLivro = {
      "nome do livro": nomeLivro,
      "autor": autorLivro,
      "dono": nomedebixo,
      "disponibilidade": true
    };

    //salvando na coleção de todos os livros
    FirebaseFirestore.instance
        .collection("Livros Registrados")
        .doc(nome + turma + _livroInputController.text)
        .set(informacoesLivro);

    //salvando na coleção com os livros de cada usuário
    FirebaseFirestore.instance
        .collection("Usuários")
        .doc(nome + turma)
        .collection("Meus Livros")
        .doc(nomeLivro)
        .set(informacoesLivro);
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
