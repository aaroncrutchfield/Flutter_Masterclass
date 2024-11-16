import 'package:ai_chat_app/app/theme.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

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
    final textTheme = context.theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {},
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
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        TextButton.icon(
          onPressed: () {},
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
    final textTheme = context.theme.textTheme;

    return TextButton.icon(
      onPressed: () {},
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
