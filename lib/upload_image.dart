import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'admin.dart';
import 'history.dart';
import 'homepage.dart';
//import 'history_page.dart';

class ImagePredictionPage extends StatefulWidget {
  @override
  _ImagePredictionPageState createState() => _ImagePredictionPageState();
}

class _ImagePredictionPageState extends State<ImagePredictionPage> {
  File? _selectedImage;
  String? _predictionName;
  String? _predictionDescription;
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _history = [];

  // Load the TFLite model and make predictions
  Future<void> _predictImage(File imageFile) async {
    try {
      final interpreter = await Interpreter.fromAsset("model1.tflite");

      // Preprocess the image (replace this with actual preprocessing steps)
      final input = _preprocessImage(imageFile);
      final output = List.filled(1, 0); // Adjust based on model output shape

      // Run inference
      interpreter.run(input, output);

      // Map prediction output to name and description using the labels.txt file
      final labels = await _loadLabels("assets/file_metadata_summary_with_description.txt");
      final predictedIndex = output[0];
      setState(() {
        _predictionName = labels[predictedIndex]['File Name'];
        _predictionDescription = labels[predictedIndex]['Description'];
      });

      print("Prediction: $_predictionName, $_predictionDescription");
    } catch (e) {
      print("Error during prediction: $e");
    }
  }

  // Load labels and descriptions from a .txt file
  Future<List<Map<String, String>>> _loadLabels(String filePath) async {
    final file = File(filePath);
    final lines = await file.readAsLines();
    return lines.map((line) {
      final parts = line.split('|');
      return {'File Name': parts[0], 'Description': parts[1]};
    }).toList();
  }

  // Dummy preprocessing (replace with actual logic)
  List<List<List<double>>> _preprocessImage(File imageFile) {
    // Example: Resize, normalize, etc.
    return List.generate(224, (x) => List.generate(224, (y) => [0.0, 0.0, 0.0]));
  }

  // Pick an image and predict
  Future<void> _pickImageAndPredict() async {
    try {
      final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        setState(() {
          _selectedImage = imageFile;
        });
        await _predictImage(imageFile);

        // Save prediction to history
        _saveToHistory(imageFile);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Save the selected image and prediction to history
  Future<void> _saveToHistory(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final String newPath = '${directory.path}/${DateTime.now().toIso8601String()}.png';
    final File savedImage = await imageFile.copy(newPath);

    setState(() {
      _history.add({
        'imagePath': savedImage.path,
        'File Name': _predictionName,
        'Description': _predictionDescription,
      });
    });
  }

  // Navigate to History Page
  void _goToHistoryPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryPage(history: _history),
      ),
    );
  }

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
        title: Text("Upload and Predict"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: _goToHistoryPage,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 200)
                : Text("No image selected"),
            SizedBox(height: 20),
            if (_predictionName != null && _predictionDescription != null)
              Column(
                children: [
                  Text("File Name: $_predictionName", style: TextStyle(fontSize: 18)),
                  Text("Description: $_predictionDescription",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImageAndPredict,
              child: Text("Pick Image and Predict"),
            ),
          ],
        ),
      ),
    );
  }
}
