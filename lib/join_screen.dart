import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zoom/zoom.dart';

class JoinWidget extends StatefulWidget {
  @override
  _JoinWidgetState createState() => _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {
  TextEditingController meetingIdController = TextEditingController();
  TextEditingController meetingPasswordController = TextEditingController();
  Timer timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join meeting'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: meetingIdController,
                    decoration: InputDecoration(
                      labelText: 'Meeting ID',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                    controller: meetingPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Meeting Password',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () => joinMeeting(context),
                      child: Text('Join'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () => startMeeting(context),
                      child: Text('Start Meeting'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isMeetingEnded(String status) {
    if (Platform.isAndroid)
      return status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    return status == "MEETING_STATUS_ENDED";
  }

  joinMeeting(BuildContext context) {
    ZoomOptions zoomOptions = new ZoomOptions(
      domain: "zoom.us",
      appKey: "fla19uL95BUsT2aBwlvZEhOYRTBV9s7kc0AF",
      appSecret: "br2ou5QmuVtFzmB805BxyYh2qH17N7uFAnQN",
    );
    var meetingOptions = new ZoomMeetingOptions(
        userId: 'example',
        meetingId: meetingIdController.text,
        meetingPassword: meetingPasswordController.text,
        disableDialIn: "true",
        disableDrive: "true",
        disableInvite: "true",
        disableShare: "true",
        noAudio: "false",
        noDisconnectAudio: "false",
        meetingViewOptions: ZoomMeetingOptions.NO_TEXT_PASSWORD +
            ZoomMeetingOptions.NO_TEXT_MEETING_ID +
            ZoomMeetingOptions.NO_BUTTON_PARTICIPANTS);
    var zoom = Zoom();
    zoom.init(zoomOptions).then((results) {
      if (results[0] == 0) {
        zoom.onMeetingStateChanged.listen((status) {
          print("Meeting Status Stream: " + status[0] + " - " + status[1]);
          if (_isMeetingEnded(status[0])) {
            timer?.cancel();
          }
        });
        zoom.joinMeeting(meetingOptions).then((joinMeetingResult) {
          timer = Timer.periodic(new Duration(seconds: 2), (timer) {
            zoom.meetingStatus(meetingOptions.meetingId).then((status) {
              print("Meeting Status Polling: " + status[0] + " - " + status[1]);
            });
          });
        });
      }
    });
  }

  startMeeting(BuildContext context) {}
}
