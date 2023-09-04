// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_notes_app_sqflite/sqldb.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key,});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {

  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formState = GlobalKey();


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    TextEditingController note = TextEditingController(text: args['note']);
    TextEditingController title = TextEditingController(text: args['title']);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Notes"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(hintText: "Title"),
                  ),
                  TextFormField(
                    controller: note,
                    decoration: InputDecoration(hintText: "note"),
                  ),
                  Container(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      int response = await sqlDb.update(
                          "notes",
                          {
                            'note':note.text,
                            'title':title.text,
                          },
                          "id=${args['id']}",
                      );
                      if(response > 0){
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      }
                    },
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    child: Text("Edit Note"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
