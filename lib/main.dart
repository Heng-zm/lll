import 'dart:typed_data'; // Add this import for Uint8List
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenSharingApp(),
    );
  }
}

class ScreenSharingApp extends StatefulWidget {
  @override
  _ScreenSharingAppState createState() => _ScreenSharingAppState();
}

class _ScreenSharingAppState extends State<ScreenSharingApp> {
  late http.Client client;
  late http.StreamedResponse streamedResponse;
  late Image screenImage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    fetchStream();
  }

  Future<void> fetchStream() async {
    // Connect to the FastAPI screen-sharing stream
    final url = Uri.parse('http://127.0.0.1:8000/video'); // Your FastAPI endpoint
    streamedResponse = await client.send(http.Request('GET', url));

    // Listen to the stream for MJPEG frames
    streamedResponse.stream.listen((List<int> data) {
      setState(() {
        // Decode MJPEG frames into images
        final img.Image image = img.decodeImage(Uint8List.fromList(data))!;
        screenImage = Image.memory(Uint8List.fromList(img.encodeJpg(image)));
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen Sharing")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : screenImage,  // Display the captured screen
      ),
    );
  }
}
