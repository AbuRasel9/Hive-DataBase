import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _countryNameController = TextEditingController();
  final _countryUpdateController = TextEditingController();

  // List myList = ["Bangladesh", "India", 'Pakistan', 'Nepal'];
  Box ?_countryBox;

  @override
  void initState() {
    _countryBox = Hive.box("country-list");
    super.initState();
    print(Hive.box("country-list"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: _countryNameController,
              decoration: InputDecoration(
                hintText: "Enter country name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {
              _countryBox!.add(_countryNameController.text);
              _countryNameController.text="";
            }, child: Text("ADD")),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: ValueListenableBuilder(valueListenable: Hive.box("country-list").listenable(),
                    builder: (context, box, widget) {
                      return ListView.builder(
                          itemCount: _countryBox!
                              .keys
                              .toList()
                              .length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(_countryBox!.getAt(index).toString()),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: () {
                                        buildShowDialog(context, index,_countryNameController.text);
                                      }, icon: Icon(Icons.edit),),
                                      IconButton(onPressed: () {
                                        _countryBox!.deleteAt(index);
                                        setState(() {

                                        });
                                      }, icon: Icon(Icons.delete),),
                                    ],
                                  ),
                                ),

                              ),
                            );
                          });
                    })
            )
          ],
        ),
      ),
    );
  }

  buildShowDialog(BuildContext context, index,text) {
    return showDialog(
        context: context, builder: (context) {
      return AlertDialog(


        content: Container(
          height: 200,
          child: Column(
            children: [
              TextFormField(

                controller: _countryUpdateController,
                decoration: InputDecoration(
                  hintText: text,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {
                _countryBox!.putAt(index, _countryUpdateController.text).then((value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("successfull")));

                });
              }, child: Text("Update")),

            ],
          ),
        ),
      );
    });
  }


}
