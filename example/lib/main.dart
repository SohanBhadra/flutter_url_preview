import 'package:flutter/material.dart';
import 'package:flutter_url_preview/flutterurlpreview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Preview Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('URL Preview Example'),
      ),
      body: Container(
        child: UrlPreviewTextField(
          //Create your widget
          child: Container(),
          controller: controller,
          imageWidth: 65,
          imageHeight: 65,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          backgroundColor: Colors.grey.shade300,
          textBoxOuterPadding: EdgeInsets.symmetric(vertical: 8.0),
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
          descriptionStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade800,
          ),
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                borderSide: BorderSide.none),
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            hintText: 'Enter your text here...',
          ),

          //Image Button
          leading: IconButton(
            icon: Icon(Icons.image),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              //Do your stuff when image button click
            },
          ),

          // Send Button
          trailing: IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              //Do your stuff when send button click
            },
          ),
        ),
      ),
    );
  }
}
