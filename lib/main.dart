import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text to Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TextToAnimation(),
    );
  }
}

class TextToAnimation extends StatefulWidget {
  @override
  _TextToAnimationState createState() => _TextToAnimationState();
}

class _TextToAnimationState extends State<TextToAnimation> {
  final TextEditingController _controller = TextEditingController();
  Map<String, String> data = {
    'manga': 'mango',
    'kalb': 'dog',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text to Animation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Enter text',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final text = _controller.text;
                        List<String> words = text.split(' ');
                        print('Sending text: $text');

                        for (String word in words) {
                          String? value = data[word];
                          if (value != null) {
                            if (value != null) {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: AspectRatio(
                                      aspectRatio: 1,
                                      child: InteractiveViewer(
                                        scaleEnabled: true,
                                        child: ModelViewer(
                                          alt: 'A $value',
                                          backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                                          src: 'assets/$value.glb',
                                          autoPlay: true,
                                          cameraControls: true,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          } else {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('No animation found for "$word"'),
                                );
                              },
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
