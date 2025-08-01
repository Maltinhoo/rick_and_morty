import 'package:rick_and_morty/app_imports.dart';

class CharacterException extends IDefaultException {
  CharacterException([
    Object? exception,
    String? message,
    StackTrace? stackTrace,
  ]) : super(
         message ?? 'An unknown error occurred, please try again later!',
         exception ?? Exception(),
         stackTrace,
       );
}
