import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Components/MyDropDown.dart';
import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Components/MyDatePicker.dart';
import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Components/InnerCategory.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:billapp/Screens/ProductCheckoutScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ParkingTicketScreen extends StatefulWidget {
  static const routName = "/ParkingTicketScreen";
  @override
  _ParkingTicketScreenState createState() => _ParkingTicketScreenState();
}

class _ParkingTicketScreenState extends State<ParkingTicketScreen> {
  bool getInput = false;
  SubCategoryModel? subCategory;
  late String title;
  late CategoryModel category;
  List types = [
    SubCategoryModel(image: '', name: 'Passenger'),
    SubCategoryModel(image: '', name: 'Commercial'),
  ];
  final _formKey = GlobalKey<FormState>();
  final ticketController = TextEditingController();
  final licenseController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final amountController = TextEditingController();
  final translator = TranslatorGenerator.instance;

  @override
  void didChangeDependencies() {
    if (getInput == false) {
      Map arg = ModalRoute.of(context)!.settings.arguments as Map;
      category = arg["category"];
      title = arg["title"];
      setState(() {
        getInput = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ticketController.dispose();
    licenseController.dispose();
    dobController.dispose();
    emailController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Center(
                  child: InnerCategory(
                    category.categoryIcon.toString(),
                    category.categoryName.toString(),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  translator.getString("Parking.ticketNo"),
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
                  hint: translator.getString("Parking.ticketNoHint"),
                  type: TextInputType.number,
                  errorTextColor: Colors.red,
                  controller: ticketController,
                  borderColor: Colors.grey,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("Parking.ticketNoEmpty")}!",
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("Parking.plate"),
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
                  hint: translator.getString("Parking.plateHint"),
                  type: TextInputType.visiblePassword,
                  errorTextColor: Colors.red,
                  controller: licenseController,
                  borderColor: Colors.grey,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("Parking.plateEmpty")}!",
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("Parking.type"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                MyDropdown(
                  color: Colors.white,
                  errorTextColor: Colors.red,
                  borderColor: Colors.grey,
                  hint: translator.getString("Parking.typeHint"),
                  items: types,
                  onChanged: (t) {
                    subCategory = t as SubCategoryModel;
                    setState(() {});
                  },
                  validator: (c) {
                    if (c == null) {
                      return "* ${translator.getString("Parking.typeEmpty")}!";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("Parking.dob"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                InputField(
                  readOnly: true,
                  color: Colors.white,
                  hint: translator.getString("Parking.dobHint"),
                  errorTextColor: Colors.red,
                  controller: dobController,
                  borderColor: Colors.grey,
                  onTap: () async {
                    var d = await showModalBottomSheet(
                      context: context,
                      builder: (ctx) => const MyDatePicker(),
                    );
                    if (d != null) {
                      dobController.text = d.toString().split(" ")[0];
                    }
                  },
                  validator: RequiredValidator(
                    errorText: "* ${translator.getString("Parking.dobEmpty")}!",
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("Parking.email"),
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
                  hint: translator.getString("Parking.emailHint"),
                  type: TextInputType.emailAddress,
                  errorTextColor: Colors.red,
                  controller: emailController,
                  borderColor: Colors.grey,
                  validator: MultiValidator([
                    RequiredValidator(
                      errorText:
                          "* ${translator.getString("Parking.emailEmpty")}!",
                    ),
                    EmailValidator(
                      errorText:
                          "* ${translator.getString("Parking.emailError")}!",
                    ),
                  ]),
                ),
                const SizedBox(height: 15),
                Text(
                  translator.getString("Parking.amount"),
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
                  hint: translator.getString("Parking.amountHint"),
                  textIcon: "\$",
                  type: TextInputType.number,
                  errorTextColor: Colors.red,
                  controller: amountController,
                  borderColor: Colors.grey,
                  validator: RequiredValidator(
                    errorText:
                        "* ${translator.getString("Parking.amountEmpty")}!",
                  ),
                ),
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
                      translator.getString("Parking.textButton"),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushReplacementNamed(
                          ProductCheckoutScreen.routName,
                          arguments: {
                            "category": CategoryModel(
                              categoryIcon: category.categoryIcon,
                              categoryName:
                                  category.categoryName!.toLowerCase(),
                              id: category.id,
                            ),
                            "amount": amountController.text,
                            "plateNo": licenseController.text,
                            "ticket": ticketController.text,
                            "email": emailController.text,
                            "dob": dobController.text,
                            "passenger":
                                subCategory!.name == "Passenger" ? "1" : "0",
                            "commercial":
                                subCategory!.name == "Commercial" ? "1" : "0",
                            "comission": "",
                          },
                        );
                      }
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
