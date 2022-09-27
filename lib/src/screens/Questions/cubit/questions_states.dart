abstract class QuestionsStates {}

class InitState extends QuestionsStates {}

class MinusTimeState extends QuestionsStates {}

class EndTimeState extends QuestionsStates {}

class LoadingQuestionsState extends QuestionsStates {}
class SuccessQuestionsState extends QuestionsStates {}
class ErrorQuestionsState extends QuestionsStates {}

class NextQuestionsState extends QuestionsStates {}
class TrueSelectedQuestionsState extends QuestionsStates {}
class WrongSelectedQuestionsState extends QuestionsStates {}