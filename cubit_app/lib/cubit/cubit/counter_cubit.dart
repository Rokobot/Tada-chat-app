import 'package:bloc/bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  int i = 0;
  CounterCubit() : super(CounterInitial(counter: 0));

  void increment() {
    i += 1;
    emit(CounterInitial(counter: i));
  }

  void decrement() {
    i -= 1;
    emit(CounterInitial(counter: i));
  }
}
