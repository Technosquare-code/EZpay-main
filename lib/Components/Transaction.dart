import 'package:billapp/Components/TransactionDetail.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:billapp/Models/TransactionModel.dart';

class Transaction extends StatelessWidget {
  final TransactionModel transaction;

  const Transaction(this.transaction);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          dense: true,
          title: Text(
            "${transaction.description}",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width / 3,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    formatDate(
                      DateTime.parse(transaction.createdDate.toString()),
                      [dd, '/', mm, '/', yyyy, ' ', hh, ':', mm, ' ', am],
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (transaction.orderId != "")
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      builder: (ctx) => TransactionDetail(transaction.orderId!),
                    );
                  },
                  child: Icon(
                    Icons.remove_red_eye,
                    color: MyColor.primaryColor,
                    size: 20,
                  ),
                ),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              "\$ ${transaction.amount}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Divider(color: Colors.grey, thickness: 0.5),
      ],
    );
  }
}
