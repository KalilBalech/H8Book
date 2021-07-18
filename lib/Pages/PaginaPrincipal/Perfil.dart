import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/Pages/Usuario/reconhecimento.dart';
import 'pagina_principal.dart';
import '../../config/my_colors.dart';
import '../../config/Text_format.dart';

String bloco;

class Perfil extends StatefulWidget {
  Perfil();

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: titulo("Perfil")),
              todosdados(),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Container(
                  height: 45,
                  width: 240,
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
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 29,
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

  Widget todosdados() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Usuários')
            .doc(nome + turma)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            bloco = snapshot.data["Bloco"];
            return Column(
              children: [
                campoPerfil("Nome de Bixo", nome),
                campoPerfil("Turma", turma),
                Row(
                  children: [
                    campoPerfil("Bloco", snapshot.data["Bloco"]),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.grey,
                        onPressed: () {
                          mostrarAlertaEditarBloco(context);
                        }),
                  ],
                ),
                Row(
                  children: [
                    campoPerfil(
                        "Apartamento", snapshot.data["Apartamento"].toString()),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.grey,
                        onPressed: () {
                          mostrarAlertaEditarAp(context);
                        }),
                  ],
                ),
                Row(
                  children: [
                    campoPerfil("Vaga", snapshot.data["Vaga"]),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.grey,
                        onPressed: () {
                          mostrarAlertaEditarVaga(context);
                        }),
                  ],
                ),
                Row(
                  children: [
                    campoPerfil("E-mail", snapshot.data["Email"]),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.grey,
                        onPressed: () {
                          mostrarAlertaEditarEmail(context);
                        }),
                  ],
                ),
              ],
            );
          }
          //this will load first
          return CircularProgressIndicator();
        });
  }
}

showAlertDialog(BuildContext context) {
  Widget cancelaButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continuaButton = TextButton(
    child: Text("Continar"),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Reconhecimento()));
    },
  );
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: MyColors.corSecundaria,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Text("Deseja fazer o Logout?"),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

mostrarAlertaEditarEmail(BuildContext context) {
  final _emailKey = GlobalKey<FormState>();

  TextEditingController _dado = TextEditingController();
  Widget cancelaButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget botaoEditar = TextButton(
      child: Text("Editar"),
      onPressed: () {
        if (_emailKey.currentState.validate()) {
          FirebaseFirestore.instance
              .collection("Usuários")
              .doc(nome + turma)
              .update({"Email": _dado.text});
          Navigator.pop(context);
        }
      });
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: MyColors.corSecundaria,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Insira o novo valor para seu e-mail"),
        Form(
          key: _emailKey,
          child: TextFormField(
            validator: (valor) {
              if (valor.isEmpty) {
                return 'Escreva seu email';
              }
              if (!valor.contains("@")) {
                return 'Email inválido';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            autofillHints: [AutofillHints.email],
            controller: _dado,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 29,
                fontWeight: FontWeight.w400,
                fontFamily: "DancingScript",
              ),
              icon: Icon(Icons.email_outlined),
            ),
          ),
        ),
      ],
    ),
    actions: [
      cancelaButton,
      botaoEditar,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

mostrarAlertaEditarVaga(BuildContext context) {
  final _vagaKey = GlobalKey<FormState>();

  TextEditingController _dado = TextEditingController();
  Widget cancelaButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget botaoEditar = TextButton(
      child: Text("Editar"),
      onPressed: () {
        if (_vagaKey.currentState.validate()) {
          FirebaseFirestore.instance
              .collection("Usuários")
              .doc(nome + turma)
              .update({"Vaga": _dado.text});
          Navigator.pop(context);
        }
      });
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: MyColors.corSecundaria,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Insira o novo valor para sua vaga"),
        Form(
          key: _vagaKey,
          child: TextFormField(
            validator: (valor) {
              if (valor.isEmpty) {
                return 'Escreve a sua vaga aqui';
              }
              if (valor != "A" &&
                  valor != "B" &&
                  valor != "C" &&
                  valor != "D" &&
                  valor != "E" &&
                  valor != "F") {
                return "Vaga inválida";
              }
              return null;
            },
            controller: _dado,
            inputFormatters: [UpperCaseText()],
            maxLength: 1,
            decoration: InputDecoration(
              labelText: "Vaga (Ex: B)",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 29,
                fontWeight: FontWeight.w400,
                fontFamily: "DancingScript",
              ),
              icon: Icon(Icons.airline_seat_individual_suite_rounded),
            ),
          ),
        ),
      ],
    ),
    actions: [
      cancelaButton,
      botaoEditar,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

mostrarAlertaEditarAp(BuildContext context) {
  final _apartamentoKey = GlobalKey<FormState>();

  TextEditingController _dado = TextEditingController();
  Widget cancelaButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget botaoEditar = TextButton(
      child: Text("Editar"),
      onPressed: () {
        if (_apartamentoKey.currentState.validate()) {
          FirebaseFirestore.instance
              .collection("Usuários")
              .doc(nome + turma)
              .update({"Apartamento": int.parse(_dado.text)});
          Navigator.pop(context);
        }
      });
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: MyColors.corSecundaria,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Insira o novo valor para o apartamento"),
        Form(
          key: _apartamentoKey,
          child: TextFormField(
            validator: (valor) {
              if (valor.isEmpty) {
                return 'Fala qual é o seu ap, bixão. Senão vai levar G';
              }
              if (bloco == "A" &&
                  (int.parse(valor) >= 143 || int.parse(valor) <= 100)) {
                return "Número de apartamento inválido";
              }
              if (bloco == "B" &&
                  (int.parse(valor) >= 242 || int.parse(valor) <= 200)) {
                return "Número de apartamento inválido";
              }
              if (bloco == "C" &&
                  (int.parse(valor) >= 331 || int.parse(valor) <= 300)) {
                return "Número de apartamento inválido";
              }
              if (bloco == "D" &&
                  (int.parse(valor) >= 209 ||
                      (int.parse(valor) <= 200 && int.parse(valor) >= 109) ||
                      int.parse(valor) <= 100)) {
                return "Número de apartamento inválido";
              }
              if (bloco == "E" &&
                  (int.parse(valor) >= 209 ||
                      (int.parse(valor) <= 200 && int.parse(valor) >= 109) ||
                      int.parse(valor) <= 100)) {
                return "Número de apartamento inválido";
              }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: _dado,
            inputFormatters: [UpperCaseText()],
            maxLength: 3,
            decoration: InputDecoration(
              labelText: "Apart. (Ex: 330)",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 29,
                fontWeight: FontWeight.w400,
                fontFamily: "DancingScript",
              ),
              icon: Icon(Icons.apartment),
            ),
          ),
        ),
      ],
    ),
    actions: [
      cancelaButton,
      botaoEditar,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

mostrarAlertaEditarBloco(BuildContext context) {
  final _blocoKey = GlobalKey<FormState>();

  TextEditingController _dado = TextEditingController();
  Widget cancelaButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget botaoEditar = TextButton(
      child: Text("Editar"),
      onPressed: () {
        if (_blocoKey.currentState.validate()) {
          FirebaseFirestore.instance
              .collection("Usuários")
              .doc(nome + turma)
              .update({"Bloco": _dado.text});
          Navigator.pop(context);
        }
      });
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: MyColors.corSecundaria,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Insira o novo valor para o bloco"),
        Form(
          key: _blocoKey,
          child: TextFormField(
            validator: (valor) {
              if (valor.isEmpty) {
                return 'Esceva seu bloco aqui';
              }
              if (valor != "A" &&
                  valor != "B" &&
                  valor != "C" &&
                  valor != "D" &&
                  valor != "E") {
                return "O bloco inserido é inválido";
              }
              return null;
            },
            controller: _dado,
            inputFormatters: [UpperCaseText()],
            maxLength: 1,
            decoration: InputDecoration(
              labelText: "Bloco (Ex: C)",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 29,
                fontWeight: FontWeight.w400,
                fontFamily: "DancingScript",
              ),
              icon: Icon(Icons.apartment),
            ),
          ),
        ),
      ],
    ),
    actions: [
      cancelaButton,
      botaoEditar,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
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

Widget campoPerfilEditavel(String campo, String dado) {
  return Container(
    height: 60,
    child: Row(
      children: [
        SizedBox(width: 30),
        Text(campo + ": ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "CaviarDreams",
            )),
        Text(dado,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: "CaviarDreams",
            )),
      ],
    ),
  );
}

Widget campoPerfil(String campo, String dado) {
  return Container(
    height: 60,
    child: Row(
      children: [
        SizedBox(width: 30),
        Text(campo + ": ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: "CaviarDreams",
            )),
        Text(dado,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: "CaviarDreams",
            )),
      ],
    ),
  );
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
