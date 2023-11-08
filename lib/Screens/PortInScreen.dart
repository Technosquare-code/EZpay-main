import 'package:billapp/Components/InnerCategory.dart';
import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Components/MyDropDown.dart';
import 'package:billapp/Components/MyLoading.dart';
import 'package:billapp/Components/NetworkError.dart';
import 'package:billapp/Components/Plan.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Models/PlanModel.dart';
import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Providers/CategoriesProvider.dart';
import 'package:billapp/Screens/ProductCheckoutScreen.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/package%20edit/responsive_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class PortInScreen extends StatefulWidget {
  static const routName = "/PortInScreen";
  @override
  _PortInScreenState createState() => _PortInScreenState();
}

class _PortInScreenState extends State<PortInScreen> {
  bool getInput = false;
  String selectedIndex = "";
  String? selectedProvider;
  bool showProviderName = false;
  PlanModel? plan;
  late String title;
  late CategoryModel category;
  List<PlanModel> planList = [];
  SubCategoryModel? subCategory;
  final _formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final zipController = TextEditingController();
  final emailController = TextEditingController();
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final simController = TextEditingController();
  final imeiController = TextEditingController();
  final portController = TextEditingController();
  final callBackController = TextEditingController();
  final amountController = TextEditingController();
  final translator = TranslatorGenerator.instance;

  List<SubCategoryModel> providers = [
    SubCategoryModel(image: "", name: "Cricket Wireless"),
    SubCategoryModel(image: "", name: "Boost Mobile"),
    SubCategoryModel(image: "", name: "Simple Mobile"),
    SubCategoryModel(image: "", name: "LYCAMOBILE"),
    SubCategoryModel(image: "", name: "T-Mobile"),
    SubCategoryModel(image: "", name: "metro by T-Mobile"),
    SubCategoryModel(image: "", name: "Net10"),
    SubCategoryModel(image: "", name: "H20 Wireless"),
    SubCategoryModel(image: "", name: "Go Smart Mobile"),
    SubCategoryModel(image: "", name: "Tracfone Wireless"),
    SubCategoryModel(image: "", name: "Verizon Prepaid"),
    SubCategoryModel(image: "", name: "Verizon Postpaid"),
    SubCategoryModel(image: "", name: "AT&T"),
    SubCategoryModel(image: "", name: "PagePlus Wireless"),
    SubCategoryModel(image: "", name: "Total Wireless"),
    SubCategoryModel(image: "", name: "Ultra Mobile"),
    SubCategoryModel(image: "", name: "OTHER"),
  ];

  getPlans(String subCategoryId) async {
    context.loaderOverlay.show();
    List<PlanModel> result =
        await Provider.of<CategoriesProvider>(context, listen: false)
            .getPlans(category.id.toString(), subCategoryId);
    if (result.isNotEmpty) {
      setState(() {
        planList = result;
        plan = planList.first;
        selectedIndex = planList.first.planPrice.toString();
        amountController.text = planList.first.planPrice.toString();
      });
    }
    context.loaderOverlay.hide();
  }

  @override
  void deactivate() {
    Provider.of<CategoriesProvider>(context, listen: false).clear();
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    if (getInput == false) {
      Map arg = ModalRoute.of(context)!.settings.arguments as Map;
      category = arg["category"];
      title = arg["title"];
      // selectedIndex = planList.first.planPrice.toString();
      // amountController.text = "${planList.first.planPrice}";
      setState(() {
        getInput = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mobileController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    stateController.dispose();
    cityController.dispose();
    addressController.dispose();
    zipController.dispose();
    emailController.dispose();
    accountController.dispose();
    passwordController.dispose();
    simController.dispose();
    imeiController.dispose();
    portController.dispose();
    callBackController.dispose();
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
          child: Consumer<CategoriesProvider>(builder: (context, value, child) {
            return value.subCategories != null
                ? SingleChildScrollView(
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
                            translator.getString("PortIn.firstName"),
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
                            hint: translator.getString("PortIn.firstNameHint"),
                            type: TextInputType.name,
                            errorTextColor: Colors.red,
                            controller: firstNameController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.firstNameEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.lastName"),
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
                            hint: translator.getString("PortIn.lastNameHint"),
                            type: TextInputType.name,
                            errorTextColor: Colors.red,
                            controller: lastNameController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.lastNameEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.state"),
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
                            hint: translator.getString("PortIn.stateHint"),
                            type: TextInputType.name,
                            errorTextColor: Colors.red,
                            controller: stateController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.stateEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.city"),
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
                            hint: translator.getString("PortIn.cityHint"),
                            type: TextInputType.name,
                            errorTextColor: Colors.red,
                            controller: cityController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.cityEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.address"),
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
                            hint: translator.getString("PortIn.addressHint"),
                            type: TextInputType.streetAddress,
                            errorTextColor: Colors.red,
                            controller: addressController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.addressEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.email"),
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
                            hint: translator.getString("PortIn.emailHint"),
                            type: TextInputType.emailAddress,
                            errorTextColor: Colors.red,
                            controller: emailController,
                            borderColor: Colors.grey,
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText:
                                    "* ${translator.getString("PortIn.emailEmpty")}!",
                              ),
                              EmailValidator(
                                errorText:
                                    "* ${translator.getString("PortIn.emailError")}!",
                              ),
                            ]),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.zipcode"),
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
                            hint: translator.getString("PortIn.zipcodeHint"),
                            type: TextInputType.streetAddress,
                            errorTextColor: Colors.red,
                            controller: zipController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.zipcodeEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.account"),
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
                            hint: translator.getString("PortIn.accountHint"),
                            type: TextInputType.number,
                            errorTextColor: Colors.red,
                            controller: accountController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.accountEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.password"),
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
                            hint: translator.getString("PortIn.passwordHint"),
                            type: TextInputType.visiblePassword,
                            errorTextColor: Colors.red,
                            controller: passwordController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.passwordEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.sim"),
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
                            hint: translator.getString("PortIn.simHint"),
                            type: TextInputType.number,
                            errorTextColor: Colors.red,
                            controller: simController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.simEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.imei"),
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
                            hint: translator.getString("PortIn.imeiHint"),
                            type: TextInputType.number,
                            errorTextColor: Colors.red,
                            controller: imeiController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.imeiEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.port"),
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
                            hint: translator.getString("PortIn.portHint"),
                            type: TextInputType.visiblePassword,
                            errorTextColor: Colors.red,
                            controller: portController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.portEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.callBack"),
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
                            hint: translator.getString("PortIn.callBackHint"),
                            type: TextInputType.number,
                            errorTextColor: Colors.red,
                            controller: callBackController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.callBackEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.carrier"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          MyDropdown(
                            color: Colors.white,
                            errorTextColor: Colors.red,
                            borderColor: Colors.grey,
                            hint: translator.getString("PortIn.carrierHint"),
                            items: value.subCategories,
                            onChanged: (s) {
                              setState(() {
                                subCategory = s as SubCategoryModel;
                              });
                              getPlans(subCategory!.id.toString());
                            },
                            validator: (c) {
                              if (c == null) {
                                return translator
                                    .getString("PortIn.carrierEmpty");
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("PortIn.provider"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          MyDropdown(
                            color: Colors.white,
                            errorTextColor: Colors.red,
                            borderColor: Colors.grey,
                            hint: translator.getString("PortIn.providerHint"),
                            items: providers,
                            onChanged: (s) {
                              if ((s as SubCategoryModel).name != "OTHER") {
                                selectedProvider = s.name;
                                setState(() {});
                              } else {
                                showProviderName = true;
                                setState(() {});
                              }
                            },
                            validator: (c) {
                              if (c == null) {
                                return translator
                                    .getString("PortIn.providerEmpty");
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 5),
                          if (showProviderName)
                            InputField(
                              color: Colors.white,
                              hint: translator
                                  .getString("PortIn.providerNameHint"),
                              type: TextInputType.name,
                              errorTextColor: Colors.red,
                              borderColor: Colors.grey,
                              onChanged: (p) {
                                selectedProvider = p;
                                setState(() {});
                              },
                              validator: RequiredValidator(
                                errorText:
                                    "* ${translator.getString("PortIn.providerNameEmpty")}!",
                              ),
                            ),
                          const SizedBox(height: 15),
                          if (planList.isNotEmpty)
                            Text(
                              translator.getString("PortIn.plan"),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (planList.isNotEmpty) const SizedBox(height: 5),
                          if (planList.isNotEmpty)
                            ResponsiveGridList(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              minItemWidth:
                                  MediaQuery.of(context).size.width / 2.5,
                              children: List.generate(
                                planList.length,
                                (i) => Plan(
                                  index: planList[i].planPrice.toString(),
                                  title: planList[i].planName,
                                  selectedIndex: selectedIndex,
                                  image: planList[i].planIcon,
                                  onTap: () {
                                    selectedIndex = planList[i].planPrice!;
                                    plan = planList[i];
                                    setState(() {});
                                    amountController.text =
                                        "${planList[i].planPrice}";
                                  },
                                ),
                              ),
                            ),
                          if (planList.isNotEmpty) const SizedBox(height: 25),
                          Text(
                            translator.getString("PortIn.amount"),
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
                            hint: translator.getString("PortIn.amountHint"),
                            textIcon: "\$",
                            type: TextInputType.number,
                            errorTextColor: Colors.red,
                            controller: amountController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("PortIn.amountEmpty")}!",
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
                                translator.getString("PortIn.textButton"),
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
                                      "plan": plan!.id,
                                      "category": category,
                                      "amount": amountController.text,
                                      "firstName": firstNameController.text,
                                      "lastName": lastNameController.text,
                                      "city": cityController.text,
                                      "state": stateController.text,
                                      "address": addressController.text,
                                      "zipcode": zipController.text,
                                      "email": emailController.text,
                                      "customerAccount": accountController.text,
                                      "customerPass": passwordController.text,
                                      "simNumber": simController.text,
                                      "imei": imeiController.text,
                                      "port": portController.text,
                                      "callBack": callBackController.text,
                                      "carrier": subCategory,
                                      "provider": selectedProvider,
                                      "comission": plan!.comission,
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : FutureBuilder(
                    future: value.getSubCategories(category.id.toString()),
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
      ),
    );
  }
}
