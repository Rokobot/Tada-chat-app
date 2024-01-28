import 'package:flutter/material.dart';
import 'package:tada/services/notfService.dart';



class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 5, right: 5, left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: Container(
                    height: 100, child: Align(alignment: Alignment.centerLeft, child: Container(child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text('Your connection', style: TextStyle(fontSize: 25),),
                  ),decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(50)),)),),
                  height: 100,
                ),
                Expanded(child: NotfService().connetList(),)
              ],
            )
          )
        ),
      )
    );
  }
}

