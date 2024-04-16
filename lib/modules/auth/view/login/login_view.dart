// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../../../core/const/image_constant.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/helpers/scaffold_mensseger_ui.dart';
import '../../../../core/helpers/theme_helper.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/input_personalized.dart';
import '../../presentation/auth_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.authStore});

  final AuthStore authStore;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  margin: const EdgeInsets.only(
                    top: 80,
                    bottom: 10,
                  ),
                  alignment: Alignment.center,
                  child: CustomImageView(
                    imagePath: Helpers.imageClima("Clear"),
                    height: 122,
                    width: 130,
                  ),
                ),
                Form(
                  key: widget.authStore.loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CustomText(
                          text: "Welcome",
                          fontSize: 35,
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
                        padding: const EdgeInsets.all(20),
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
                        padding: const EdgeInsets.all(15.0),
                        child: CustomButtonStandard(
                          onTap: () async {
                            if (widget.authStore.loginFormKey.currentState!
                                .validate()) {
                              try {
                                await widget.authStore.login(
                                    widget.authStore.emailController.text,
                                    widget.authStore.passwordController.text);
                                Modular.to
                                    .pushReplacementNamed('/weather/home');
                                widget.authStore.dispose();
                              } catch (e) {
                                MessagesUi().snackE(context, e.toString());
                              }
                            } else {
                              MessagesUi()
                                  .snackE(context, "Prencha todos os campos!");
                            }
                          },
                          color: const Color(0xFF947CCD),
                          isLoading: true,
                          text: "Sign In",
                          height: 40,
                          width: size.width / 1.15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: CustomText(
                                  text: "Or Sign in with",
                                  fontSize: 12,
                                  height: 0.08,
                                  fontWeight: FontWeight.w600,
                                )),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () async {
                            await widget.authStore.loginGoogle();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Not a member?',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 4),
                          TextButton(
                            onPressed: () {
                              Modular.to.pushNamed('/auth/sign');
                              widget.authStore.dispose();
                            },
                            child: const CustomText(
                              text: 'Register now',
                              fontSize: 14,
                              color: Colors.blue,
                              height: 0.08,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
