import 'package:connectivity_status/connectivity_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting
        // the app, try changing the primarySwatch below to Colors.green
        // and then invoke "hot reload" (press "r" in the console where
        // you ran "flutter run", or press Run > Hot Reload App in IntelliJ).
        // Notice that the counter didn't reset back to zero -- the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful,
  // meaning that it has a State object (defined below) that contains
  // fields that affect how it looks.

  // This class is the configuration for the state. It holds the
  // values (in this case the title) provided by the parent (in this
  // case the App widget) and used by the build method of the State.
  // Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _connectivityStatus = 'Unknown';

  @override
  initState() {
    super.initState();
    updateConnectivityState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  updateConnectivityState() async {
    bool isConnected;
    String connectivityStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      isConnected = await ConnectivityStatus.isConnected;
      connectivityStatus = isConnected ? "Connected" : "Not connected";
    } on PlatformException catch (err) {
      connectivityStatus = "Not connected ${err}";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _connectivityStatus = connectivityStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Plugin example app'),
      ),
      body: new Center(
          child: new Row(children: [
        new Text('$_connectivityStatus'),
        new IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () => updateConnectivityState())
      ])),
    );
  }
}
