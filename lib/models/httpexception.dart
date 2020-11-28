class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
    //return super.toString();
  }
}

//implements uses an abstract class we are signing a contract and we are forced to implement all functions that this class has
