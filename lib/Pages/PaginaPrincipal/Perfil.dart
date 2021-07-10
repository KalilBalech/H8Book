import 'package:flutter/material.dart';
import '../../config/my_colors.dart';

class Perifl extends StatefulWidget {

  @override
  _PeriflState createState() => _PeriflState();
}

class _PeriflState extends State<Perifl> {

  TextEditingController _livroInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              titulo("Sua Perifl"),
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
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Perifl()
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
                      SizedBox(width: 10),
                      Text("Adicionar a sua Perifl",
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
        SizedBox(height: 20),
      ],
    ),
  );
}