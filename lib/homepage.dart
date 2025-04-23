import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_identification/history.dart';
import 'admin.dart';
import'camera.dart';
import'upload_image.dart';
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
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
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HistoryPage(history: [],),));
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
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Plant Identification",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
          actions: [
            IconButton(
            icon: Icon(Icons.logout,color: Colors.white,),
            onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
          ),
            IconButton(
            icon: Icon(Icons.person,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminPage()),
              );
            },
          ),
          ], 
        ),
        body:Container(
                 child: Column(
                   children: [
                    // SizedBox(height: 20,),
                      Image.asset(
                       "assets/homepage.jpg",
                       //width: 100,
                       height: 400,
                        fit: BoxFit.cover,
                     ),

                     SizedBox(height: 20,),
                     SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10,right: 40,),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.green,
                                 child: InkWell(
                                     onTap: (){
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PlantScanner(),));
                                     },
                                   child: Icon(Icons.camera_alt,color: Colors.white,size: 50,), // icon
                                   ),
                                ),
                              ),

                           InkWell(
                             onTap: (){
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ImagePredictionPage(),));
                               },
                             child:Text("Upload a Image",
                               style: TextStyle(
                                   //backgroundColor: Colors.green,
                                   fontSize: 30,color: Colors.green,
                                   fontWeight: FontWeight.bold),
                             ),
                           ),

                         ],
                       ),
                     ),
                   ],
                 ),
        ),
      ),
    );
  }
}
