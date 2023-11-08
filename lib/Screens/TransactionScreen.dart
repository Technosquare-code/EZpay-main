import 'package:billapp/Components/MyRangeDatePicker.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:billapp/Components/Empty.dart';
import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Components/Transaction.dart';
import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Components/TransactionLoading.dart';
import 'package:billapp/Providers/TransactionProvider.dart';
import 'package:flutter_translator/flutter_translator.dart';

class TransactionScreen extends StatefulWidget {
  static const routName = "/transactionScreen";
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final translator = TranslatorGenerator.instance;
  late DateTime fromDate;
  late DateTime toDate;
  late String startDate;
  late String endDate;

  @override
  void initState() {
    DateTime now = DateTime.now();
    fromDate = DateTime(now.year, now.month, 1);
    toDate = DateTime(now.year, now.month + 1, 0);
    startDate = formatDate(fromDate, [yyyy, "/", mm, "/", dd]);
    endDate = formatDate(toDate, [yyyy, "/", mm, "/", dd]);
    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<TransactionProvider>(context, listen: false).clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Text(
          translator.getString("Transaction.title"),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<TransactionProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$startDate to $endDate",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var r = await showModalBottomSheet(
                          context: context,
                          builder: (ctx) => MyRangeDatePicker(),
                        );
                        if (r != null) {
                          fromDate = r['start'];
                          toDate = r['end'];
                          startDate =
                              formatDate(fromDate, [yyyy, "/", mm, "/", dd]);
                          endDate =
                              formatDate(toDate, [yyyy, "/", mm, "/", dd]);
                          setState(() {});
                          value.update();
                        }
                      },
                      child: Text(
                        translator.getString("General.selectDate"),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          decorationThickness: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Column(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${value.totalOrder}",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            translator.getString("Transaction.totalOrder"),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Column(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            value.totalSales.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            translator.getString("Transaction.totalSale"),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(color: Colors.grey),
              value.transactions != null
                  ? value.transactions!.isEmpty
                      ? Empty()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.transactions!.length,
                          itemBuilder: (ctx, i) => Transaction(
                            value.transactions![i],
                          ),
                        )
                  : FutureBuilder(
                      future: value.getTransactions(
                        auth.currentUser!.id.toString(),
                        fromDate,
                        toDate,
                      ),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return TransactionLoading();
                        } else {
                          return NetWorkError();
                        }
                      },
                    ),
            ],
          ),
        );
      }),
    );
  }
}
