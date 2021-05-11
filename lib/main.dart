import 'package:flutter/material.dart';
import 'package:share/share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp Link Generator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Whatsapp Link Generator'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _message = TextEditingController();

  void _showDialog(String url) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("WhatsApp Link"),
          content: new Text(url),
          actions: <Widget>[
            new TextButton(
              child: new Text("Share Link"),
              onPressed: () {
                // ignore: unnecessary_brace_in_string_interps
                Share.share("My WhatsApp: ${url}");

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: "Type Whatsapp phone number",
                    hintText: "Number",
                    icon: Icon(
                      Icons.phone,
                      size: 24,
                    )),
                keyboardType: TextInputType.phone,
                controller: _phone,
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Custom Message",
                    hintText: "Message",
                    icon: Icon(
                      Icons.message,
                      size: 24,
                    )),
                keyboardType: TextInputType.text,
                controller: _message,
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                ),
                onPressed: () {
                  String url =
                      "https://wa.me/${_phone.text}?text=${_message.text}";
                  _showDialog(url);
                },
                child: Text('Generate & Share Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
