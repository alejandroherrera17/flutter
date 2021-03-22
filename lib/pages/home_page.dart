import 'dart:io';
import 'package:band_app/model/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'metalica', votes: 5),
    Band(id: '2', name: 'champeta', votes: 50),
    Band(id: '3', name: 'vallenato', votes: 9),
    Band(id: '4', name: 'rock', votes: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white70,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int i) {
          return bandTile(bands[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCupertinoDialog,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      backgroundColor: Colors.blue,
      ),
    );
  }

  Widget bandTile(Band band) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        
        child: Text("Delete band"),
        decoration: BoxDecoration(
          color: Colors.red,
        ),
      ),
          key: Key(band.id),
          child: ListTile( 
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue,
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {},
      ),
      onDismissed: (direction){
        
      },
    );
  }

  addNewBand() {
    final textController = new TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Agregar nueva banda"),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  child: Text("Add"),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandToList(textController.text),
                )
              ],
            );
          });
    }
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text("New band"),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Ok"),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context)),
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length >= 1) {
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 5));
      setState(() {
      
      });
    }
    
    Navigator.pop(context);
  }
}
