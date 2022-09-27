abstract class ResultStates {}

class InitState extends ResultStates {}

class MinusTimeState extends ResultStates {}

class EndTimeState extends ResultStates {}

class LoadingResultState extends ResultStates {}
class SuccessResultState extends ResultStates {}
class ErrorResultState extends ResultStates {}

class NextResultState extends ResultStates {}
class TrueSelectedResultState extends ResultStates {}
class WrongSelectedResultState extends ResultStates {}