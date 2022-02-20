import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:clipboard/clipboard.dart';

class Showcreds extends StatefulWidget {
  const Showcreds({Key? key}) : super(key: key);

  @override
  _ShowcredsState createState() => _ShowcredsState();
}

class _ShowcredsState extends State<Showcreds> {
  late Box<List> friendsbox;
  List? creds;

  @override
  void initState() {
    super.initState();
    friendsbox = Hive.box<List>('creds');
    setState(() {
      creds = friendsbox.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: creds!.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: const Icon(
                Icons.delete_forever_sharp,
                color: Colors.white,
                size: 40,
              ),
              color: Colors.red,
              alignment: Alignment.centerRight,
            ),
            onDismissed: (direction) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.green),
                  ),
                  content: const Text('Do you want to delete credentials'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        friendsbox.deleteAt(index);
                        Navigator.pop(context);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                  ],
                ),
              );
            },
            key: ValueKey(index),
            child: Card(
              margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              shadowColor: Colors.green,
              color: Colors.white,
              child: ListTile(
                trailing: IconButton(
                  onPressed: () {
                    FlutterClipboard.copy(creds![index][2]);
                  },
                  icon: const Icon(Icons.copy),
                ),
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
                title: Text(
                  creds![index][0].toString(),
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    creds![index][1].toString() +
                        '\n' +
                        creds![index][2].toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500)),
                isThreeLine: true,
              ),
            ),
          );
        });
  }
}
