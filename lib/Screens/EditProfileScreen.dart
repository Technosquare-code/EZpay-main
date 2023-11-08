import 'dart:io';

import 'package:billapp/Components/InputField.dart';
import 'package:billapp/Providers/AuthProvider.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:billapp/Utils/MyColor.dart';
import 'package:billapp/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const routName = "/editProfileScreen";
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _imageFile;
  bool setValues = true;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final nameFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final translator = TranslatorGenerator.instance;

  @override
  void didChangeDependencies() {
    if (setValues == true) {
      var auth = Provider.of<AuthProvider>(context, listen: false);
      nameController.text = auth.currentUser!.name ?? "";
      mobileController.text = auth.currentUser!.mobile ?? "";
      setState(() {
        setValues = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    nameFocusNode.dispose();
    mobileFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  void _getImage(ImageSource source) async {
    // ignore: invalid_use_of_visible_for_testing_member
    XFile? image = await ImagePicker.platform.getImage(
      source: source,
      imageQuality: 85,
    );
    setState(() {
      _imageFile = File(image!.path);
    });
    Navigator.pop(context);
  }

  void _openImagePickerModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 150.0,
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                width: double.infinity,
                child: Text(
                  translator.getString("EditProfile.selectSource"),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.camera_alt, color: Colors.black),
                        Text(
                          translator.getString("EditProfile.camera"),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _getImage(ImageSource.camera);
                    },
                  ),
                  TextButton(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.image, color: Colors.black),
                        Text(
                          translator.getString("EditProfile.gallery"),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _getImage(ImageSource.gallery);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  editUser() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 300));
      context.loaderOverlay.show();
      var auth = Provider.of<AuthProvider>(context, listen: false);
      auth
          .editUser(
        nameController.text,
        mobileController.text,
        _imageFile,
      )
          .then((value) async {
        if (value == "15") {
          await auth.updateUser();
          context.loaderOverlay.hide();
          Utils().showSuccessDialog(
            context,
            translator.getString("code$value"),
            () {
              nameController.text = "";
              mobileController.text = "";
              emailController.text = "";
              Navigator.of(context).pop();
              Future.delayed(const Duration(milliseconds: 200)).then((value) {
                Navigator.of(context).pop();
              });
            },
            fontSize: 20,
          );
        } else {
          context.loaderOverlay.hide();
          Utils().showErrorDialog(context, translator.getString("code$value"));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
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
            translator.getString("EditProfile.title"),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: isKeyboardShowing
                ? MediaQuery.of(context).size.height / 1.4
                : MediaQuery.of(context).size.height / 1.15,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.lightBlue,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : auth.currentUser!.profilePicture == ""
                                  ? const AssetImage(
                                      "assets/images/profile.jpg")
                                  : NetworkImage(
                                          "$profileImgUrl${auth.currentUser!.profilePicture}")
                                      as ImageProvider<Object>,
                        ),
                        InkWell(
                          onTap: _openImagePickerModal,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: MyColor.primaryColor,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    translator.getString("EditProfile.name"),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InputField(
                      hint: translator.getString("EditProfile.nameHint"),
                      color: Colors.white,
                      icon: Icons.person,
                      focusNode: nameFocusNode,
                      controller: nameController,
                      borderColor: MyColor.primaryColor,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w600,
                      ),
                      errorTextColor: Colors.red,
                      validator: RequiredValidator(
                        errorText:
                            "* ${translator.getString("EditProfile.nameEmpty")}!",
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    translator.getString("EditProfile.phone"),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InputField(
                      hint: translator.getString("EditProfile.phoneHint"),
                      color: Colors.white,
                      icon: Icons.phone_android,
                      type: TextInputType.number,
                      controller: mobileController,
                      borderColor: MyColor.primaryColor,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w600,
                      ),
                      validator: (v) {
                        if (v == "" || v == null) {
                          return "* ${translator.getString("EditProfile.phoneEmpty")}!";
                        } else if (v.length < 9 || v.length > 11) {
                          return "* ${translator.getString("EditProfile.phoneError")}!";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  if (isKeyboardShowing == false)
                    const Expanded(child: SizedBox(height: 15)),
                  if (isKeyboardShowing == true) const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: MyColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      fixedSize: Size(
                        MediaQuery.of(context).size.width,
                        45,
                      ),
                    ),
                    child: Text(
                      translator.getString("EditProfile.textButton"),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    onPressed: editUser,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
