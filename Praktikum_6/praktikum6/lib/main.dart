import 'dart:async'; 
import 'package:flutter/material.dart'; 
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; 
 
void main() => runApp(new MaterialApp( 
      theme: ThemeData( 
          appBarTheme: AppBarTheme( 
        color: Colors.amber, 
      )), 
      home: new MyApp(), 
      debugShowCheckedModeBanner: false, 
    )); 
 
class MyApp extends StatefulWidget { 
  @override 
  _MyAppState createState() => _MyAppState(); 
} 
 
class _MyAppState extends State<MyApp> { 
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();
       @override 
  void initState() { 
    super.initState(); 
    var initializationSettingsAndroid = 
        AndroidInitializationSettings('flutter_devs'); 
    var initializationSettingsIOs = IOSInitializationSettings(); 
    var initSetttings = InitializationSettings( 
        initializationSettingsAndroid, initializationSettingsIOs); 
 
    flutterLocalNotificationsPlugin.initialize(initSetttings, 
        onSelectNotification: onSelectNotification); 
  } 
 
  Future onSelectNotification(String payload) { 
    Navigator.of(context).push(MaterialPageRoute(builder: (_) { 
      return NewScreen( 
        payload: payload, 
      ); 
    })); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: new AppBar( 
        backgroundColor: Colors.amber, 
        title: new Text('Flutter notification demo'), 
      ), 
      body: new Center( 
        child: Column( 
          children: <Widget>[ 
            ButtonTheme( 
              minWidth: 250.0, 
              child: RaisedButton( 
                color: Colors.blueAccent, 
                onPressed: showNotification, 
                child: new Text( 
                  'showNotification', 
                ), 
              ), 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
   showNotification() async { 
    var android = new AndroidNotificationDetails( 
        'id', 'channel ', 'description', 
        priority: Priority.High, importance: Importance.Max); 
    var iOS = new IOSNotificationDetails(); 
    var platform = new NotificationDetails(android, iOS); 
    await flutterLocalNotificationsPlugin.show( 
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform, 
        payload: 'Welcome to the Local Notification demo '); 
  } 
 
class NewScreen extends StatelessWidget { 
  String payload; 
 
  NewScreen({ 
    @required this.payload, 
  }); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        title: Text(payload), 
      ), 
    ); 
  } 
} 