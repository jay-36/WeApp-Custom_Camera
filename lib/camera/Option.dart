import 'package:flutter/material.dart';
import 'package:weapp_3/camera/Camera.dart';
import 'package:weapp_3/camera/VideoRecorder.dart';
class ChooseOption extends StatefulWidget {
  @override
  _ChooseOptionState createState() => _ChooseOptionState();
}
class _ChooseOptionState extends State<ChooseOption> {

  bool photo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
              children: [
                photo ? CameraScreen() : VideoRecorderExample(),
                Positioned(
                  bottom: 60,
                  left: 90,
                  child: FlatButton(
                      onPressed: (){
                        setState(() {
                          photo = true;
                        });
                      },
                      child: Text("Photos",style: TextStyle(fontSize: 18,color: photo == true ? Colors.white : Colors.white38),)
                  ),
                ),
                Positioned(
                  bottom: 60,
                  right: 90,
                  child: FlatButton(
                      onPressed: (){
                        setState(() {
                          photo = false;
                        });
                      },
                      child: Text("Video",style: TextStyle(fontSize: 18,color: photo == true ? Colors.white38 : Colors.white),)
                  ),
                ),

              ],
            )
        )
    );
  }
}

