import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:weapp_3/Button.dart';
import 'package:weapp_3/Refresh/PullToRefresh.dart';

List<CameraDescription> cameras = [];

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();

  } on CameraException catch (e) {
    // logError(e.code, e.description);
    print(e.code + e.description);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ButtonDemo(),
      // home: ChooseOption(),
    );
  }
}




