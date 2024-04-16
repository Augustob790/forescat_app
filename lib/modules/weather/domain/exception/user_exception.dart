class UserException implements Exception {
  final String message;

  UserException({required this.message});

  UserException.generic()
      : message = 'Não foi possivel se conectar com o servidor!.';
}
