import 'package:ai_chat_app/app/theme.dart';
import 'package:ai_chat_app/features/chat/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChatBackButton(),
          Expanded(child: ChatTitle()),
          SizedBox(width: 100),
        ],
      ),
    );
  }
}

class ChatTitle extends StatelessWidget {
  const ChatTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatBloc>();
    final textTheme = context.theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => bloc.add(const ChooseModel()),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Claude 3.5 Sonnet',
                style: textTheme.bodyLarge,
              ),
              const Icon(
                size: 16,
                Icons.expand_more,
                color: Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        TextButton.icon(
          onPressed: () => bloc.add(const ChooseProject()),
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            backgroundColor: const Color(0xFF2A2A2A),
          ),
          icon: const Icon(
            Icons.category_outlined,
            size: 16,
            color: Colors.white,
          ),
          label: Text('Choose project', style: textTheme.labelSmall),
        ),
      ],
    );
  }
}

class ChatBackButton extends StatelessWidget {
  const ChatBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatBloc>();
    final textTheme = context.theme.textTheme;

    return TextButton.icon(
      onPressed: () => bloc.add(const NavigateBack()),
      icon: const Icon(
        Icons.arrow_back,
        color: Color(0xFFF0997D), // Coral color for back arrow
      ),
      label: Text(
        'Chats',
        style: textTheme.bodyLarge!.copyWith(
          color: const Color(0xFFF0997D),
        ),
      ),
    );
  }
}
