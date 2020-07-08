# flutter_url_preview

A Flutter package which finds out URL/Link from text and shows preview of the URL/Link.

![Textbox](screenshot/03.png | width=540 | height=960)
![Result](screenshot/04.png | width=540 | height=960)

## What's unique

- provides textfield having leading and trailing widgets
- places the URL preview where you want to place it (above text)
- easy to use

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

> [Click here for a detailed example](example/lib/main.dart).




