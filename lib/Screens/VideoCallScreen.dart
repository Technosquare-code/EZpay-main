// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';

// class VideoCallScreen extends StatefulWidget {
//   static const routName = "/VideoCallScreen";
//   @override
//   _VideoCallScreenState createState() => _VideoCallScreenState();
// }

// class _VideoCallScreenState extends State<VideoCallScreen> {
// // Instantiate the client
//   final AgoraClient client = AgoraClient(
//       agoraConnectionData: AgoraConnectionData(
//           appId: "4df2157a5dfe404cb352605d717fc366",
//           channelName: "fluttering",
//           tempToken:
//               "007eJxTYPDkik/Xuh2740dfo5uIlswjH/6ZbIGX0qrfF+VI3WJXnqzAYJKSZmRoap5ompKWamJgkpxkbGpkZmCaYm5onpZsbGZ29ufC5IZARoalE/8xMEIhiM/FkJZTWlKSWpSZl87AAABuRiD8"),
//       enabledPermission: [
//         Permission.camera,
//         Permission.microphone,
//         Permission.bluetooth
//       ]);

// // Initialize the Agora Engine
//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

//   void initAgora() async {
//     await client.initialize();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         body: Stack(
//           children: [
//             AgoraVideoViewer(
//               client: client,
//               layoutType: Layout.floating,
//               showNumberOfUsers: true,
//             ),
//             AgoraVideoButtons(
//               client: client,
//               enabledButtons: const [
//                 BuiltInButtons.toggleCamera,
//                 BuiltInButtons.callEnd,
//                 BuiltInButtons.toggleMic
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
