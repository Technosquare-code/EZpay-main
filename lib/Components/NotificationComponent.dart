import 'package:billapp/Models/NotificationModel.dart';
import 'package:flutter/material.dart';

class NotificationComponent extends StatelessWidget {
  final NotificationModel notification;

  const NotificationComponent(this.notification);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        notification.notiTitle.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Text(
                      notification.notiDescription.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notification.createdDate.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 7),
          Divider(
            color: Colors.grey.shade300,
            thickness: 0.8,
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}
