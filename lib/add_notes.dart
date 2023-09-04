import 'package:flutter/material.dart';
import 'package:flutter_notes_app_sqflite/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
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
                        int response = await sqlDb.insert(
                            'notes',
                            {
                              'note':note.text,
                              'title':title.text,
                            },
                        );
                        if(response > 0){
                          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                        }
                      },
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    child: Text("Add Note"),
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
