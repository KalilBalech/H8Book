import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/config/my_colors.dart';
import 'Home.dart';

class Notificacoes extends StatefulWidget {
  final String nomeDeBixo;
  final String turma;

  Notificacoes({this.nomeDeBixo, this.turma});
  @override
  _NotificacoesState createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  Stream notificacoes;

  @override
  void initState() {
    notificacoes = FirebaseFirestore.instance
        .collection("Usuários")
        .doc(widget.nomeDeBixo + widget.turma)
        .collection("Pedidos enviados")
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
              Center(child: titulo("Notificações")),
              SizedBox(height: 20),
              todasNotificacoes()
            ],
          ),
        ),
      ),
    );
  }

  Widget notificacao(String dono, String turmaDoDono, String nomeDoLivro,
      String blocoDono, String apartDono, String vagaDono, String resposta) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.corBasica,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: MyColors.corPrincipal)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          resposta == 'autorizado'
              ? Icon(
                  Icons.check_circle,
                  color: MyColors.corPrincipal,
                  size: 40,
                )
              : Icon(
                  Icons.dangerous,
                  color: MyColors.corPrincipal,
                  size: 40,
                ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                resposta == 'autorizado'
                    ? Text(
                        "$dono$turmaDoDono autorizou a retirada do livro $nomeDoLivro. Se dirija ao bloco $blocoDono, apartamento $apartDono, vaga $vagaDono. Recomendamos um prazo de cerca de 20 dias para que você devolva o livro para o(a) $dono. Por favor, tente respeitar esse prazo. Mais uma coisa: APENAS CLIQUE NO BOTÃO ABAIXO quando devolver o livro ao dono, para, assim, reconsiderarmos ele como disponível para empréstimo novamente em nossa base de dados. BOA LEITURA!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "CaviarDreams",
                        ),
                      )
                    : Text(
                        "$dono$turmaDoDono negou a retirada do livro $nomeDoLivro :( Tente pegar emprestado com alguém legal :)",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "CaviarDreams",
                        ),
                      ),
                GestureDetector(
                  child: Container(
                    // height: 45,
                    // width: 230,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [MyColors.corPrincipal, MyColors.corSecundaria],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: resposta == 'autorizado'
                        ? Text(
                            "Já devolvi",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "CaviarDreams",
                            ),
                          )
                        : Text(
                            "Ok",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "CaviarDreams",
                            ),
                          ),
                  ),
                  onTap: () {
                    homeState.setState(() {
                      homeState.numNotificacoes--;
                    });
                    setState(() {
                      FirebaseFirestore.instance
                          .collection("Usuários")
                          .doc(widget.nomeDeBixo + widget.turma)
                          .collection("Pedidos enviados")
                          .doc(nomeDoLivro + dono + turmaDoDono)
                          .delete();
                    });
                    FirebaseFirestore.instance
                        .collection("Usuários")
                        .doc(dono + turmaDoDono)
                        .collection("Meus Livros")
                        .doc(nomeDoLivro)
                        .update({"disponibilidade": true});
                    FirebaseFirestore.instance
                        .collection("Livros Registrados")
                        .doc(dono + turmaDoDono + nomeDoLivro)
                        .update({"disponibilidade": true});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget todasNotificacoes() {
    int i;
    return StreamBuilder(
        stream: notificacoes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final listaNotificacoes = snapshot.data.docs;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (i = 0; i < listaNotificacoes.length; i++)
                notificacao(
                    listaNotificacoes[i]["dono do livro"],
                    listaNotificacoes[i]["turma do dono"],
                    listaNotificacoes[i]["nome do livro"],
                    listaNotificacoes[i]["bloco do dono"],
                    listaNotificacoes[i]["apartamento do dono"],
                    listaNotificacoes[i]["vaga do dono"],
                    listaNotificacoes[i]["resposta"]),
              i == 0
                  ? Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          " ${widget.nomeDeBixo}, você não possui notificações pendentes...",
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
