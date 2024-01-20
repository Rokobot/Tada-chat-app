import 'package:cubit_app/cubit/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        home: Scaffold(
          body: Center(child: BlocBuilder<CounterCubit, CounterState>(
            builder: (context, state) {
              if (state is CounterInitial) {
                return newMethod(state.counter, context);
              }
              return newMethod(0, context);
            },
          )),
        ),
      ),
    );
  }

  Column newMethod(int counter, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${counter.toString()}'),
        SizedBox(
          height: 60,
        ),
        MaterialButton(
          color: Colors.green,
          onPressed: () {
            context.read<CounterCubit>().increment();
          },
          child: Text('+'),
        ),
        SizedBox(
          height: 20,
        ),
        MaterialButton(
          color: Colors.red,
          onPressed: () {
            context.read<CounterCubit>().decrement();
          },
          child: Text('-'),
        )
      ],
    );
  }
}
