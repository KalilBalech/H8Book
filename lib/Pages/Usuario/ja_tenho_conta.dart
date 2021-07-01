import 'package:flutter/material.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import '../../config/my_colors.dart';
import '../../config/Text_format.dart';

class JaTenhoConta extends StatefulWidget {

  @override
  _JaTenhoContaState createState() => _JaTenhoContaState();
}

class _JaTenhoContaState extends State<JaTenhoConta> {

  
TextEditingController _nomeDeBixoInputController = TextEditingController();
TextEditingController _senhaInputController = TextEditingController();

bool _secureText = true;

String _senhaIncompativel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.corPrincipal, MyColors.corSecundaria],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ) 
          ),
        ),
        title: Text("Já tenho conta",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontFamily: "DancingScript",
          ),
        ),
      ),
      backgroundColor: MyColors.corBasica,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                titulo("Alto lá. Identifique-se!"),
                SizedBox(height: 100),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _nomeDeBixoInputController,
                    inputFormatters: [UpperCaseText()],
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    child: TextField(
                      controller: _senhaInputController,
                      obscureText: _secureText,
                      decoration: InputDecoration(
                        errorText: _senhaIncompativel,
                        labelText: "Senha",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 29,
                          fontWeight: FontWeight.w400,
                          fontFamily: "DancingScript",
                        ),
                        icon: Icon(Icons.lock), 
                        suffixIcon: IconButton(
                          icon: Icon(
                            _secureText ? Icons.security : Icons.remove_red_eye),
                            onPressed: (){
                              setState(() {
                              _secureText = !_secureText;              
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 160),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PaginaPrincipal()
                    ));
                  },
                  child: botao("Avançar ->")
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget titulo (String texto){
  return Container(
    child: Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(texto,
            style: TextStyle(
              color: MyColors.corPrincipal,
              fontSize: 40,
              fontFamily: "DancingScript",
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    ),
  );
}

TextEditingController textEditingController = TextEditingController();

Widget campoDeTexto (String texto){
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
        labelText: texto,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 29,
          fontWeight: FontWeight.w400,
          fontFamily: "DancingScript",
        ),
      ),
    ),
  );
}

Widget botao (String texto){
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
      child: Text(texto,
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontFamily: "DancingScript",
        ),
      ),
    ),
  );
}