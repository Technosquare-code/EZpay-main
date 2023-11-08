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

class GifCardTopupScreen extends StatefulWidget {
  static const routName = "/GifCardTopupScreen";
  @override
  _GifCardTopupScreenState createState() => _GifCardTopupScreenState();
}

class _GifCardTopupScreenState extends State<GifCardTopupScreen> {
  bool getInput = false;
  late String title;
  String selectedIndex = "";
  PlanModel? plan;
  late CategoryModel category;
  List<PlanModel> planList = [];
  SubCategoryModel? subCategory;
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final confirmController = TextEditingController();
  final emailController = TextEditingController();
  final amountController = TextEditingController();
  final translator = TranslatorGenerator.instance;

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
      setState(() {
        getInput = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    confirmController.dispose();
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
                            translator.getString("GiftCard.firstName"),
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
                            hint:
                                translator.getString("GiftCard.firstNameHint"),
                            type: TextInputType.name,
                            errorTextColor: Colors.red,
                            controller: firstNameController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("GiftCard.firstNameEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("GiftCard.lastName"),
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
                            hint: translator.getString("GiftCard.lastNameHint"),
                            type: TextInputType.name,
                            errorTextColor: Colors.red,
                            controller: lastNameController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("GiftCard.lastNameEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("GiftCard.mobile"),
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
                            hint: translator.getString("GiftCard.mobileHint"),
                            type: TextInputType.phone,
                            errorTextColor: Colors.red,
                            controller: mobileController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("GiftCard.mobileEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("GiftCard.mobileConfirm"),
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
                            hint: translator
                                .getString("GiftCard.mobileConfirmHint"),
                            type: TextInputType.phone,
                            errorTextColor: Colors.red,
                            controller: confirmController,
                            borderColor: Colors.grey,
                            validator: (val) {
                              if (val == null || val == "") {
                                return "* ${translator.getString("GiftCard.mobileConfirmEmpty")}!";
                              } else if (val != mobileController.text) {
                                return "* ${translator.getString("GiftCard.mobileConfirmError")}!";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("GiftCard.email"),
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
                            hint: translator.getString("GiftCard.emailHint"),
                            type: TextInputType.emailAddress,
                            errorTextColor: Colors.red,
                            controller: emailController,
                            borderColor: Colors.grey,
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText:
                                    "* ${translator.getString("GiftCard.emailEmpty")}!",
                              ),
                              EmailValidator(
                                errorText:
                                    "* ${translator.getString("GiftCard.emailError")}!",
                              )
                            ]),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("GiftCard.giftCard"),
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
                            hint: translator.getString("GiftCard.giftCardHint"),
                            items: value.subCategories,
                            onChanged: (s) {
                              subCategory = s as SubCategoryModel;
                              setState(() {});
                              getPlans(subCategory!.id!);
                            },
                            validator: (c) {
                              if (c == null) {
                                return translator
                                    .getString("GiftCard.giftCardEmpty");
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          if (planList.isNotEmpty)
                            Text(
                              translator.getString("GiftCard.plan"),
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
                            translator.getString("GiftCard.amount"),
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
                            hint: translator.getString("GiftCard.amountHint"),
                            textIcon: "\$",
                            type: TextInputType.number,
                            errorTextColor: Colors.red,
                            controller: amountController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("GiftCard.amountEmpty")}!",
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
                                translator.getString("GiftCard.textButton"),
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
                                      "mobile": mobileController.text,
                                      "email": emailController.text,
                                      "gifCard": subCategory,
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
