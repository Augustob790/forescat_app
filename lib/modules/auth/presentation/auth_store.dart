// ignore_for_file: library_private_types_in_public_api

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../../../core/helpers/helpers.dart';
import '../domain/models/user_model.dart';
import '../services/firebase_services.dart';

part "auth_store.g.dart";

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final service = Modular.get<FirebaseAuthService>();
  final loginFormKey = GlobalKey<FormState>();
  final signFormKey = GlobalKey<FormState>();

  @observable
  TextEditingController emailController = TextEditingController();

  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  dynamic isLoading;

  @observable
  UserModel? userModel;

  @observable
  User? usuario;

  @observable
  Uint8List? images;

  @action
  dispose() async {
    emailController.clear();
    passwordController.clear();
    images?.clear();
  }

  @action
  logout() async {
    await service.logout();
    Modular.to.pushReplacementNamed('/auth/login');
  }

  @action
  getUser() async {
    usuario = await service.getUser();
  }

  @action
  selectImage() async {
    Uint8List img = await Helpers.pickImage(ImageSource.gallery);
    images = img;
  }

  @action
  Future<void> login(String email, String senha) async {
    isLoading = "isLoading";
    try {
      await service.login(email, senha);
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
      await service.signInWithGoogle();
      Modular.to.pushReplacementNamed('/weather/home');
      isLoading = "sucess";
    } catch (e) {
      isLoading = "error";
      throw e.toString();
    }
  }

  @action
  Future<void> registrar(
      String email, String senha, Uint8List file, String image) async {
    isLoading = "isLoading";
    try {
      await service.registrar(email, senha, images!, "");
      getUserFire();
      isLoading = "sucess";
    } catch (e) {
      isLoading = "error";
      throw e.toString();
    }
  }

  @action
  Future<void> getUserFire() async {
    isLoading = "isLoading";
    try {
      userModel = await service.getUserFire();
      isLoading = "sucess";
    } catch (e) {
      isLoading = "error";
      throw e.toString();
    }
  }
}
