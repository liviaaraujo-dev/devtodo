import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtodo/modules/home/components/assignment.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../shared/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  final String email;
  final String name;
  final String imgUrl;
  final String idUser;
  const HomePage(
      {required this.email,
      required this.imgUrl,
      required this.name,
      required this.idUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var nomeSeparado = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController _task = new TextEditingController();
  List<dynamic> tasks = [];

  @override
  void initState() {
    // TODO: implement initState
    nomeSeparado = widget.name.split(' ');
    initA();
    super.initState();
  }

  Future<void> initA() async {
    await FirebaseFirestore.instance
        .collection('users/${widget.idUser}/tasks')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.data());
        setState(() {
          tasks.add(doc.data());
        });
      });
    });
    print(tasks);
  }

  Future<void> limparLista() async {
    tasks.clear();
    print(tasks);
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.laranja,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                    text: "Olá, ",
                    style: Theme.of(context).textTheme.headline2,
                    children: [TextSpan(text: nomeSeparado[0])]),
              ),
              subtitle: Text(
                "Mantenha suas tarefas em dia",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Container(
                height: 48,
                width: 48,
                child: Image.network(widget.imgUrl),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          width: size.width * .85,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Minhas Tarefas",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Container(
                height: 2,
                width: size.width * .85,
                color: Color(0xFFE3E3E5),
              ),
              listarTasks()
              //  Builder(builder: BuildContext (context) {
              //    tasks.map(
              //       (e) => {Assignment(idUser: widget.idUser, title: e["title"])},
              //     );
              //  })
              //listarTasks()
              // Assignment(
              //   idUser: widget.idUser,
              //   title: ,
              // )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // String idTask = Uuid().v1();
          // firestore
          //     .collection("users/${widget.idUser}/tasks")
          //     .doc(idTask)
          //     .set({"title": "estudar dart", "complete": true});

          // FirebaseFirestore.instance
          //     .collection('users/${widget.idUser}/tasks')
          //     .get()
          //     .then((QuerySnapshot querySnapshot) {
          //   querySnapshot.docs.forEach((doc) {
          //     print(doc.data());
          //   });
          // });

          showDialog(
              context: context,
              builder: (BuildContext conttext) {
                return Dialog(
                  child: Container(
                    height: screenHeight * .3,
                    child: Column(
                      children: [
                        Text(
                          "Nova tarefa",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        TextField(
                          controller: _task,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              print(_task.text);
                              String idTask = await Uuid().v1();
                              await firestore
                                  .collection("users/${widget.idUser}/tasks")
                                  .doc(idTask)
                                  .set({
                                "title": _task.text,
                                "complete": false,
                                "id": idTask
                              });
                              _task.text = "";
                              tasks.clear();
                              Navigator.pop(context);
                              await initA();
                            },
                            child: Text("Adicionar"))
                      ],
                    ),
                  ),
                );
              });
        },
        backgroundColor: AppColors.laranja,
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget listarTasks() {
    return Column(
      children: tasks
          .map<Widget>((e) => Assignment(
                idUser: widget.idUser,
                title: e["title"],
                idTask: e["id"],
                complete: e["complete"],
                email: widget.email,
                imgUrl: widget.imgUrl,
                name: widget.name,
              ))
          .toList(),
    );
  }
}
