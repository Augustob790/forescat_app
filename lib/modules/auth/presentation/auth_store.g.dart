// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$emailControllerAtom =
      Atom(name: '_AuthStore.emailController', context: context);

  @override
  TextEditingController get emailController {
    _$emailControllerAtom.reportRead();
    return super.emailController;
  }

  @override
  set emailController(TextEditingController value) {
    _$emailControllerAtom.reportWrite(value, super.emailController, () {
      super.emailController = value;
    });
  }

  late final _$passwordControllerAtom =
      Atom(name: '_AuthStore.passwordController', context: context);

  @override
  TextEditingController get passwordController {
    _$passwordControllerAtom.reportRead();
    return super.passwordController;
  }

  @override
  set passwordController(TextEditingController value) {
    _$passwordControllerAtom.reportWrite(value, super.passwordController, () {
      super.passwordController = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AuthStore.isLoading', context: context);

  @override
  dynamic get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(dynamic value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$userModelAtom =
      Atom(name: '_AuthStore.userModel', context: context);

  @override
  UserModel? get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UserModel? value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  late final _$usuarioAtom = Atom(name: '_AuthStore.usuario', context: context);

  @override
  User? get usuario {
    _$usuarioAtom.reportRead();
    return super.usuario;
  }

  @override
  set usuario(User? value) {
    _$usuarioAtom.reportWrite(value, super.usuario, () {
      super.usuario = value;
    });
  }

  late final _$imagesAtom = Atom(name: '_AuthStore.images', context: context);

  @override
  Uint8List? get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(Uint8List? value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  late final _$disposeAsyncAction =
      AsyncAction('_AuthStore.dispose', context: context);

  @override
  Future dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthStore.logout', context: context);

  @override
  Future logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$getUserAsyncAction =
      AsyncAction('_AuthStore.getUser', context: context);

  @override
  Future getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  late final _$selectImageAsyncAction =
      AsyncAction('_AuthStore.selectImage', context: context);

  @override
  Future selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  late final _$loginAsyncAction =
      AsyncAction('_AuthStore.login', context: context);

  @override
  Future<void> login(String email, String senha) {
    return _$loginAsyncAction.run(() => super.login(email, senha));
  }

  late final _$loginGoogleAsyncAction =
      AsyncAction('_AuthStore.loginGoogle', context: context);

  @override
  Future<void> loginGoogle() {
    return _$loginGoogleAsyncAction.run(() => super.loginGoogle());
  }

  late final _$registrarAsyncAction =
      AsyncAction('_AuthStore.registrar', context: context);

  @override
  Future<void> registrar(
      String email, String senha, Uint8List file, String image) {
    return _$registrarAsyncAction
        .run(() => super.registrar(email, senha, file, image));
  }

  late final _$getUserFireAsyncAction =
      AsyncAction('_AuthStore.getUserFire', context: context);

  @override
  Future<void> getUserFire() {
    return _$getUserFireAsyncAction.run(() => super.getUserFire());
  }

  @override
  String toString() {
    return '''
emailController: ${emailController},
passwordController: ${passwordController},
isLoading: ${isLoading},
userModel: ${userModel},
usuario: ${usuario},
images: ${images}
    ''';
  }
}
