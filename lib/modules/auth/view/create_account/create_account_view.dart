// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_nullable_for_final_variable_declarations
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:forecast_app/core/helpers/scaffold_mensseger_ui.dart';
import 'package:forecast_app/core/widgets/custom_button.dart';
import '../../../../core/const/image_constant.dart';
import '../../../../core/helpers/theme_helper.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/input_personalized.dart';
import '../../presentation/auth_store.dart';

class SignPageView extends StatefulWidget {
  const SignPageView({super.key, required this.authStore});

  final AuthStore authStore;

  @override
  _SignPageViewState createState() => _SignPageViewState();
}

class _SignPageViewState extends State<SignPageView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.5, 0.5),
              end: const Alignment(0.5, 2.5),
              colors: [appTheme.indigo900, appTheme.blueGray700],
            ),
          ),
        ),
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
      body: Observer(builder: (context) {
        return Container(
        height: size.height,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Stack(children: [
                    widget.authStore.images != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                MemoryImage(widget.authStore.images!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://icons.veryicon.com/png/o/miscellaneous/rookie-official-icon-gallery/225-default-avatar.png'),
                          ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          color: Colors.black,
                          icon: const Icon(Icons.add_a_photo),
                          onPressed: () {
                            widget.authStore.selectImage();
                          },
                        ))
                  ]),
                ),
                Form(
                  key: widget.authStore.signFormKey,
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
                          controller: widget.authStore.emailController,
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
                          controller: widget.authStore.passwordController,
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
                            onTap: () async {
                              if (widget.authStore.signFormKey.currentState!
                                      .validate() &&
                                  widget.authStore.images != null) {
                                try {
                                  await widget.authStore.registrar(
                                      widget.authStore.emailController.text,
                                      widget.authStore.passwordController.text,
                                      widget.authStore.images!,
                                      "");
                                  Modular.to
                                      .pushReplacementNamed('/weather/home');
                                } catch (e) {
                                  MessagesUi().snackE(context, e.toString());
                                }
                              } else {
                                MessagesUi().snackUi(context,
                                    "Prencha todos os campos e selecione uma foto!");
                              }
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
      }),
    );
  }
}
