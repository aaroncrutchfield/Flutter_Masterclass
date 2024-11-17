import 'package:ai_chat_app/app/di/injection_registry.dart';
import 'package:ai_chat_app/features/chat/chat.dart';
import 'package:ai_chat_app/features/chat/widget/chat_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => appRegistry.get<ChatBloc>(),
      child: const ChatView(),
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return const Scaffold(
          body: Column(
            children: [
              ChatAppBar(),
              Expanded(
                child: Center(child: ChatGreeting()),
              ),
              ChatInput(),
            ],
          ),
        );
      },
    );
  }
}
