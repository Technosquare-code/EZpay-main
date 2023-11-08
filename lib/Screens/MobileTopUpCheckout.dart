import 'package:billapp/Components/InnerCategory.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Models/CountryModel.dart';
import 'package:billapp/Models/NetworkModel.dart';
import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Providers/MobileTopUpProvider.dart';
import 'package:billapp/Providers/PaymentProvider.dart';
import 'package:billapp/Screens/UserPaymentScreen.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileTopupCheckout extends StatefulWidget {
  static const routName = "/MobileTopupCheckout";

  @override
  State<MobileTopupCheckout> createState() => _MobileTopupCheckoutState();
}

class _MobileTopupCheckoutState extends State<MobileTopupCheckout> {
  late String mobile;
  late NetworkModel network;
  late CountryModel country;
  late String amount;
  late String currency;
  late CategoryModel category;
  final translator = TranslatorGenerator.instance;

  @override
  void didChangeDependencies() {
    Map arg = ModalRoute.of(context)!.settings.arguments as Map;
    amount = arg["amount"];
    mobile = arg["mobile"];
    country = arg["country"];
    network = arg["network"];
    category = arg["category"];
    currency = arg["currency"];
    super.didChangeDependencies();
  }

  checkout(String orderId) {
    Provider.of<MobileTopupProvider>(context, listen: false)
        .mobileTopup(
      network.operatorId.toString(),
      amount,
      country.isoName.toString(),
      mobile,
    )
        .then((value) async {
      if (value != "success") {
        await Provider.of<PaymentProvider>(context, listen: false)
            .agentOrderStatusMange(orderId);
      }
      context.loaderOverlay.hide();
      if (value == "success") {
        Utils().showSuccessDialog(
          context,
          "Mobile Topuped Successfully!",
          () async {
            Navigator.of(context).pop();
            await Future.delayed(const Duration(milliseconds: 200));
            Navigator.of(context).pop();
          },
          subTitle: translator.getString("General.disclaimer"),
        );
      } else {
        Utils().showErrorDialog(context, value);
      }
    });
  }

  pay() async {
    context.loaderOverlay.show();
    var auth = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<PaymentProvider>(context, listen: false)
        .agentPayment(
      account: "",
      agentId: auth.currentUser!.id,
      amount: amount,
      callBack: "",
      carreir: "",
      city: "",
      country: country.name,
      customerAccount: "",
      customerAdd: "",
      customerPin: "",
      email: "",
      firstName: "",
      giftcard: "",
      imei: "",
      insureComp: "",
      lastName: "",
      longComp: "",
      mobile2: "",
      mobile3: "",
      mobile4: "",
      mobile5: "",
      mobile6: "",
      mobile: mobile,
      network: network.name,
      planId: "",
      portNo: "",
      simNo: "",
      state: "",
      zip: "",
      provider: "",
      categoryName: "International Recharge",
      carInsurance: "0",
      comcast: "0",
      directv: "0",
      dishNetwork: "0",
      electricBill: "0",
      fios: "0",
      fpl: "0",
      peco: "0",
      philadelphiaGasWorks: "0",
      waterSewerage: "0",
      xfinityPrepaid: "0",
      isInternationalRecharge: "1",
      isCategory: "0",
      attPostpaid: "0",
      tMobilePostpaid: "0",
      verizonPostpaid: "0",
      commercial: "0",
      dob: "",
      invoice: "",
      isEzpass: "0",
      isMotorVehicleTax: "0",
      isParkingTicket: "0",
      license: "",
      licenseState: "",
      passenger: "0",
      plate: "",
      plateNo: "",
      ticket: "",
    )
        .then((value) async {
      if (value['code'].toString() == "30") {
        await auth.updateUser();
      }
      if (value['code'].toString() == "30") {
        await checkout(value['data'].toString());
      } else {
        context.loaderOverlay.hide();
        Utils().showErrorDialog(
          context,
          translator.getString("code${value['code']}"),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          translator.getString("checkout.title"),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LoaderOverlay(
        useDefaultLoading: false,
        disableBackButton: true,
        overlayWidget: const Center(
          child: SpinKitCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: InnerCategory(
                    category.categoryIcon.toString(),
                    category.categoryName.toString(),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Details(
                        title: translator.getString("checkout.mobile"),
                        value: mobile,
                      ),
                      Details(
                        title: translator.getString("checkout.country"),
                        value: country.name,
                      ),
                      Details(
                        title: translator.getString("checkout.network"),
                        value: network.name,
                      ),
                      Details(
                        title: translator.getString("checkout.amount"),
                        value: "$currency $amount",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      fixedSize: Size(
                        MediaQuery.of(context).size.width,
                        45,
                      ),
                    ),
                    child: Text(
                      translator.getString("checkout.textButton"),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    onPressed: () {
                      SharedPreferences.getInstance().then((value) {
                        if (value.getString("type") == "agent") {
                          pay();
                        } else {
                          Navigator.of(context).pushReplacementNamed(
                            UserPaymentScreen.routName,
                            arguments: {
                              "amount": amount,
                              "mobile": mobile,
                              "topUpCountry": country,
                              "topUpNetwork": network,
                              "category": category,
                              "country": country.name,
                              "network": SubCategoryModel(name: network.name),
                            },
                          );
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  final String? title;
  final String? value;

  const Details({
    @required this.title,
    @required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            title.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
