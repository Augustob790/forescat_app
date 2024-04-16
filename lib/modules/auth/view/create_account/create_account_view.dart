// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_nullable_for_final_variable_declarations
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:forecast_app/core/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/const/image_constant.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/helpers/theme_helper.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/input_personalized.dart';
import '../../presentation/auth_store.dart';

class SignPageView extends StatefulWidget {
  const SignPageView({super.key});

  @override
  _SignPageViewState createState() => _SignPageViewState();
}

class _SignPageViewState extends State<SignPageView> {
  final auth = Modular.get<AuthStore>();

  final FirebaseStorage storage = FirebaseStorage.instance;

  pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.readAsBytes();
    }
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      auth.images = img;
    });
  }

  Future<void> upload(String path) async {
    File file = File(path);
    try {
      String ref = "images/img-${DateTime.now().toString()}.jpg";
      await storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception("Erro no upload: ${e.code}");
    }
  }

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  pickUploadImage() async {
    XFile? file = await getImage();
    if (file != null) {
      await upload(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Create Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: const EdgeInsets.all(0),
          icon: const SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: const Alignment(0.5, 0),
              end: const Alignment(0.5, 1),
              colors: [
                appTheme.indigo90001,
                appTheme.indigo900,
                appTheme.blueGray900
              ]),
          image: DecorationImage(
              opacity: 0.2,
              image: AssetImage(ImageConstant.imgGroup88),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 140,
                bottom: 10,
              ),
              alignment: Alignment.center,
              child: Stack(children: [
                auth.images != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(auth.images!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://www.pngitem.com/pimgs/m/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      color: Colors.black,
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: () {
                        selectImage();
                      },
                    ))
              ]),
            ),
            Form(
              key: auth.signFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CustomText(
                      text: "Create your account",
                      fontSize: 25,
                      height: 0.08,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: InputPersonalized(
                      controller: auth.emailController,
                      labelText: 'E-mail',
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o email corretamente!';
                        }
                        return null;
                      },
                      obscure: false,
                      height: 55,
                      width: size.width / 1.15,
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InputPersonalized(
                      controller: auth.passwordController,
                      labelText: 'Password',
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informa sua senha!';
                        } else if (value.length < 6) {
                          return 'Sua senha deve ter no mínimo 6 caracteres';
                        }
                        return null;
                      },
                      obscure: false,
                      height: 55,
                      width: size.width / 1.15,
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: CustomButtonStandard(
                        onTap: () {
                          if (auth.signFormKey.currentState!.validate()) {
                            auth.registrar(auth.emailController.text,
                                auth.passwordController.text, auth.images!, "");
                          }
                        },
                        color: const Color(0xFF947CCD),
                        isLoading: true,
                        text: "Sign Up",
                        height: 40,
                        width: size.width / 1.15),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: CustomButtonStandard(
                        onTap: () {
                          pickUploadImage();
                        },
                        color: const Color(0xFF947CCD),
                        isLoading: true,
                        text: "Sign Up",
                        height: 40,
                        width: size.width / 1.15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
