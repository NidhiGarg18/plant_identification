import 'dart:io';
import 'package:flutter/material.dart';

import 'admin.dart';
import 'homepage.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> history;

  const HistoryPage({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          //iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.green,
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              SizedBox(height: 25,),
              ListTile(
                leading: const Icon(Icons.home,color: Colors.white,),
                title: const Text('Home',style: TextStyle(color: Colors.white,fontSize: 25),),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> homepage(),));
                },
              ),
              ListTile(
                 leading: const Icon(Icons.details,color: Colors.white,),
                title: const Text('Detail',style: TextStyle(color: Colors.white,fontSize: 25),),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HistoryPage(history: [],),));
                },
              ),
              ListTile(
                 leading: const Icon(Icons.add,color: Colors.white,),
                title: const Text(' Add Items ',style: TextStyle(color: Colors.white,fontSize: 25),),
                onTap: () {
                 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HistoryPage(history: [],),));
                },
              ),
              ListTile(
                 leading: const Icon(Icons.thermostat,color: Colors.white,),
                title: const Text(' Weather ',style: TextStyle(color: Colors.white,fontSize: 25),),
                onTap: () {
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> payment(),));
                },
              ),
              ListTile(
                 leading: const Icon(Icons.thermostat,color: Colors.white,),
                title: const Text(' Admin ',style: TextStyle(color: Colors.white,fontSize: 25),),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AdminPage(),));
                },
              ),

            ],
          ),
        ),
      appBar: AppBar(
        title: Text("Prediction History"),
      ),
      body: history.isEmpty
          ? Center(child: Text("No history available"))
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.file(
                File(item['imagePath']),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(item['File Name'] ?? "Unknown"),
              subtitle: Text(item['Description'] ?? "No description available"),
            ),
          );
        },
      ),
    );
  }
}
