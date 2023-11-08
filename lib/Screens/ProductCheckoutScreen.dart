import 'package:billapp/Components/MyLoading.dart';
import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Providers/CheckoutProvider.dart';
import 'package:billapp/Providers/PaymentProvider.dart';
import 'package:billapp/Screens/DashboardScreen.dart';
import 'package:billapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Components/InnerCategory.dart';
import 'package:billapp/Screens/UserPaymentScreen.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCheckoutScreen extends StatefulWidget {
  static const routName = "/ProductCheckoutScreen";

  @override
  State<ProductCheckoutScreen> createState() => _ProductCheckoutScreenState();
}

class _ProductCheckoutScreenState extends State<ProductCheckoutScreen> {
  late String firstName;
  late String lastName;
  late String city;
  late String state;
  late String address;
  late String zipcode;
  late String account;
  late String mobile;
  late String mobile2;
  late String mobile3;
  late String mobile4;
  late String mobile5;
  late String mobile6;
  late String amount;
  late String email;
  late String simNumber;
  late String callBack;
  late String port;
  late String imei;
  late String customerPass;
  late String country;
  late String plan;
  late String provider;
  late String customerAccount;
  late CategoryModel category;
  late String totalAmount;
  late String comission;
  late String currency;
  late String license;
  late String invoice;
  late String licenseState;
  late String plate;
  late String plateNo;
  late String ticket;
  late String dob;
  late String passenger;
  late String commercial;
  late String agencyFee;
  final translator = TranslatorGenerator.instance;
  SubCategoryModel? network;
  SubCategoryModel? carrier;
  SubCategoryModel? company;
  SubCategoryModel? longCompany;
  SubCategoryModel? giftCard;

  pay() async {
    context.loaderOverlay.show();
    var auth = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<PaymentProvider>(context, listen: false)
        .agentPayment(
      account: account,
      agentId: auth.currentUser!.id,
      amount: totalAmount,
      callBack: callBack,
      carreir: carrier != null ? carrier!.name : "",
      city: city,
      country: country,
      customerAccount: customerAccount,
      customerAdd: address,
      customerPin: customerPass,
      email: email,
      firstName: firstName,
      giftcard: giftCard != null ? giftCard!.name : "",
      imei: imei,
      insureComp: company != null ? company!.name : "",
      lastName: lastName,
      longComp: longCompany != null ? longCompany!.name : "",
      mobile2: mobile2,
      mobile3: mobile3,
      mobile4: mobile4,
      mobile5: mobile5,
      mobile6: mobile6,
      mobile: mobile,
      network: network != null ? network!.name : "",
      planId: plan,
      portNo: port,
      simNo: simNumber,
      state: state,
      zip: zipcode,
      provider: provider,
      invoice: invoice,
      license: license,
      licenseState: licenseState,
      plate: plate,
      plateNo: plateNo,
      ticket: ticket,
      passenger: passenger,
      commercial: commercial,
      dob: dob,
      categoryName:
          category.id == "8" ? "International Recharge" : category.categoryName,
      carInsurance: category.id == "6" ? "1" : "0",
      comcast: category.id == "19" ? "1" : "0",
      directv: category.id == "153" ? "1" : "0",
      dishNetwork: category.id == "153" ? "1" : "0",
      electricBill: category.id == "155" ? "1" : "0",
      fios: category.id == "27" ? "1" : "0",
      fpl: category.id == "148" ? "1" : "0",
      peco: category.id == "154" ? "1" : "0",
      philadelphiaGasWorks: category.id == "156" ? "1" : "0",
      waterSewerage: category.id == "26" ? "1" : "0",
      xfinityPrepaid: category.id == "18" ? "1" : "0",
      isInternationalRecharge: category.id == "8" ? "1" : "0",
      isEzpass: category.id == "159" ? "1" : "0",
      isMotorVehicleTax: category.id == "158" ? "1" : "0",
      isParkingTicket: category.id == "157" ? "1" : "0",
      isCategory: category.id == "6"
          ? "1"
          : category.id == "19"
              ? "1"
              : category.id == "153"
                  ? "1"
                  : category.id == "155"
                      ? "1"
                      : category.id == "27"
                          ? "1"
                          : category.id == "148"
                              ? "1"
                              : category.id == "154"
                                  ? "1"
                                  : category.id == "156"
                                      ? "1"
                                      : category.id == "152"
                                          ? "1"
                                          : category.id == "26"
                                              ? "1"
                                              : category.id == "18"
                                                  ? "1"
                                                  : category.id == "3"
                                                      ? carrier!.name ==
                                                              "AT&T POSTPAID"
                                                          ? "1"
                                                          : carrier!.name ==
                                                                  "T-MOBILE POSTPAID"
                                                              ? "1"
                                                              : carrier!.name ==
                                                                      "VERIZON POSTPAID"
                                                                  ? "1"
                                                                  : "0"
                                                      : "0",
      attPostpaid: carrier != null
          ? carrier!.name == "AT&T POSTPAID"
              ? "1"
              : "0"
          : "0",
      tMobilePostpaid: carrier != null
          ? carrier!.name == "T-MOBILE POSTPAID"
              ? "1"
              : "0"
          : "0",
      verizonPostpaid: carrier != null
          ? carrier!.name == "VERIZON POSTPAID"
              ? "1"
              : "0"
          : "0",
    )
        .then((value) async {
      if (value['code'].toString() == "30") {
        await auth.updateUser();
      }
      context.loaderOverlay.hide();
      if (value['code'].toString() == "30") {
        Utils().showSuccessDialog(
          context,
          translator.getString("code${value['code']}"),
          () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushNamed(DashboardScreen.routName);
          },
          subTitle: translator.getString("General.disclaimer"),
        );
      } else {
        Utils().showErrorDialog(
          context,
          translator.getString("code${value['code']}"),
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    Map arg = ModalRoute.of(context)!.settings.arguments as Map;
    amount = arg["amount"] ?? "";
    firstName = arg["firstName"] ?? "";
    lastName = arg["lastName"] ?? "";
    city = arg["city"] ?? "";
    state = arg["state"] ?? "";
    address = arg["address"] ?? "";
    zipcode = arg["zipcode"] ?? "";
    account = arg["account"] ?? "";
    mobile = arg["mobile"] ?? "";
    mobile2 = arg["mobile2"] ?? "";
    mobile3 = arg["mobile3"] ?? "";
    mobile4 = arg["mobile4"] ?? "";
    mobile5 = arg["mobile5"] ?? "";
    mobile6 = arg["mobile6"] ?? "";
    email = arg["email"] ?? "";
    simNumber = arg["simNumber"] ?? "";
    callBack = arg["callBack"] ?? "";
    port = arg["port"] ?? "";
    imei = arg["imei"] ?? "";
    plan = arg["plan"] ?? "";
    provider = arg["provider"] ?? "";
    customerPass = arg["customerPass"] ?? "";
    customerAccount = arg["customerAccount"] ?? "";
    country = arg["country"] ?? "";
    carrier = arg["carrier"];
    company = arg["company"];
    network = arg["network"];
    giftCard = arg["gifCard"];
    category = arg["category"];
    longCompany = arg["longCompany"];
    comission = arg["comission"];
    currency = arg['currency'] ?? "";
    license = arg['license'] ?? "";
    licenseState = arg['licenseState'] ?? "";
    invoice = arg['invoice'] ?? "";
    plate = arg['plate'] ?? "";
    plateNo = arg['plateNo'] ?? "";
    ticket = arg['ticket'] ?? "";
    passenger = arg['passenger'] ?? "";
    commercial = arg['commercial'] ?? "";
    dob = arg['dob'] ?? "";
    if (comission != "") {
      agencyFee = "0";
      Provider.of<CheckoutProvider>(context, listen: false)
          .setAmount(comission);
      totalAmount =
          (double.parse(amount) + double.parse(comission)).toStringAsFixed(2);
    }
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    Provider.of<CheckoutProvider>(context, listen: false).clear();
    super.deactivate();
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
          child: Consumer<CheckoutProvider>(
            builder: (context, value, child) {
              if (value.amount != null && comission == "") {
                comission = value.amount!;
                agencyFee = value.agencyFee!;
                totalAmount = (double.parse(amount) +
                        double.parse(value.amount!) +
                        double.parse(value.agencyFee!))
                    .toStringAsFixed(2);
              }
              return value.amount != null
                  ? SingleChildScrollView(
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
                                if (firstName != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.firstName"),
                                    value: firstName,
                                  ),
                                if (lastName != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.lastName"),
                                    value: lastName,
                                  ),
                                if (state != "")
                                  Details(
                                    title:
                                        translator.getString("checkout.state"),
                                    value: state,
                                  ),
                                if (city != "")
                                  Details(
                                    title:
                                        translator.getString("checkout.city"),
                                    value: city,
                                  ),
                                if (invoice != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.invoice"),
                                    value: invoice,
                                  ),
                                if (license != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.license"),
                                    value: license,
                                  ),
                                if (licenseState != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.licenseState"),
                                    value: licenseState,
                                  ),
                                if (plate != "")
                                  Details(
                                    title:
                                        translator.getString("checkout.plate"),
                                    value: plate,
                                  ),
                                if (plateNo != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.plateNo"),
                                    value: plateNo,
                                  ),
                                if (ticket != "")
                                  Details(
                                    title:
                                        translator.getString("checkout.ticket"),
                                    value: ticket,
                                  ),
                                if (passenger != "" && commercial != "")
                                  Details(
                                    title:
                                        translator.getString("checkout.type"),
                                    value: passenger == "1"
                                        ? "Passenger"
                                        : "Commercial",
                                  ),
                                if (dob != "")
                                  Details(
                                    title: translator.getString("checkout.dob"),
                                    value: dob,
                                  ),
                                if (email != "")
                                  Details(
                                    title:
                                        translator.getString("checkout.email"),
                                    value: email,
                                  ),
                                if (mobile != "")
                                  Details(
                                    title:
                                        translator.getString("checkout.mobile"),
                                    value: mobile,
                                  ),
                                if (mobile2 != "")
                                  Details(
                                    title:
                                        "${translator.getString("checkout.mobile")} 2",
                                    value: mobile2,
                                  ),
                                if (mobile3 != "")
                                  Details(
                                    title:
                                        "${translator.getString("checkout.mobile")} 3",
                                    value: mobile3,
                                  ),
                                if (mobile4 != "")
                                  Details(
                                    title:
                                        "${translator.getString("checkout.mobile")} 4",
                                    value: mobile4,
                                  ),
                                if (mobile5 != "")
                                  Details(
                                    title:
                                        "${translator.getString("checkout.mobile")} 5",
                                    value: mobile5,
                                  ),
                                if (mobile6 != "")
                                  Details(
                                    title:
                                        "${translator.getString("checkout.mobile")} 6",
                                    value: mobile6,
                                  ),
                                if (address != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.address"),
                                    value: address,
                                  ),
                                if (zipcode != "")
                                  Details(
                                    title: translator.getString("checkout.zip"),
                                    value: zipcode,
                                  ),
                                if (simNumber != "")
                                  Details(
                                    title: translator.getString("checkout.sim"),
                                    value: simNumber,
                                  ),
                                if (imei != "")
                                  Details(
                                    title:
                                        translator.getString("checkout.imei"),
                                    value: imei,
                                  ),
                                if (port != "")
                                  Details(
                                    title:
                                        translator.getString("checkout.port"),
                                    value: port,
                                  ),
                                if (callBack != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.callBack"),
                                    value: callBack,
                                  ),
                                if (account != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.account"),
                                    value: account,
                                  ),
                                if (customerPass != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.password"),
                                    value: customerPass,
                                  ),
                                if (country != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.country"),
                                    value: country,
                                  ),
                                if (carrier != null)
                                  Details(
                                    title: translator
                                        .getString("checkout.carrier"),
                                    value: carrier!.name,
                                  ),
                                if (company != null)
                                  Details(
                                    title: translator
                                        .getString("checkout.company"),
                                    value: company!.name,
                                  ),
                                if (longCompany != null)
                                  Details(
                                    title: translator
                                        .getString("checkout.company"),
                                    value: longCompany!.name,
                                  ),
                                if (network != null)
                                  Details(
                                    title: translator
                                        .getString("checkout.network"),
                                    value: network!.name,
                                  ),
                                if (provider != "")
                                  Details(
                                    title: translator
                                        .getString("checkout.provider"),
                                    value: provider,
                                  ),
                                if (giftCard != null)
                                  Details(
                                    title: translator
                                        .getString("checkout.giftCard"),
                                    value: giftCard!.name,
                                  ),
                                Details(
                                  title:
                                      translator.getString("checkout.amount"),
                                  value:
                                      "${currency == "" ? "\$" : currency} $amount",
                                ),
                                if (category.id != "8")
                                  Details(
                                    title: translator.getString("checkout.fee"),
                                    value: "\$ $comission",
                                  ),
                                if (category.id == "157" ||
                                    category.id == "158" ||
                                    category.id == "159")
                                  Details(
                                    title: translator
                                        .getString("checkout.agencyFee"),
                                    value: "\$ $agencyFee",
                                  ),
                                if (category.id != "8")
                                  Details(
                                    title:
                                        translator.getString("checkout.total"),
                                    value:
                                        "${currency == "" ? "\$" : currency} $totalAmount",
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
                                        "plan": plan,
                                        "amount": totalAmount,
                                        "firstName": firstName,
                                        "lastName": lastName,
                                        "city": city,
                                        "state": state,
                                        "address": address,
                                        "zipcode": zipcode,
                                        "account": account,
                                        "mobile": mobile,
                                        "mobile2": mobile2,
                                        "mobile3": mobile3,
                                        "mobile4": mobile4,
                                        "mobile5": mobile5,
                                        "mobile6": mobile6,
                                        "email": email,
                                        "simNumber": simNumber,
                                        "callBack": callBack,
                                        "port": port,
                                        "imei": imei,
                                        "customerPass": customerPass,
                                        "country": country,
                                        "carrier": carrier,
                                        "company": company,
                                        "network": network,
                                        "gifCard": giftCard,
                                        "category": category,
                                        "customerAccount": customerAccount,
                                        "longCompany": longCompany,
                                        "provider": provider,
                                        "invoice": invoice,
                                        "license": license,
                                        "licenseState": licenseState,
                                        "plate": plate,
                                        "plateNo": plateNo,
                                        "ticket": ticket,
                                        "passenger": passenger,
                                        "commercial": commercial,
                                        "dob": dob,
                                      },
                                    );
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : FutureBuilder(
                      future: value.getInfoContent(
                        category.id == "3"
                            ? carrier!.name == "AT&T POSTPAID"
                                ? "att_postpaid"
                                : carrier!.name == "T-MOBILE POSTPAID"
                                    ? "t_mobile_postpaid"
                                    : carrier!.name == "VERIZON POSTPAID"
                                        ? "verizon_postpaid"
                                        : ""
                            : category.id == "6"
                                ? "car_insurance"
                                : category.id == "19"
                                    ? "comcast"
                                    : category.id == "153"
                                        ? "directv"
                                        : category.id == "155"
                                            ? "dish_network"
                                            : category.id == "27"
                                                ? "electric_bill"
                                                : category.id == "148"
                                                    ? "fios"
                                                    : category.id == "154"
                                                        ? "fpl"
                                                        : category.id == "156"
                                                            ? "peco"
                                                            : category.id ==
                                                                    "152"
                                                                ? "philadelphia_gas_works"
                                                                : category.id ==
                                                                        "26"
                                                                    ? "water_sewerage"
                                                                    : category.id ==
                                                                            "30"
                                                                        ? "xfinity"
                                                                        : category.id ==
                                                                                "159"
                                                                            ? "ezpass"
                                                                            : category.id == "158"
                                                                                ? "motor_vehcle_excise_tax"
                                                                                : category.id == "157"
                                                                                    ? "parking_tickets"
                                                                                    : "",
                      ),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return MyLoading();
                        } else {
                          return NetWorkError();
                        }
                      },
                    );
            },
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
