import 'package:flutter/material.dart';
import 'package:flutter_notes_app_sqflite/sqldb.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();

  List notes = [];
  bool isLoading = true;

  Future readData() async {
    var response = await sqlDb.read("notes");
    notes.addAll(response);
    isLoading = false;
    if(mounted){
      setState(() {});
    }
  }


  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: notes.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
          return Card(
            child: ListTile(
              title: Text("${notes[index]['title']}"),
              subtitle: Text("${notes[index]['note']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      int response = await sqlDb.delete("notes", "id=${notes[index]['id']}");
                      if(response > 0){
                        notes.removeWhere((element) => element['id'] == notes[index]['id']);
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.delete, color: Colors.red,),
                  ),
                  IconButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, "editnotes",
                        arguments: {
                        'id' : notes[index]['id'],
                        'note':notes[index]['note'],
                        'title':notes[index]['title'],
                      },
                      );
                    },
                    icon: Icon(Icons.edit, color: Colors.blue,),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, "addnotes");
          },
        child: Icon(Icons.add,color: Colors.deepPurple,),
      ),
    );
  }
}
