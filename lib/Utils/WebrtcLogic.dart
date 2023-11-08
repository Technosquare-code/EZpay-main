// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
//
// class WebrtcLogic {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//
//   createOffer(RTCPeerConnection peerConnection) async {
//     var offer = await peerConnection.createOffer();
//     await peerConnection.setLocalDescription(offer);
//     var roomWithOffer = {
//       "offer": {
//         "type": offer.type,
//         "sdp": offer.sdp,
//       }
//     };
//     var roomRef = await db.collection('rooms').add(roomWithOffer);
//     var data = roomRef.snapshots().listen((event) async {
//       var data = event.data();
//       var remoteDescription = await peerConnection.getRemoteDescription();
//       if (remoteDescription == null && data!["answer"] != null) {
//         var answer = RTCSessionDescription(
//           data["answer"]["sdp"],
//           data["answer"]["type"],
//         );
//         await peerConnection.setRemoteDescription(answer);
//       }
//     });
//   }
//
//   createAnswer(RTCPeerConnection peerConnection) async {
//     var snapshot = await db.collection('rooms').get();
//     var offer = snapshot.docs.first.data()["offer"];
//     await peerConnection.setRemoteDescription(RTCSessionDescription(
//       offer["sdp"],
//       offer["type"],
//     ));
//     var answer = await peerConnection.createAnswer();
//     await peerConnection.setLocalDescription(answer);
//     var roomWithAnswer = {
//       "answer": {
//         "type": answer.type,
//         "sdp": answer.sdp,
//       }
//     };
//     var roomRef = db.collection('rooms').doc(snapshot.docs.first.id);
//     await roomRef.update(roomWithAnswer);
//     final iceCandidate = await db.collection("condidate").get();
//     var firstCondidate = iceCandidate.docs
//         .lastWhere((element) => element.data()["sdpMid"].toString() == "0");
//     var secondCondidate = iceCandidate.docs
//         .lastWhere((element) => element.data()["sdpMid"].toString() == "1");
//     await peerConnection.addCandidate(RTCIceCandidate(
//       firstCondidate["candidate"],
//       firstCondidate["sdpMid"],
//       firstCondidate["sdpMLineIndex"],
//     ));
//     await peerConnection.addCandidate(RTCIceCandidate(
//       secondCondidate["candidate"],
//       secondCondidate["sdpMid"],
//       secondCondidate["sdpMLineIndex"],
//     ));
//
//     // for (var element in iceCandidate.docs) {
//     //   dynamic candidate = RTCIceCandidate(element.data()['condidate'],
//     //       element.data()['sdpMid'], element.data()['sdpMLineIndex']);
//     //   await peerConnection.addCandidate(candidate);
//     // }
//   }
//
//   // hangUp(RTCPeerConnection peerConnection) async {
//   //   peerConnection.
//   // }
// }
