// import 'dart:convert';
//
// import 'package:billapp/Utils/WebrtcLogic.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
//
// class VideoCallScreen extends StatefulWidget {
//   static const routName = "/VideoCallScreen";
//   @override
//   _VideoCallScreenState createState() => _VideoCallScreenState();
// }
//
// class _VideoCallScreenState extends State<VideoCallScreen> {
//   final _localVideoRenderer = RTCVideoRenderer();
//   final _remoteVideoRenderer = RTCVideoRenderer();
//   final bool _offer = false;
//   String condidate = "";
//   String offerSession = "";
//
//   RTCPeerConnection? _peerConnection;
//   MediaStream? _localStream;
//
//   initRenderer() async {
//     await _localVideoRenderer.initialize();
//     await _remoteVideoRenderer.initialize();
//   }
//
//   _getUserMedia() async {
//     final Map<String, dynamic> mediaConstraints = {
//       'audio': true,
//       'video': {
//         'facingMode': 'user',
//       }
//     };
//
//     MediaStream stream =
//         await navigator.mediaDevices.getUserMedia(mediaConstraints);
//
//     _localVideoRenderer.srcObject = stream;
//     setState(() {});
//     return stream;
//   }
//
//   _createPeerConnecion() async {
//     Map<String, dynamic> configuration = {
//       "iceServers": [
//         {"url": "stun:stun.l.google.com:19302"},
//       ]
//     };
//
//     final Map<String, dynamic> offerSdpConstraints = {
//       "mandatory": {
//         "OfferToReceiveAudio": true,
//         "OfferToReceiveVideo": true,
//       },
//       "optional": [],
//     };
//
//     _localStream = await _getUserMedia();
//
//     RTCPeerConnection pc =
//         await createPeerConnection(configuration, offerSdpConstraints);
//
//     _localStream!.getTracks().forEach((element) {
//       pc.addTrack(element, _localStream!);
//     });
//
//     pc.onIceCandidate = (e) async {
//       Map<String, dynamic> icecandidate = {
//         "candidate": e.candidate,
//         "sdpMid": e.sdpMid,
//         "sdpMLineIndex": e.sdpMLineIndex,
//       };
//       await FirebaseFirestore.instance
//           .collection("condidate")
//           .doc()
//           .set(icecandidate);
//     };
//     pc.onIceConnectionState = (e) {
//       print(" State ------------> ${e.name}");
//     };
//
//     pc.onIceGatheringState = (e) {
//       print("ice gathering ......... ${e.name}");
//     };
//
//     pc.onConnectionState = (c) {
//       print("connetction state ............ ${c.name}");
//     };
//
//     pc.onAddStream = (stream) {
//       print("Hello adding stream");
//       _remoteVideoRenderer.srcObject = stream;
//     };
//
//     pc.onDataChannel = (e) {
//       print("chanennellll ..... ${e.label}");
//     };
//
//     return pc;
//   }
//
//   @override
//   void initState() {
//     initRenderer();
//     _createPeerConnecion().then((pc) {
//       _peerConnection = pc;
//     });
//     super.initState();
//   }
//
//   @override
//   void deactivate() async {
//     await _localVideoRenderer.dispose();
//     await _remoteVideoRenderer.dispose();
//     _peerConnection!.dispose();
//     super.deactivate();
//   }
//
//   @override
//   void dispose() async {
//     await _localVideoRenderer.dispose();
//     await _remoteVideoRenderer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: RTCVideoView(
//               _localVideoRenderer,
//               mirror: true,
//               objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//             ),
//           ),
//           Positioned(
//             left: 25,
//             top: 25,
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width / 4,
//               height: MediaQuery.of(context).size.height / 4,
//               child: RTCVideoView(
//                 _localVideoRenderer,
//                 mirror: true,
//                 objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
//               ),
//             ),
//           ),
//           Center(
//             child: Positioned(
//               bottom: 50,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       WebrtcLogic().createOffer(_peerConnection!);
//                     },
//                     child: const Icon(
//                       Icons.call_to_action,
//                       color: Colors.red,
//                       size: 50,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       WebrtcLogic().createAnswer(_peerConnection!);
//                     },
//                     child: const Icon(
//                       Icons.surround_sound,
//                       color: Colors.blue,
//                       size: 50,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
