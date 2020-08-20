part of 'main_cubit.dart';


abstract class MainState extends Equatable{
  final int index;
  const MainState(this.index);
   @override
  List<Object> get props => [index];
}

class MainInitial extends MainState {
  final int index;
  const MainInitial(this.index):super(index);

  @override
  List<Object> get props => [index];
}
