part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class NavigateBack extends ChatEvent {
  const NavigateBack();
}

class ChooseProject extends ChatEvent {
  const ChooseProject();
}

class ChooseModel extends ChatEvent {
  const ChooseModel();
}
