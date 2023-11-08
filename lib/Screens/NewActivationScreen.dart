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

class NewActivationScreen extends StatefulWidget {
  static const routName = "/NewActivationScreen";
  @override
  _NewActivationScreenState createState() => _NewActivationScreenState();
}

class _NewActivationScreenState extends State<NewActivationScreen> {
  bool getInput = false;
  String selectedIndex = "";
  PlanModel? plan;
  late String title;
  late CategoryModel category;
  List<PlanModel> planList = [];
  SubCategoryModel? subCategory;
  final _formKey = GlobalKey<FormState>();
  final simController = TextEditingController();
  final imeiController = TextEditingController();
  final zipController = TextEditingController();
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
    simController.dispose();
    imeiController.dispose();
    zipController.dispose();
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
                            translator.getString("Activation.sim"),
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
                            hint: translator.getString("Activation.simHint"),
                            type: TextInputType.phone,
                            errorTextColor: Colors.red,
                            controller: simController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("Activation.simEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("Activation.imei"),
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
                            hint: translator.getString("Activation.imeiHint"),
                            type: TextInputType.number,
                            errorTextColor: Colors.red,
                            controller: imeiController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("Activation.imeiEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("Activation.network"),
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
                            hint:
                                translator.getString("Activation.networkHint"),
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
                                    .getString("Activation.networkEmpty");
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("Activation.email"),
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
                            hint: translator.getString("Activation.emailHint"),
                            type: TextInputType.emailAddress,
                            errorTextColor: Colors.red,
                            controller: emailController,
                            borderColor: Colors.grey,
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText:
                                    "* ${translator.getString("Activation.emailEmpty")}!",
                              ),
                              EmailValidator(
                                errorText:
                                    "* ${translator.getString("Activation.emailError")}!",
                              )
                            ]),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            translator.getString("Activation.zipcode"),
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
                                translator.getString("Activation.zipcodeHint"),
                            type: TextInputType.visiblePassword,
                            errorTextColor: Colors.red,
                            controller: zipController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("Activation.zipcodeEmpty")}!",
                            ),
                          ),
                          const SizedBox(height: 15),
                          if (planList.isNotEmpty)
                            Text(
                              translator.getString("Activation.plan"),
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
                            translator.getString("Activation.amount"),
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
                            hint: translator.getString("Activation.amountHint"),
                            textIcon: "\$",
                            type: TextInputType.number,
                            errorTextColor: Colors.red,
                            controller: amountController,
                            borderColor: Colors.grey,
                            validator: RequiredValidator(
                              errorText:
                                  "* ${translator.getString("Activation.amountEmpty")}!",
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
                                translator.getString("Activation.textButton"),
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
                                      "simNumber": simController.text,
                                      "imei": imeiController.text,
                                      "network": subCategory,
                                      "zipcode": zipController.text,
                                      "comission": plan!.comission,
                                      "email": emailController.text,
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
