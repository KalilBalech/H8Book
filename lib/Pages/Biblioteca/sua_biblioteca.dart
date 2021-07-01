import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';
import '../../config/my_colors.dart';
import '../Biblioteca/continuar_biblioteca.dart';

class SuaBiblioteca extends StatefulWidget {

  final String nomeBixo;

  SuaBiblioteca({this.nomeBixo});

  @override
  _SuaBibliotecaState createState() => _SuaBibliotecaState();
}

class _SuaBibliotecaState extends State<SuaBiblioteca> {
  
  TextEditingController _livroInputController = TextEditingController();
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: new Text("@" + widget.nomeBixo,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: "CaviarDreams",  
          ),
        ),
        backgroundColor: MyColors.corSecundaria,
      ),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              titulo("Monte a sua biblioteca!"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("- Disponibilize algum de seus livros!\n\n- Vamos alimentar a nossa comunidade!\n\n A comunidade iteana agradece!",
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
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => ContinuarBiblioteca()
                      ));
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
                  child: Row(
                    children:[ 
                      Icon(Icons.add),
                      SizedBox(width: 80),
                      Text("Adicionar",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 29,
                          fontFamily: "DancingScript",
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PaginaPrincipal()
                      ));
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
                  child: Row(
                    children:[ 
                      SizedBox(width: 20),
                      Text("Não tenho nenhum livro :(",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 29,
                          fontFamily: "DancingScript",
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            ],
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

Widget botao (String texto){
  return Container(
    decoration: BoxDecoration(
      color: MyColors.corSecundaria,
      borderRadius: BorderRadius.circular(50),
    ),
    margin: EdgeInsets.symmetric(horizontal: 10),
    padding: EdgeInsets.all(10),
      child: Row(
        children:[ 
            Icon(Icons.add),
            SizedBox(width: 80),
            Text(texto,
              style: TextStyle(
                color: MyColors.corPrincipal,
                fontSize: 29,
                fontFamily: "DancingScript",
            ),
        ),
        ]
      ),
  );
}