import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class CarCategoryCubit extends Cubit<String> {
  CarCategoryCubit() : super('');
  late String category;
  selectCategory(String selectedCategory) {
    category=selectedCategory;
    emit(selectedCategory);
  }

  resetChips() {
    category='';
    emit('');
  }
}
