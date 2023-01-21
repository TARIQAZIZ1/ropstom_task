import 'package:bloc/bloc.dart';

class ShowPasswordCubit extends Cubit<bool?> {
  ShowPasswordCubit({required bool? show}) : super(show);

  showPassword({required bool? show}) => emit(show);
}
