import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Models/CountryModel.dart';
import 'package:billapp/Models/NetworkModel.dart';
import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Providers/MobileTopUpProvider.dart';
import 'package:billapp/Providers/PaymentProvider.dart';
import 'package:billapp/Screens/UserHomeScreen.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:unique_device_id/unique_device_id.dart';

class UserPaymentScreen extends StatefulWidget {
  static const routName = "/UserPaymentScreen";

  @override
  State<UserPaymentScreen> createState() => _UserPaymentScreenState();
}

class _UserPaymentScreenState extends State<UserPaymentScreen> {
  final translator = TranslatorGenerator.instance;

  final _formKey = GlobalKey<FormState>();
  final numberController = TextEditingController();
  final dateController = TextEditingController();

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
  late String plan;
  late String customerPass;
  late String country;
  late String provider;
  late String customerAccount;
  late String license;
  late String invoice;
  late String licenseState;
  late String plate;
  late String plateNo;
  late String ticket;
  late String dob;
  late String passenger;
  late String commercial;
  late CategoryModel category;
  NetworkModel? topUpNetwork;
  CountryModel? topUpCountry;
  SubCategoryModel? network;
  SubCategoryModel? carrier;
  SubCategoryModel? company;
  SubCategoryModel? longCompany;
  SubCategoryModel? giftCard;

  @override
  void didChangeDependencies() {
    Map arg = ModalRoute.of(context)!.settings.arguments as Map;
    amount = arg["amount"] ?? "";
    firstName = arg["firstName"] ?? "";
    lastName = arg["lastName"] ?? "";
    city = arg["city"] ?? "";
    plan = arg["plan"] ?? "";
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
    customerAccount = arg["customerAccount"] ?? "";
    customerPass = arg["customerPass"] ?? "";
    country = arg["country"] ?? "";
    provider = arg["provider"] ?? "";
    carrier = arg["carrier"];
    company = arg["company"];
    network = arg["network"];
    giftCard = arg["gifCard"];
    category = arg["category"];
    longCompany = arg["longCompany"];
    topUpNetwork = arg['topUpNetwork'];
    topUpCountry = arg['topUpCountry'];
    license = arg['license'] ?? "";
    licenseState = arg['licenseState'] ?? "";
    invoice = arg['invoice'] ?? "";
    plate = arg['plate'] ?? "";
    plateNo = arg['plateNo'] ?? "";
    ticket = arg['ticker'] ?? "";
    passenger = arg['passenger'] ?? "";
    commercial = arg['commercial'] ?? "";
    dob = arg['dob'] ?? "";
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    numberController.dispose();
    dateController.dispose();
    super.dispose();
  }

  topUp(String orderId) {
    Provider.of<MobileTopupProvider>(context, listen: false)
        .mobileTopup(
      topUpNetwork!.operatorId.toString(),
      amount,
      topUpCountry!.isoName.toString(),
      mobile,
    )
        .then((value) async {
      if (value != "success") {
        await Provider.of<PaymentProvider>(context, listen: false)
            .userOrderStatusMange(orderId);
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
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 200));
      context.loaderOverlay.show();
      Provider.of<PaymentProvider>(context, listen: false)
          .userPayment(
        account: account,
        agentId: "",
        amount: amount,
        callBack: callBack,
        cardExp: dateController.text,
        cardNumber: numberController.text,
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
        categoryName: category.id == "8"
            ? "International Recharge"
            : category.categoryName,
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
        deviceId:
            await UniqueDeviceId.instance.getUniqueId() ?? "didldlfhsjdfkj",
      )
          .then((value) async {
        if (value['code'].toString() == "30") {
          if (category.id == "8") {
            await topUp(value['data'].toString());
          } else {
            context.loaderOverlay.hide();
            Utils().showSuccessDialog(
              context,
              translator.getString("code${value['code']}"),
              () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushNamed(UserHomeScreen.routName);
              },
              subTitle: translator.getString("General.disclaimer"),
            );
          }
        } else {
          context.loaderOverlay.hide();
          if (value['code'].toString() == "0") {
            Utils().showErrorDialog(
              context,
              translator.getString("code${value['code']}"),
            );
          } else {
            Utils().showErrorDialog(
              context,
              value['data'].toString(),
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          titleSpacing: 0,
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
            translator.getString("payment.title"),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Image.asset(
                      "assets/images/card.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  translator.getString("payment.cardNo"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                InputField(
                  color: Colors.white,
                  borderColor: Colors.grey,
                  type: TextInputType.phone,
                  errorTextColor: Colors.red,
                  controller: numberController,
                  hint: translator.getString("payment.cardNoHint"),
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("payment.cardNoEmpty")}!",
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("payment.expiryDate"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                InputField(
                  color: Colors.white,
                  borderColor: Colors.grey,
                  controller: dateController,
                  errorTextColor: Colors.red,
                  type: TextInputType.datetime,
                  hint: translator.getString("payment.expiryDateHint"),
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("payment.expiryDateEmpty")}!",
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
                      translator.getString("payment.textButton"),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    onPressed: pay,
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
