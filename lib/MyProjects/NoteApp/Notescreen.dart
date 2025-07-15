import 'package:first_app/Const.dart';
import 'package:first_app/MyProjects/NoteApp/hive_helpers.dart';

import 'package:flutter/material.dart';

class Notescreen extends StatefulWidget {
  const Notescreen({super.key});

  @override
  State<Notescreen> createState() => _NotescreenState();
}

class _NotescreenState extends State<Notescreen> {
  final _noteController = TextEditingController();
  final _titleController = TextEditingController();
  final maxLines = 10;

  @override
  void initState() {
    HiveHelpers.getAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00ffffff).withOpacity(0.3),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Your Notes",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: HiveHelpers.myNotes.length,
          itemBuilder: (c, i) => InkWell(
            onTap: () async {
              await _showModal(
                index: i,
                isUpdate: true,
              );
            },
            child: _ItemMethod(i), // Ensure this is called here
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(55)),
        onPressed: () async {
          _noteController.clear();
          _titleController.clear();
          await _showModal();
        },
        backgroundColor: const Color(0xffFFFFFF),
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 187, 2, 2),
        ),
      ),
    );
  }

  Widget _ItemMethod(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 187, 2, 2).withOpacity(.6),
          borderRadius: BorderRadius.circular(18),
        ),
        child: ListTile(
          title: Text(HiveHelpers.myNotes[index]['title']!),
          subtitle: Text(HiveHelpers.myNotes[index]['content']!),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              HiveHelpers.removeNote(index);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showModal({
    bool isUpdate = false,
    int? index,
  }) async {
    if (isUpdate && index != null) {
      //هحط الداتا في الكونترولر
      _titleController.text = HiveHelpers.myNotes[index]['title']!;
      _noteController.text = HiveHelpers.myNotes[index]['content']!;
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title: ',
                    labelStyle: const TextStyle(fontSize: 22),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: maxLines * 20.0,
                child: TextField(
                  controller: _noteController,
                  maxLines: maxLines,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: 'Your Note:',
                    labelStyle: const TextStyle(fontSize: 22),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: maxLines*40,
                child: Image.asset("${imagePath}note logo 2.png"),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (_noteController.text.isNotEmpty) {
                        if (isUpdate) {
                          HiveHelpers.updateNote(index!, _noteController.text,
                              _titleController.text);
                        } else {
                          HiveHelpers.addnote(
                              _noteController.text, _titleController.text);
                        }
                      }
                    });

                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        (isUpdate) ? "Update" : "Add",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 187, 2, 2),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
