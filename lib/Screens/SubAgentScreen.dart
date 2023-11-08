import 'package:billapp/Components/Empty.dart';
import 'package:billapp/Components/MyLoading.dart';
import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Components/SubAgent.dart';
import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Providers/SubAgentProvider.dart';
import 'package:billapp/Screens/AddSubAgentScreen.dart';
import 'package:billapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class SubAgentScreen extends StatefulWidget {
  static const routName = "/SubAgentScreen";

  @override
  State<SubAgentScreen> createState() => _SubAgentScreenState();
}

class _SubAgentScreenState extends State<SubAgentScreen> {
  final translator = TranslatorGenerator.instance;

  deleteAgent(String agentId) {
    context.loaderOverlay.show();
    Provider.of<SubAgentProvider>(context, listen: false)
        .deleteSubAgent(agentId)
        .then((value) {
      if (value == "25") {
        context.loaderOverlay.hide();
        Utils().showSuccessDialog(
          context,
          translator.getString("code$value"),
          () => Navigator.of(context).pop(),
          fontSize: 18,
        );
      } else {
        context.loaderOverlay.hide();
        Utils().showErrorDialog(context, translator.getString("code$value"));
      }
    });
  }

  topUpSubAgent(String agentId, String amount) {
    context.loaderOverlay.show();
    var auth = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<SubAgentProvider>(context, listen: false)
        .addSubAgentWallet(agentId, auth.currentUser!.id.toString(), amount)
        .then((value) async {
      if (value == "35") {
        await auth.updateUser();
        context.loaderOverlay.hide();
        Utils().showSuccessDialog(
          context,
          translator.getString("code$value"),
          () => Navigator.of(context).pop(),
          fontSize: 18,
        );
      } else {
        context.loaderOverlay.hide();
        Utils().showErrorDialog(context, translator.getString("code$value"));
      }
    });
  }

  @override
  void deactivate() {
    Provider.of<SubAgentProvider>(context, listen: false).clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context, listen: false);
    return LoaderOverlay(
      useDefaultLoading: false,
      disableBackButton: true,
      overlayWidget: const Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: TextButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 20,
            ),
            label: Text(
              translator.getString("SubAgent.title"),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AddSubAgentScreen.routName,
              ),
              child: Text(
                translator.getString("SubAgent.add"),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Consumer<SubAgentProvider>(builder: (context, value, child) {
          return value.subAgents != null
              ? value.subAgents!.isEmpty
                  ? Empty()
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        itemCount: value.subAgents!.length,
                        itemBuilder: (ctx, i) => SubAgent(
                          value.subAgents![i],
                          deleteAgent,
                          topUpSubAgent,
                        ),
                      ),
                    )
              : FutureBuilder(
                  future: value.getSubAgents(
                    auth.currentUser!.id.toString(),
                  ),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return MyLoading();
                    } else {
                      return NetWorkError();
                    }
                  },
                );
        }),
      ),
    );
  }
}
