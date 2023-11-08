import 'package:billapp/Models/SubAgentModel.dart';
import 'package:billapp/Screens/AddSubagentWallet.dart';
import 'package:billapp/Screens/SubAgentTransactionScreen.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:billapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translator/flutter_translator.dart';

class SubAgent extends StatelessWidget {
  final SubAgentModel subAgent;
  final Function(String subAgentId) deleteAgent;
  final Function(String subAgentId, String amount) topUp;

  const SubAgent(this.subAgent, this.deleteAgent, this.topUp);

  @override
  Widget build(BuildContext context) {
    final translator = TranslatorGenerator.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  backgroundImage: subAgent.profilePicture == ""
                      ? const AssetImage("assets/images/profile.jpg")
                      : NetworkImage("$profileImgUrl${subAgent.profilePicture}")
                          as ImageProvider<Object>,
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.37,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${subAgent.name}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                SubAgentTransactionScreen.routName,
                                arguments: subAgent.id,
                              );
                            },
                            icon: Icon(
                              Icons.insert_chart,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${subAgent.email}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${subAgent.mobile}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "${subAgent.city}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              fixedSize: Size(
                                MediaQuery.of(context).size.width / 4,
                                35,
                              ),
                            ),
                            onPressed: () async {
                              var amount = await showDialog(
                                context: context,
                                builder: (ctx) => AddSubagentWallet(),
                              );
                              if (amount != null) {
                                topUp(subAgent.id.toString(), amount);
                              }
                            },
                            child: Text(
                              translator.getString("SubAgent.topUp"),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              fixedSize: Size(
                                MediaQuery.of(context).size.width / 4,
                                35,
                              ),
                            ),
                            onPressed: () {
                              Utils().showDeleteDialog(
                                context,
                                translator.getString("SubAgent.question"),
                                () {
                                  Navigator.of(context).pop();
                                  Future.delayed(
                                          const Duration(milliseconds: 200))
                                      .then((value) {
                                    deleteAgent(subAgent.id.toString());
                                  });
                                },
                              );
                            },
                            child: Text(
                              translator.getString("SubAgent.delete"),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.black),
        ],
      ),
    );
  }
}
