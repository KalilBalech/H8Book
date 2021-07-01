import 'package:flutter/material.dart';
import '../../config/my_colors.dart';
import 'package:h_book/Pages/PaginaPrincipal/pagina_principal.dart';

class ContinuarBiblioteca extends StatefulWidget {

  @override
  _ContinuarBibliotecaState createState() => _ContinuarBibliotecaState();
}

class _ContinuarBibliotecaState extends State<ContinuarBiblioteca> {

  TextEditingController _livroInputController = TextEditingController();

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
        leading: Container(),
        titleSpacing: 0,
        title: new Text("@usuário",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontFamily: "DancingScript",  
          ),
        ),
        backgroundColor: MyColors.corSecundaria,
      ),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: MyColors.corBasica
                      ),
                      //padding: EdgeInsets.all(10),
                      child: Text("Obrigado pela contribuição!",
                        style: TextStyle(
                          color: MyColors.corPrincipal,
                          fontSize: 33,
                          fontFamily: "DancingScript",
                        ),
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    //SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Adicione mais algum livro",
                        style: TextStyle(
                          color: MyColors.corPrincipal,
                          fontSize: 35,
                          fontFamily: "DancingScript",
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("- A comunidade iteana agradece! :)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: "DancingScript",
                  ),
                ),
              ),
              SizedBox(height: 50),
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
                      Text("Não tenho mais nenhum :(",
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