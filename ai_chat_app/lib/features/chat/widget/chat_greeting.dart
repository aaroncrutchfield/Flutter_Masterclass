import 'package:ai_chat_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ChatGreeting extends StatelessWidget {
  const ChatGreeting({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.chat),
        const SizedBox(height: 8),
        Text(l10n.chatGreeting, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
