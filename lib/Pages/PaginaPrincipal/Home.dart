import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../config/my_colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _livroInputController = TextEditingController();
  String nomeLivro = "";

  @override
  void initState() {
    super.initState();
    _livroInputController.addListener(_pesquisaLivro);
  }

  void _pesquisaLivro() {
    nomeLivro = _livroInputController.text;
  }

  lerLivrosFirebase() {
    var dados = FirebaseFirestore.instance.collection("Livros Registrados");
    return dados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.corBasica,
      body: Column(
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
          SizedBox(
            height: 20,
          ),
          /*Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Livros Registrados")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    children: snapshot.data.docs.map((document) {
                      return Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black12,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          height: 100,
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.book),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document["nome do livro"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "CaviarDreams",
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    document["autor"],
                                    style: TextStyle(
                                      fontFamily: "CaviarDreams",
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.add,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),*/
        ],
      ),
    );
  }
}
