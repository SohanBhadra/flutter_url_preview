# flutter_url_preview

A Flutter package which finds out URL/Link from text and shows preview of the URL/Link.

Language: [English](README.md)

![Textbox](screenshot/03.png)
![Result](screenshot/04.png)

## What's unique

- provides textfield having leading and trailing widgets
- places the URL preview where you want to place it (above text)
- easy to use

## Getting Started
### Add the following line in your pubspec file
````
flutter_url_preview:
````
    
### Get the package by running the command
````
flutter packages get
````

###  Include the widget in your dart file
````
import 'package:flutter_url_preview/flutterurlpreview.dart';
````

## How to Use

```dart
Container(
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

          //Leading widget for textfield
          leading: IconButton(
            icon: Icon(Icons.image),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              //Do your stuff when image button click
            },
          ),

          // Trailing widget for textfield
          trailing: IconButton(
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              //Put your stuff
            },
          ),
        ),
      ),
```

> You can customize your textfield as you want

## Parameters
|Parameter|Type|Description
|--|--|--
|controller|TextEditingController|Controller for Textfield
|imageWidth|int|Width of URL Preview image
|imageHeight|int|Height of URL Preview image
|maxLines|int|Number of lines in Textfield
|keyboardType|TextInputType|Keyboard type for Textfield
|backgroundColor|Color|Background color of URL Preview,
|textBoxOuterPadding|EdgeInsets|Padding for URL Preview
|titleStyle|TextStyle|Styles for preview Title
|descriptionStyle|TextStyle|Styles for preview Description
|decoration|InputDecoration|Decoration for TextField
|leading|Widget|leading widget
|trailing|Widget|trailing widget

> [Click here for a detailed example](example/lib/main.dart).




