import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Providers/TransactionDetailProvider.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:provider/provider.dart';

class TransactionDetail extends StatelessWidget {
  final String orderId;

  const TransactionDetail(this.orderId);
  @override
  Widget build(BuildContext context) {
    final translator = TranslatorGenerator.instance;
    return ChangeNotifierProvider(
      create: (context) => TransactionDetailProvider(),
      child:
          Consumer<TransactionDetailProvider>(builder: (context, value, child) {
        return value.transaction != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      "${value.transaction!.categoryName}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Divider(color: Colors.black),
                    const SizedBox(height: 15),
                    if (value.transaction!.agentName != "")
                      Detail(
                        translator.getString("TransactionDetail.agentName"),
                        "${value.transaction!.agentName}",
                      ),
                    if (value.transaction!.orderNo != "")
                      Detail(
                        translator.getString("TransactionDetail.transactionNo"),
                        "${value.transaction!.orderNo}",
                      ),
                    if (value.transaction!.mobileNumber != "")
                      Detail(
                        translator.getString("TransactionDetail.mobile"),
                        "${value.transaction!.mobileNumber}",
                      ),
                    if (value.transaction!.mobileNumber2 != "")
                      Detail(
                        translator.getString("TransactionDetail.mobile2"),
                        "${value.transaction!.mobileNumber2}",
                      ),
                    if (value.transaction!.mobileNumber3 != "")
                      Detail(
                        translator.getString("TransactionDetail.mobile3"),
                        "${value.transaction!.mobileNumber3}",
                      ),
                    if (value.transaction!.mobileNumber4 != "")
                      Detail(
                        translator.getString("TransactionDetail.mobile4"),
                        "${value.transaction!.mobileNumber4}",
                      ),
                    if (value.transaction!.mobileNumber5 != "")
                      Detail(
                        translator.getString("TransactionDetail.mobile5"),
                        "${value.transaction!.mobileNumber5}",
                      ),
                    if (value.transaction!.mobileNumber6 != "")
                      Detail(
                        translator.getString("TransactionDetail.mobile6"),
                        "${value.transaction!.mobileNumber6}",
                      ),
                    if (value.transaction!.carrier != "")
                      Detail(
                        translator.getString("TransactionDetail.carier"),
                        "${value.transaction!.carrier}",
                      ),
                    if (value.transaction!.firstName != "")
                      Detail(
                        translator.getString("TransactionDetail.name"),
                        "${value.transaction!.firstName}",
                      ),
                    if (value.transaction!.lastName != "")
                      Detail(
                        translator.getString("TransactionDetail.lastName"),
                        "${value.transaction!.lastName}",
                      ),
                    if (value.transaction!.invoiceNo != "")
                      Detail(
                        translator.getString("TransactionDetail.invoice"),
                        "${value.transaction!.invoiceNo}",
                      ),
                    if (value.transaction!.license != "")
                      Detail(
                        translator.getString("TransactionDetail.license"),
                        "${value.transaction!.license}",
                      ),
                    if (value.transaction!.licenseState != "")
                      Detail(
                        translator.getString("TransactionDetail.licenseState"),
                        "${value.transaction!.licenseState}",
                      ),
                    if (value.transaction!.plate != "")
                      Detail(
                        translator.getString("TransactionDetail.plate"),
                        "${value.transaction!.plate}",
                      ),
                    if (value.transaction!.passenger != "0" ||
                        value.transaction!.commercial != "0")
                      Detail(
                        translator.getString("TransactionDetail.type"),
                        value.transaction!.passenger == "1"
                            ? "Passenger"
                            : "Commercial",
                      ),
                    if (value.transaction!.ticketNo != "")
                      Detail(
                        translator.getString("TransactionDetail.ticketNo"),
                        "${value.transaction!.ticketNo}",
                      ),
                    if (value.transaction!.dob != "")
                      Detail(
                        translator.getString("TransactionDetail.dob"),
                        "${value.transaction!.dob}",
                      ),
                    if (value.transaction!.regNo != "")
                      Detail(
                        translator.getString("TransactionDetail.regNo"),
                        "${value.transaction!.regNo}",
                      ),
                    if (value.transaction!.email != "")
                      Detail(
                        translator.getString("TransactionDetail.email"),
                        "${value.transaction!.email}",
                      ),
                    if (value.transaction!.giftCard != "")
                      Detail(
                        translator.getString("TransactionDetail.giftcard"),
                        "${value.transaction!.giftCard}",
                      ),
                    if (value.transaction!.longDistanceCompany != "")
                      Detail(
                        translator.getString("TransactionDetail.company"),
                        "${value.transaction!.longDistanceCompany}",
                      ),
                    if (value.transaction!.insuranceCompany != "")
                      Detail(
                        translator.getString("TransactionDetail.company"),
                        "${value.transaction!.insuranceCompany}",
                      ),
                    if (value.transaction!.country != "")
                      Detail(
                        translator.getString("TransactionDetail.country"),
                        "${value.transaction!.country}",
                      ),
                    if (value.transaction!.network != "")
                      Detail(
                        translator.getString("TransactionDetail.network"),
                        "${value.transaction!.network}",
                      ),
                    if (value.transaction!.simNumber != "")
                      Detail(
                        translator.getString("TransactionDetail.simNo"),
                        "${value.transaction!.simNumber}",
                      ),
                    if (value.transaction!.iMEI != "")
                      Detail(
                        translator.getString("TransactionDetail.imei"),
                        "${value.transaction!.iMEI}",
                      ),
                    if (value.transaction!.zipcode != "")
                      Detail(
                        translator.getString("TransactionDetail.zipCode"),
                        "${value.transaction!.zipcode}",
                      ),
                    if (value.transaction!.accountNo != "")
                      Detail(
                        translator.getString("TransactionDetail.account"),
                        "${value.transaction!.accountNo}",
                      ),
                    if (value.transaction!.callBackNumber != "")
                      Detail(
                        translator.getString("TransactionDetail.call"),
                        "${value.transaction!.callBackNumber}",
                      ),
                    if (value.transaction!.provider != "")
                      Detail(
                        translator.getString("TransactionDetail.provider"),
                        "${value.transaction!.provider}",
                      ),
                    Detail(
                      translator.getString("TransactionDetail.date"),
                      formatDate(
                        DateTime.parse(value.transaction!.createdDate!),
                        [dd, "-", mm, "-", yyyy],
                      ),
                    ),
                    Detail(
                      translator.getString("TransactionDetail.amount"),
                      ((double.parse(value.transaction!.amount!) -
                                  double.parse(
                                      value.transaction!.processingFees!)) -
                              double.parse(value.transaction!.agencyFee!))
                          .toStringAsFixed(2),
                    ),
                    Detail(
                      translator.getString("TransactionDetail.fee"),
                      "${value.transaction!.processingFees}",
                    ),
                    if (value.transaction!.agencyFee != "0")
                      Detail(
                        translator.getString("TransactionDetail.agencyFee"),
                        "${value.transaction!.agencyFee}",
                      ),
                    Detail(
                      translator.getString("TransactionDetail.totalAmount"),
                      "${value.transaction!.amount}",
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            : FutureBuilder(
                future: value.getTransactionDetail(orderId),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 4,
                      child: SpinKitFadingCircle(
                        color: MyColor.primaryColor,
                        size: 50,
                      ),
                    );
                  } else {
                    return NetWorkError();
                  }
                },
              );
      }),
    );
  }
}

class Detail extends StatelessWidget {
  final String title, value;

  const Detail(this.title, this.value);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
