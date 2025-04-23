// impor'package/'
// class PredictionScreen extends StatefulWidget {
//   @override
//   _PredictionScreenState createState() => _PredictionScreenState();
// }
//
// class _PredictionScreenState extends State<PredictionScreen> {
//   File? _image;
//   String? _prediction;
//   late Interpreter _interpreter;
//
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//   }
//
//   Future<void> loadModel() async {
//     _interpreter = await Interpreter.fromAsset('model.tflite');
//   }
//
//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         _prediction = null; // Reset prediction
//       });
//       predictImage(_image!);
//     }
//   }
//
//   Future<void> predictImage(File imageFile) async {
//     // Preprocess image
//     final inputSize = 224; // Assuming 224x224 input size
//     final input = preprocessImage(imageFile, inputSize);
//
//     // Run prediction
//     final output = List.filled(1001, 0.0).reshape([1, 1001]); // Adjust output shape
//     _interpreter.run(input, output);
//
//     // Get the predicted label
//     final predictionIndex = output[0].indexWhere((value) => value == output[0].reduce(max));
//     final labels = await loadLabels('assets/model_details (2).txt');
//     final predictionLabel = labels[predictionIndex];
//
//     setState(() {
//       _prediction = predictionLabel;
//     });
//
//     saveToHistory(imageFile.path, predictionLabel);
//   }
//
//   Future<List<String>> loadLabels(String path) async {
//     final rawLabels = await DefaultAssetBundle.of(context).loadString(path);
//     return rawLabels.split('\n');
//   }
//
//   TensorImage preprocessImage(File image, int inputSize) {
//     var imageBytes = img.decodeImage(image.readAsBytesSync())!;
//     var resizedImage = img.copyResize(imageBytes, width: inputSize, height: inputSize);
//     return TensorImage.fromBytes(resizedImage.getBytes());
//   }
//
//   Future<void> saveToHistory(String filePath, String prediction) async {
//     final box = await Hive.openBox<ImageHistory>('historyBox');
//     final history = ImageHistory(
//       filePath: filePath,
//       prediction: prediction,
//       timestamp: DateTime.now(),
//     );
//     await box.add(history);
//   }
//
//   Future<List<ImageHistory>> fetchHistory() async {
//     final box = await Hive.openBox<ImageHistory>('historyBox');
//     return box.values.toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Image Prediction')),
//       body: Column(
//         children: [
//           _image != null
//               ? Image.file(_image!)
//               : Center(child: Text('No image selected')),
//           _prediction != null
//               ? Text('Prediction: $_prediction', style: TextStyle(fontSize: 18))
//               : SizedBox(),
//           ElevatedButton(
//             onPressed: pickImage,
//             child: Text('Pick Image'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (_) => HistoryScreen()));
//             },
//             child: Text('View History'),
//           ),
//         ],
//       ),
//     );
//   }
// }
