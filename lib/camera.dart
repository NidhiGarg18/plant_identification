// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'admin.dart';
// import 'history.dart';
// import 'homepage.dart';

// class PlantScanner extends StatefulWidget {
//   @override
//   _PlantScannerState createState() => _PlantScannerState();
// }

// class _PlantScannerState extends State<PlantScanner> {
//   final ImagePicker _picker = ImagePicker();
//   File? _image;

//   // Function to open the camera
//   Future<void> _openCamera() async {
//     final pickedImage = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//       // Call plant identification logic here
//       _identifyPlant(_image!);
//     }
//   }

//   // Dummy function for plant identification
//   void _identifyPlant(File image) {
//     // Replace with your AI/ML logic for plant identification
//     print("Identifying plant from image: ${image.path}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       drawer: Drawer(
//         //iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: Colors.green,
//         child: ListView(
//           padding: const EdgeInsets.all(10),
//           children: [
//             SizedBox(height: 25,),
//             ListTile(
//               leading: const Icon(Icons.home,color: Colors.white,),
//               title: const Text('Home',style: TextStyle(color: Colors.white,fontSize: 25),),
//               onTap: () {
//                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> homepage(),));
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.details,color: Colors.white,),
//               title: const Text('Detail',style: TextStyle(color: Colors.white,fontSize: 25),),
//               onTap: () {
//                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HistoryPage(history: [],),));
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.add,color: Colors.white,),
//               title: const Text(' Add Items ',style: TextStyle(color: Colors.white,fontSize: 25),),
//               onTap: () {
//                 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HistoryPage(history: [],),));
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.thermostat,color: Colors.white,),
//               title: const Text(' Weather ',style: TextStyle(color: Colors.white,fontSize: 25),),
//               onTap: () {
//                 //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> payment(),));
//               },
//             ),
//             ListTile(
//                  leading: const Icon(Icons.person,color: Colors.white,),
//                 title: const Text(' Admin ',style: TextStyle(color: Colors.white,fontSize: 25),),
//                 onTap: () {
//                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AdminPage(),));
//                 },
//               ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         title: Text("Plant Scanner",style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),),
//          actions: [
//           IconButton(
//             icon: Icon(Icons.history),
//             onPressed: (){
//               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HistoryPage(history: [],),));
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _image == null
//                 ? Text("No image captured.",style: TextStyle(fontSize: 18,),)
//                 : Image.file(
//               _image!,
//               width: 300,
//               height: 300,
//             ),
//             SizedBox(height: 20),
//             InkWell(
//               onTap: _openCamera,
//               child: Text("Open Camera",style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';


import 'admin.dart';
import 'history.dart';
import 'homepage.dart';

class PlantScanner extends StatefulWidget {
  @override
  _PlantScannerState createState() => _PlantScannerState();
}

class _PlantScannerState extends State<PlantScanner> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String _resultText = "No plant identified yet.";

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
    print("Model loaded: $res");
  }

  Future<void> _openCamera() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      _identifyPlant(_image!);
    }
  }

  Future<void> _identifyPlant(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    if (output != null && output.isNotEmpty) {
      setState(() {
        _resultText = output[0]['label'];
      });
    } else {
      setState(() {
        _resultText = "Could not identify the plant.";
      });
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.green,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            const SizedBox(height: 25),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white, fontSize: 25)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homepage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.details, color: Colors.white),
              title: const Text('Detail', style: TextStyle(color: Colors.white, fontSize: 25)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HistoryPage(history: [])));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add, color: Colors.white),
              title: const Text('Add Items', style: TextStyle(color: Colors.white, fontSize: 25)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.thermostat, color: Colors.white),
              title: const Text('Weather', style: TextStyle(color: Colors.white, fontSize: 25)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Admin', style: TextStyle(color: Colors.white, fontSize: 25)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Plant Scanner",
          style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HistoryPage(history: [])));
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null
                  ? const Text("No image captured.", style: TextStyle(fontSize: 18))
                  : Image.file(
                      _image!,
                      width: 300,
                      height: 300,
                    ),
              const SizedBox(height: 20),
              InkWell(
                onTap: _openCamera,
                child: const Text(
                  "Open Camera",
                  style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _resultText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
