// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../services/firebase_auth_services.dart';

part "auth_store.g.dart";

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final auth = Modular.get<FirebaseAuthService>();
  final loginFormKey = GlobalKey<FormState>();
  final signFormKey = GlobalKey<FormState>();

  @observable
  TextEditingController emailController = TextEditingController();

  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  dynamic isLoading;

  @action
  logout() async {
    await auth.logout();
  }

  @action
  getUser() async {
    await auth.getUser();
  }

  @action
  Future<void> login(String email, String senha) async {
    isLoading = "isLoading";
    try {
      await auth.login(email, senha);
      Modular.to.pushReplacementNamed('/weather/home');
      isLoading = "sucess";
    } catch (e) {
      isLoading = "error";
      throw e.toString();
    }
  }

  @action
  Future<void> loginGoogle() async {
    isLoading = "isLoading";
    try {
      await auth.signInWithGoogle();
      Modular.to.pushReplacementNamed('/weather/home');
      isLoading = "sucess";
    } catch (e) {
      isLoading = "error";
      throw e.toString();
    }
  }

  @action
  Future<void> registrar(String email, String senha) async {
    isLoading = "isLoading";
    try {
      await auth.registrar(email, senha);
      Modular.to.pushReplacementNamed('/weather/home');
      isLoading = "sucess";
    } catch (e) {
      isLoading = "error";
      throw e.toString();
    }
  }
}
