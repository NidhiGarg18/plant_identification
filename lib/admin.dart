import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_identification/history.dart';
import 'homepage.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

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
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> additem1(),));
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
                 leading: const Icon(Icons.person,color: Colors.white,),
                title: const Text(' Admin ',style: TextStyle(color: Colors.white,fontSize: 25),),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AdminPage(),));
                },
              ),
            ],
          ),
        ),
      appBar: AppBar(title: Text("Admin Page")),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("User data not found"));
          }

          Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email: ${userData['email']}", style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                Center( 
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: Text("Logout"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}