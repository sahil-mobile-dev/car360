abstract class Failure {
  Failure(this.message);
  final String message;
}

class ServerFailure extends Failure {
  ServerFailure([super.message = 'Server Error']);
}

class NetworkFailure extends Failure {
  NetworkFailure([super.message = 'No Internet Connection']);
}

class CacheFailure extends Failure {
  CacheFailure([super.message = 'Cache Error']);
}

class UnknownFailure extends Failure {
  UnknownFailure([super.message = 'Something went wrong']);
}
