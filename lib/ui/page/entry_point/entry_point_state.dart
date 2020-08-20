part of 'entry_point_cubit.dart';

abstract class EntryPointState extends Equatable {
  const EntryPointState();
}

class EntryPointSplash extends EntryPointState {
  const EntryPointSplash();
  @override
  List<Object> get props => [];
}
class EntryPointAuthenticated extends EntryPointState {
  const EntryPointAuthenticated();
  @override
  List<Object> get props => [];
}
class EntryPointNotAuthenticated extends EntryPointState {
  const EntryPointNotAuthenticated();
  @override
  List<Object> get props => [];
}
