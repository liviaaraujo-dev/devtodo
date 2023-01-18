import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devtodo/modules/home/components/assignment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import '../../shared/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  final String email;
  final String name;
  final String imgUrl;
  final String idUser;
  const HomePage(
      {super.key,
      required this.email,
      required this.imgUrl,
      required this.name,
      required this.idUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var nomeSeparado = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _task = TextEditingController();
  List<dynamic> tasks = [];

  @override
  void initState() {
    nomeSeparado = widget.name.split(' ');
    readTasks();
    super.initState();
  }

  Future<void> readTasks() async {
    await FirebaseFirestore.instance
        .collection('users/${widget.idUser}/tasks')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          tasks.add(doc.data());
        });
      }
    });
  }

  Future<void> cleanListTasks() async {
    tasks.clear();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          height: 180,
          color: AppColors.laranja,
          child: Center(
            child: ListTile(
              title: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text.rich(
                  TextSpan(
                      text: "Olá, ",
                      style: Theme.of(context).textTheme.headline2,
                      children: [TextSpan(text: nomeSeparado[0])]),
                ),
              ),
              subtitle: Text(
                "Mantenha suas tarefas em dia",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Container(
                margin: const EdgeInsets.only(top: 10),
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
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "Minhas Tarefas",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 5),
                height: 2,
                width: size.width * .85,
                color: Color(0xFFE3E3E5),
              ),
              const SizedBox(
                height: 25,
              ),
              _listTasksWidget()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext conttext) {
                return Dialog(
                  child: Container(
                    height: screenHeight * .35,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            "Nova tarefa",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 30, bottom: 20),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              autofocus: true,
                              controller: _task,
                              decoration: const InputDecoration(
                                hintText: "Nome Completo",
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsetsDirectional.only(
                                    start: 20, top: 15, bottom: 15),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            )),
                        ElevatedButton(
                          child: Text(
                            "ADICIONAR",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 10, bottom: 10),
                              backgroundColor: AppColors.laranja),
                          onPressed: () async {
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
                            await readTasks();
                          },
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        backgroundColor: AppColors.laranja,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _listTasksWidget() {
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
