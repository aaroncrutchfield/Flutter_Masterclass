import 'package:ai_chat_app/app/di/injection_registry.dart';
import 'package:ai_chat_app/features/counter/cubit/counter_cubit.dart';
import 'package:ai_chat_app/l10n/l10n.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => appRegistry.get<CounterCubit>(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<CounterCubit>();

    return BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
          body: Center(child: CounterText(count: state)),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: cubit.increment,
                heroTag: 'increment',
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                onPressed: cubit.decrement,
                heroTag: 'decrement',
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
