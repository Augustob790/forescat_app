// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:forecast_app/core/widgets/custom_button.dart';

import '../../../core/const/image_constant.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/helpers/theme_helper.dart';
import '../../../core/widgets/custom_image_view.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/input_personalized.dart';
import '../../presentation/store/auth_store.dart';

class SignPageView extends StatefulWidget {
  const SignPageView({super.key});

  @override
  _SignPageViewState createState() => _SignPageViewState();
}

class _SignPageViewState extends State<SignPageView> {
  final auth = Modular.get<AuthStore>();
  final formKey = GlobalKey<FormState>();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  // login(context) async {
  //   setState(() => loading = true);
  //   try {
  //     await auth.login(email.text, senha.text);
  //   } on AuthException catch (e) {
  //     setState(() => loading = false);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.message)));
  //   }
  // }

  // registrar(context) async {
  //   setState(() => loading = true);
  //   try {
  //     await auth.registrar(email.text, senha.text);
  //          Modular.to.pushReplacementNamed('/home');
  //   } on AuthException catch (e) {
  //     setState(() => loading = false);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.message)));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Sign',
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
              child: CustomImageView(
                imagePath: Helpers.imageClima("Clear"),
                height: 122,
                width: 130,
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CustomText(
                      text: "Crie sua conta",
                      fontSize: 35,
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
                    padding: const EdgeInsets.all(20),
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
                  CustomButtonStandard(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          auth.registrar(auth.emailController.text,
                              auth.passwordController.text);
                        }
                      },
                      color: const Color(0xFF947CCD),
                      isLoading: true,
                      text: "Cadastrar",
                      height: 40,
                      width: 200),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
