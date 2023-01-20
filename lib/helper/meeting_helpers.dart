import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zoom/zoom.dart';

joinMeeting({
  required BuildContext context,
  required TextEditingController meetingIdController,
  required TextEditingController meetingPasswordController,
  Timer? timer,
}) {
  bool _isMeetingEnded(String status) {
    if (Platform.isAndroid)
      return status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    return status == "MEETING_STATUS_ENDED";
  }

  if (meetingIdController.text.isNotEmpty &&
      meetingPasswordController.text.isNotEmpty) {
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
          ZoomMeetingOptions.NO_BUTTON_PARTICIPANTS,
    );
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
  } else {
    if (meetingIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter a valid meeting id to continue."),
      ));
    } else if (meetingPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter a meeting password to start."),
      ));
    }
  }
}

startMeeting({
  required BuildContext context,
  required TextEditingController meetingIdController,
  required TextEditingController meetingPasswordController,
}) {
  bool _isMeetingEnded(String status) {
    var result = false;
    if (Platform.isAndroid) {
      result = status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    } else {
      result = status == "MEETING_STATUS_IDLE";
    }

    return result;
  }

  ZoomOptions zoomOptions = ZoomOptions(
    domain: "zoom.us",
    appKey:
        "XKE4uWfeLwWEmh78YMbC6mqKcF8oM4YHTr9I", //API KEY FROM ZOOM -- SDK KEY
    appSecret:
        "bT7N61pQzaLXU6VLj9TVl7eYuLbqAiB0KAdb", //API SECRET FROM ZOOM -- SDK SECRET
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
        ZoomMeetingOptions.NO_BUTTON_PARTICIPANTS,
  );

  var zoom = Zoom();
  zoom.init(zoomOptions).then((value) {
    if (value[0] == 0) {
      zoom.onMeetingStateChanged;
      zoom
          .startMeeting(meetingOptions)
          .then((loginResult) {})
          .catchError((error) {
        print("[Error Generated] : " + error);
      });
    }
  }).catchError((error) {
    print("[Error Generated] : " + error);
  });
}
