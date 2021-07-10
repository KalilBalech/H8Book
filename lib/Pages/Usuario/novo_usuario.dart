import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_book/Pages/Biblioteca/sua_biblioteca.dart';
import '../../config/my_colors.dart';
import '../../config/Text_format.dart';

class NovoUsuario extends StatefulWidget {
  @override
  _NovoUsuarioState createState() => _NovoUsuarioState();
}

class _NovoUsuarioState extends State<NovoUsuario> {
  bool _secureText = true;

  final _nomeDeBixoKey = GlobalKey<FormState>();
  final _turmaKey = GlobalKey<FormState>();
  final _senhaKey = GlobalKey<FormState>();
  final _confirmarSenhaKey = GlobalKey<FormState>();
  final _apartamentoKey = GlobalKey<FormState>();
  final _blocoKey = GlobalKey<FormState>();
  final _vagaKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();

  TextEditingController _nomeDeBixo = TextEditingController();
  TextEditingController _turma = TextEditingController();
  TextEditingController _senha = TextEditingController();
  TextEditingController _confirmarSenha = TextEditingController();
  TextEditingController _apartamento = TextEditingController();
  TextEditingController _bloco = TextEditingController();
  TextEditingController _vaga = TextEditingController();
  TextEditingController _email = TextEditingController();

  String nomeBixo;

  Stream usuariosCadastrados;

  @override
  void initState(){
    usuariosCadastrados = FirebaseFirestore.instance.collection("Usuários").snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.navigate_before_rounded),
              onPressed: () { 
                Navigator.pop(context);
              },
            );
          }
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [MyColors.corPrincipal, MyColors.corSecundaria],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          )),
        ),
        title: Text(
          "Novo usuário",
          style: TextStyle(
            fontFamily: "CaviarDreams",
            color: Colors.black,
            fontSize: 30,
          ),
        ),
      ),
      backgroundColor: MyColors.corBasica,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                titulo("Então, se apresenta pra mim no macaco"),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: _nomeDeBixoKey,
                    child: TextFormField(
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Escreva o seu nome aqui';
                        }
                        return null;
                      },
                      controller: _nomeDeBixo,
                      decoration: InputDecoration(
                        labelText: "Nome de bixo",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 29,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DancingScript",
                        ),
                        icon: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: _turmaKey,
                    child: TextFormField(
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Escreva a sua turma aqui';
                        }
                        return null;
                      },
                      controller: _turma,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: InputDecoration(
                        labelText: "Turma (Ex: 25)",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 29,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DancingScript",
                        ),
                        icon: Icon(Icons.group_rounded),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: _senhaKey,
                    child: TextFormField(
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Cria uma senha aqui';
                        }
                        if (_senha.text.length < 8) {
                          return "A senha deve ter pelo menos 8 dígitos";
                        }
                        return null;
                      },
                      controller: _senha,
                      obscureText: _secureText,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 29,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DancingScript",
                        ),
                        icon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_secureText
                              ? Icons.security
                              : Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              _secureText = !_secureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: _confirmarSenhaKey,
                    child: TextFormField(
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Repita a sua senha aqui';
                        }
                        if (_senha.text != _confirmarSenha.text) {
                          return "Confirmação de senha inválida";
                        }
                        return null;
                      },
                      controller: _confirmarSenha,
                      obscureText: _secureText,
                      decoration: InputDecoration(
                        labelText: "Confirmar senha",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 29,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DancingScript",
                        ),
                        icon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_secureText
                              ? Icons.security
                              : Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              _secureText = !_secureText;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
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
                      controller: _bloco,
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
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: _apartamentoKey,
                    child: TextFormField(
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Fala qual é o seu ap, bixão. Senão vai levar G';
                        }
                        if (_bloco.text == "A" &&
                            (int.parse(valor) >= 143 ||
                                int.parse(valor) <= 100)) {
                          return "Número de apartamento inválido";
                        }
                        if (_bloco.text == "B" &&
                            (int.parse(valor) >= 242 ||
                                int.parse(valor) <= 200)) {
                          return "Número de apartamento inválido";
                        }
                        if (_bloco.text == "C" &&
                            (int.parse(valor) >= 331 ||
                                int.parse(valor) <= 300)) {
                          return "Número de apartamento inválido";
                        }
                        if (_bloco.text == "D" &&
                            (int.parse(valor) >= 209 ||
                                (int.parse(valor) <= 200 &&
                                    int.parse(valor) >= 109) ||
                                int.parse(valor) <= 100)) {
                          return "Número de apartamento inválido";
                        }
                        if (_bloco.text == "E" &&
                            (int.parse(valor) >= 209 ||
                                (int.parse(valor) <= 200 &&
                                    int.parse(valor) >= 109) ||
                                int.parse(valor) <= 100)) {
                          return "Número de apartamento inválido";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: _apartamento,
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
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
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
                      controller: _vaga,
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
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: _emailKey,
                      child: TextFormField(
                        validator: (valor) {
                          if (valor.isEmpty) {
                            return 'Escreva seu email';
                          }
                          if(!valor.contains("@")){
                            return 'Email inválido';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: [AutofillHints.email],
                        controller: _email,
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
                ),
                SizedBox(height: 30),
                GestureDetector(
                    onTap: () {
                      if (_nomeDeBixoKey.currentState.validate() && _turmaKey.currentState.validate() && _senhaKey.currentState.validate() && _confirmarSenhaKey.currentState.validate() && 
                      _blocoKey.currentState.validate() && _apartamentoKey.currentState.validate() && _vagaKey.currentState.validate() && _emailKey.currentState.validate()) {
                          registrarUsuario( _nomeDeBixo.text, _turma.text , _senha.text, _bloco.text, int.parse(_apartamento.text), _vaga.text, _email.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  SuaBiblioteca(nomeBixo: _nomeDeBixo.text,turma: _turma.text,)
                          ));
                      }
                    },
                    child: botao("Avançar ->")),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*verificacaoDoUsuario(){
    FirebaseFirestore.instance.collection("Usuários").snapshots().listen(snapshot){
      List documents;
      setState((){
        documents = snapshot.documents;
      })
    }
  }*/

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
              fontSize: 49,
              fontFamily: "DancingScript",
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    ),
  );
}

/*Widget campoDeTexto (String texto){
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[400],
      borderRadius: BorderRadius.circular(20),
    ),
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: texto,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 29,
          fontWeight: FontWeight.w400,
          fontFamily: "DancingScript",
        ),
      ),
    ),
  );
}*/

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

void registrarUsuario(String nomedebixo, String turma, String senha, String bloco, int apartamento, String vaga, String email ){

  var informacoesUsuario = {
    "id": nomedebixo + turma,
    "Senha": senha,
    "Bloco": bloco,
    "Apartamento": apartamento,
    "Vaga": vaga
  };

  FirebaseFirestore.instance.collection("Usuários").doc(nomedebixo+turma).set(informacoesUsuario);

}