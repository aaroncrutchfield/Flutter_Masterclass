// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ai_chat_app_widgetbook/features/auth.dart' as _i2;
import 'package:ai_chat_app_widgetbook/features/chat.dart' as _i3;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookCategory(
    name: 'Pages',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'AuthPage',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i2.buildAuthPage,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'ChatPage',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default',
          builder: _i3.buildChatPage,
        ),
      ),
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Widgets',
    children: [
      _i1.WidgetbookFolder(
        name: 'Chat',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'ChatAppBar',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i3.buildChatAppBar,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'ChatGreeting',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i3.buildChatGreeting,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'ChatInput',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i3.buildChatInput,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'FileInputSection',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default',
              builder: _i3.buildFileInput,
            ),
          ),
        ],
      )
    ],
  ),
];
