import 'package:ai_chat_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(child: TextInputField()),
              VoiceInputButton(),
            ],
          ),
          FileInputSection(),
        ],
      ),
    );
  }
}

class VoiceInputButton extends StatelessWidget {
  const VoiceInputButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton(
        icon: const Icon(
          Icons.mic_none,
          color: Colors.orange,
        ),
        onPressed: () {},
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 12),
      child: TextField(
        minLines: 1,
        maxLines: 9,
        decoration: InputDecoration(
          hintText: l10.chatInputHint,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class FileInputSection extends StatelessWidget {
  const FileInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 16),
      child: Row(
        children: [
          FileInputButton(
            iconData: Icons.add_a_photo_outlined,
            onPressed: () {},
          ),
          FileInputButton(
            iconData: Icons.photo_library_outlined,
            onPressed: () {},
          ),
          FileInputButton(
            iconData: Icons.upload_file_outlined,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class FileInputButton extends StatelessWidget {
  const FileInputButton({
    required this.iconData,
    required this.onPressed,
    super.key,
  });

  final IconData iconData;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData, color: Colors.white),
      onPressed: onPressed,
    );
  }
}
