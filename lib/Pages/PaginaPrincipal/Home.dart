import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import '../../config/my_colors.dart';
import 'Notificacoes.dart';
import 'PedidosRecebidos.dart';

_HomeState homeState;

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    homeState = _HomeState();
    return homeState;
  }
}

class _HomeState extends State<Home> {
  TextEditingController _livroInputController = TextEditingController();
  String nomeLivro;
  Stream livros;
  int numPedidos;
  int numNotificacoes;
  //Future _livrosLidos;
  //List _todosOsLivros = [];
  //List _listaPesquisa = [];
  Stream todosDados;
  int _contador = 1;

  @override
  void initState() {
    super.initState();
    livros =
        FirebaseFirestore.instance.collection("Livros Registrados").snapshots();
    todosDados = FirebaseFirestore.instance
        .collection('Usuários')
        .doc(nome + turma)
        .snapshots();

    contarPedidos();
    contarNotificacoes();
    _livroInputController.addListener(() {
      filtrarLivros();
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _livrosLidos = lerLivros();
  // }

  //retirar o listener ao sair da página.. tornar app mais leve
  // @override
  // void dispose() {
  //   _livroInputController.removeListener(filtrarLivros());
  //   _livroInputController.dispose();
  //   super.dispose();
  // }

  void contarPedidos() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection("Usuários")
        .doc(nome + turma)
        .collection("Pedidos recebidos")
        .get();
    List myDocCount = _myDoc.docs;
    setState(() {
      numPedidos = myDocCount.length;
    });
  }

  void contarNotificacoes() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection("Usuários")
        .doc(nome + turma)
        .collection("Pedidos enviados")
        .get();
    List myDocCount = _myDoc.docs;
    setState(() {
      numNotificacoes = myDocCount.length;
    });
  }

  // lerLivros() async {
  //   var data =
  //       await FirebaseFirestore.instance.collection("Livros Registrados").get();

  //   // setState(() {
  //   //   _todosOsLivros = data.docs;
  //   // });
  //   // return "lido";
  // }

  filtrarLivros() {
    if (_livroInputController.text != "") {
      setState(() {
        nomeLivro = _livroInputController.text;

        livros = FirebaseFirestore.instance
            .collection("Livros Registrados")
            .where("nome do livro", isEqualTo: nomeLivro)
            .snapshots();
      });
    } else {
      setState(() {
        livros = FirebaseFirestore.instance
            .collection("Livros Registrados")
            .snapshots();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          nome + turma,
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
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(
                  nome + turma,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "CaviarDreams",
                  ),
                ),
                accountEmail: Text(
                  "...",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "CaviarDreams",
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  child: Icon(
                    Icons.person_outline_rounded,
                    size: 35,
                  ),
                )),
            ListTile(
              title: Row(
                children: [
                  Text(
                    "Pedidos recebidos",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "CaviarDreams",
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  notificacoesPedidos(),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PedidosRecebidos(nomeDeBixo: nome, turma: turma)));
              },
            ),
            ListTile(
              title: Row(children: [
                Text(
                  "Notificações",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "CaviarDreams",
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                notificacoesMenu(),
              ]),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Notificacoes(nomeDeBixo: nome, turma: turma)));
              },
            )
          ],
        ),
      ),
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
            SizedBox(height: 20),
            todosLivros(),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Widget livro(String nomedolivro, String autor, String dono, String turmaDono,
      bool disp, String bloco, String apartamento, String vaga) {
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
            Icons.menu_book_rounded,
            color: MyColors.corPrincipal,
            size: 40,
          ),
          SizedBox(width: 10),
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
                    fontSize: 15,
                    //fontWeight: FontWeight.w400,
                    fontFamily: "CaviarDreams",
                  ),
                ),
                Text(
                  "Dono: $dono$turmaDono",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    //fontWeight: FontWeight.w400,
                    fontFamily: "CaviarDreams",
                  ),
                ),
                ("$nome$turma" != "$dono$turmaDono") && disp
                    ? GestureDetector(
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
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Pedir emprestado",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "CaviarDreams",
                            ),
                          ),
                        ),
                        onTap: () async {
                          FirebaseFirestore.instance
                              .collection("Usuários")
                              .doc(dono + turmaDono)
                              .collection("Pedidos recebidos")
                              .doc(nomedolivro + nome + turma)
                              .set({
                            'nome do livro': nomedolivro,
                            'autor': autor,
                            'pedinte': nome,
                            'turma do pedinte': turma,
                            'bloco do pedinte': bloco,
                            'apartamento do pedinte': apartamento,
                            'vaga do pedinte': vaga
                          });
                          await Future.delayed(
                            Duration(seconds: 1),
                          );
                          Fluttertoast.showToast(
                            msg:
                                "Solicitação enviada a $dono$turmaDono. Aguarde a resposta :)",
                            fontSize: 18,
                            backgroundColor: MyColors.corBasica,
                            textColor: MyColors.corPrincipal
                          );
                        },
                      )
                    : Container(),
                ("$nome$turma" != "$dono$turmaDono") && !disp
                    ? Container(
                        // height: 45,
                        // width: 230,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Já foi emprestado :(",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontFamily: "CaviarDreams",
                          ),
                        ),
                      )
                    : Container(),
                "$nome$turma" == "$dono$turmaDono"
                    ? Container(
                        // height: 45,
                        // width: 230,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Pedir emprestado",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: "CaviarDreams",
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
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
      height: 30,
      width: 130,
      child: Center(
        child: Text(
          texto,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "CaviarDreams",
          ),
        ),
      ),
    );
  }

  Widget notificacoesPedidos() {
    if (numPedidos != 0 && numPedidos != null) {
      return FittedBox(
        child: Container(
          child: Text("$numPedidos",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              )),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget notificacoesMenu() {
    if (numNotificacoes != 0 && numNotificacoes != null) {
      return FittedBox(
        child: Container(
          child: Text("$numNotificacoes",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              )),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget todosLivros() {
    //   // return Column(
    //   //   children: [
    //   //     Container(),
    //   //     ListView.builder(
    //   //       itemCount: 10,
    //   //       itemBuilder: (BuildContext context, int index) {
    //   //         return livro(
    //   //           _todosOsLivros[index]["nome do livro"],
    //   //           _todosOsLivros[index]["autor"],
    //   //           _todosOsLivros[index]["dono"],
    //   //           _todosOsLivros[index]["turma do dono"],
    //   //           _todosOsLivros[index]["disponibilidade"],
    //   //           bloco,
    //   //           apartamento,
    //   //           vaga,
    //   //         );
    //   //       },
    //   //     )
    //   //   ],
    //   // );
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
                livro(
                    listaLivros[i]["nome do livro"],
                    listaLivros[i]["autor"],
                    listaLivros[i]["dono"],
                    listaLivros[i]["turma do dono"],
                    listaLivros[i]["disponibilidade"],
                    bloco,
                    apartamento,
                    vaga),
              SizedBox(height: 40),
              GestureDetector(
                  child: botao("Mais livros..."),
                  onTap: () {
                    setState(() {
                      _contador++;
                    });
                  }),
              SizedBox(
                height: 10,
              ),
            ],
          );
        });

    //   // return ListView.builder(
    //   //   itemBuilder: (BuildContext context, int index) {
    //   //     livro(
    //   //       _todosOsLivros[index]["nome do livro"],
    //   //       _todosOsLivros[index]["autor"],
    //   //       _todosOsLivros[index]["dono"],
    //   //       _todosOsLivros[index]["turma do dono"],
    //   //       _todosOsLivros[index]["disponibilidade"],
    //   //       bloco,
    //   //       apartamento,
    //   //       vaga,
    //   //     );
    //   //   },
    //   // );
  }
}
