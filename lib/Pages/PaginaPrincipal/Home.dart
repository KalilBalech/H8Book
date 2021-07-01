import 'package:flutter/material.dart';
import '../../config/my_colors.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _livroInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      body: SafeArea(
        child:SingleChildScrollView(
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
            ],
          ),
        ) ,
      ),
    );
  }
}