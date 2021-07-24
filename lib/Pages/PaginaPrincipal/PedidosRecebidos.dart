import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import 'package:h_book/config/my_colors.dart';
import 'Home.dart';

class PedidosRecebidos extends StatefulWidget {
  final String nomeDeBixo;
  final String turma;

  PedidosRecebidos({this.nomeDeBixo, this.turma});
  @override
  _PedidosRecebidosState createState() => _PedidosRecebidosState();
}

class _PedidosRecebidosState extends State<PedidosRecebidos> {
  Stream mensagens;

  @override
  void initState() {
    mensagens = FirebaseFirestore.instance
        .collection("Usuários")
        .doc(widget.nomeDeBixo + widget.turma)
        .collection("Pedidos recebidos")
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.navigate_before_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
        title: new Text(
          widget.nomeDeBixo + widget.turma,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: titulo("Pedidos recebidos")),
              SizedBox(height: 20),
              todasMensagens()
            ],
          ),
        ),
      ),
    );
  }

  Widget mensagem(String pedinte, String turmaDoPedinte, String nomeDoLivro,
      String autor, String blocoDono, String apartDono, String vagaDono) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.corBasica,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: MyColors.corPrincipal)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: MyColors.corPrincipal,
            size: 40,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Text(
                  "$pedinte$turmaDoPedinte gostaria de pegar o seu livro $nomeDoLivro emprestado :)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "CaviarDreams",
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        // height: 45,
                        // width: 230,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyColors.corPrincipal,
                              MyColors.corSecundaria
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          "Autorizar",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "CaviarDreams",
                          ),
                        ),
                      ),
                      onTap: () {
                        homeState.setState(() {
                          homeState.numPedidos--;
                        });
                        setState(() {
                          FirebaseFirestore.instance
                              .collection("Usuários")
                              .doc(widget.nomeDeBixo + widget.turma)
                              .collection("Pedidos recebidos")
                              .doc(nomeDoLivro + pedinte + turmaDoPedinte)
                              .delete();
                        });
                        FirebaseFirestore.instance
                            .collection("Livros Registrados")
                            .doc(nome + turma + nomeDoLivro)
                            .update({'disponibilidade': false});
                        FirebaseFirestore.instance
                            .collection("Usuários")
                            .doc(nome + turma)
                            .collection("Meus Livros")
                            .doc(nomeDoLivro)
                            .update({'disponibilidade': false});
                        FirebaseFirestore.instance
                            .collection("Usuários")
                            .doc(pedinte + turmaDoPedinte)
                            .collection("Pedidos enviados")
                            .doc(nomeDoLivro + widget.nomeDeBixo + widget.turma)
                            .set({
                          'nome do livro': nomeDoLivro,
                          'dono do livro': widget.nomeDeBixo,
                          'turma do dono': widget.turma,
                          'resposta': 'autorizado',
                          'bloco do dono': blocoDono,
                          'apartamento do dono': apartDono,
                          'vaga do dono': vagaDono
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        // height: 45,
                        // width: 230,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyColors.corPrincipal,
                              MyColors.corSecundaria
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          "Negar",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "CaviarDreams",
                          ),
                        ),
                      ),
                      onTap: () {
                        homeState.setState(() {
                          homeState.numPedidos--;
                        });
                        setState(() {
                          FirebaseFirestore.instance
                              .collection("Usuários")
                              .doc(widget.nomeDeBixo + widget.turma)
                              .collection("Pedidos recebidos")
                              .doc(nomeDoLivro + pedinte + turmaDoPedinte)
                              .delete();
                        });
                        FirebaseFirestore.instance
                            .collection("Usuários")
                            .doc(pedinte + turmaDoPedinte)
                            .collection("Pedidos enviados")
                            .doc(nomeDoLivro + widget.nomeDeBixo + widget.turma)
                            .set({
                          'nome do livro': nomeDoLivro,
                          'dono do livro': widget.nomeDeBixo,
                          'turma do dono': widget.turma,
                          'resposta': 'negado',
                          'bloco do dono': blocoDono,
                          'apartamento do dono': apartDono,
                          'vaga do dono': vagaDono
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget todasMensagens() {
    int i;
    return StreamBuilder(
        stream: mensagens,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final listaMensagens = snapshot.data.docs;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (i = 0; i < listaMensagens.length; i++)
                mensagem(
                    listaMensagens[i]["pedinte"],
                    listaMensagens[i]["turma do pedinte"],
                    listaMensagens[i]["nome do livro"],
                    listaMensagens[i]["autor"],
                    listaMensagens[i]["bloco do pedinte"],
                    listaMensagens[i]["apartamento do pedinte"],
                    listaMensagens[i]["vaga do pedinte"]),
              i == 0
                  ? Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          " $nome, você não possui solicitações pendentes...",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "CaviarDreams",
                          ),
                        ),
                      ),
                    )
                  : Container()
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
