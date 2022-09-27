import 'package:quizu/src/models/name_model.dart';

abstract class NameStates {}

class InitNameState extends NameStates {}

class LoadingNameState extends NameStates {}

class SuccessNameState extends NameStates {
  final NameModel nameModel;
  SuccessNameState(this.nameModel);
}

class ErrorNameState extends NameStates {
  
}
