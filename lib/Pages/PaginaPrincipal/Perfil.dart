import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import '../../config/my_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Perfil extends StatefulWidget {
  Perfil();

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  TextEditingController _livroInputController = TextEditingController();
  TextEditingController _autorInputController = TextEditingController();
  bool livroErro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              titulo("Seu perfil"),
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
                      "Insira um valor válido no livro e autor",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 30,
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
                    Fluttertoast.showToast(
                        msg: "Livro adicionado com sucesso!",
                        backgroundColor: MyColors.corPrincipal,
                        textColor: MyColors.corSecundaria,
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        fontSize: 16);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaginaPrincipal(
                                  nomeDeBixo: nome,
                                  turma: turma,
                                )));
                  } else {
                    setState(() {
                      livroErro = true;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [MyColors.corPrincipal, MyColors.corSecundaria],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(10),
                  child: Row(children: [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    Text(
                      "Adicionar livro ao seu Perfil",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 29,
                        fontFamily: "DancingScript",
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
}

void registrarLivro(
    String nomeLivro, String autorLivro, String nomedebixo, String turma) {
  var informacoesLivro = {
    "nomelivro": nomeLivro,
    "autor": autorLivro,
    "dono": nomedebixo,
  };

  //salvando na coleção de todos os livros
  FirebaseFirestore.instance
      .collection("Livros Registrados")
      .doc(nomeLivro)
      .set(informacoesLivro);

  //salvando na coleção com os livros de cada usuário
  FirebaseFirestore.instance
      .collection("Usuários")
      .doc(nome + turma)
      .collection("MeusLivros")
      .doc(nomeLivro)
      .set(informacoesLivro);
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
