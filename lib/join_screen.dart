import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zoom_sdk_integration/helper/meeting_helpers.dart';
import 'package:zoom_sdk_integration/helper/size_helpers.dart';
import 'package:zoom_sdk_integration/widgets/default_text_box.dart';

class JoinWidget extends StatefulWidget {
  @override
  _JoinWidgetState createState() => _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {
  TextEditingController meetingIdController = TextEditingController();
  TextEditingController meetingPasswordController = TextEditingController();
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoom SDK Integration'),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: DefaultTextBox(
                  hintText: "Meeting ID",
                  labelText: "Meeting ID",
                  textColor: Color(0xFF9D9D9D),
                  icon: const Icon(
                    Icons.supervised_user_circle,
                    color: Colors.blue,
                  ),
                  textEditingController: meetingIdController,
                  textInputType: TextInputType.name,
                  obscureText: false,
                  enabled: true,
                  backgroundColor: Color(0xFFFFFFFF),
                  borderColor: Colors.blue,
                  showBorder: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: DefaultTextBox(
                  hintText: "Meeting Password",
                  labelText: "Meeting Password",
                  textColor: Color(0xFF9D9D9D),
                  icon: const Icon(
                    Icons.password_rounded,
                    color: Colors.blue,
                  ),
                  textEditingController: meetingPasswordController,
                  textInputType: TextInputType.name,
                  obscureText: false,
                  enabled: true,
                  backgroundColor: Color(0xFFFFFFFF),
                  borderColor: Colors.blue,
                  showBorder: true,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(44),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) * 0.16,
                    vertical: displayHeight(context) * 0.02,
                  ),
                ),
                child: Text("Join Meeting"),
                onPressed: () => joinMeeting(
                  context: context,
                  meetingIdController: meetingIdController,
                  meetingPasswordController: meetingPasswordController,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     elevation: 5,
              //     backgroundColor: Colors.blue,
              //     shape: RoundedRectangleBorder(
              //       side: BorderSide(
              //         color: Colors.blue,
              //       ),
              //       borderRadius: BorderRadius.circular(44),
              //     ),
              //     padding: EdgeInsets.symmetric(
              //       horizontal: displayWidth(context) * 0.16,
              //       vertical: displayHeight(context) * 0.02,
              //     ),
              //   ),
              //   onPressed: () => startMeeting(
              //     context: context,
              //     meetingIdController: meetingIdController,
              //     meetingPasswordController: meetingPasswordController,
              //   ),
              //   child: Text('Start Meeting'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
