import '../../../../domain/model/category_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState{}
class HomeLoadingState extends HomeState{}
class HomeLoadedState extends HomeState{
  List<CategoryModel> mCat;
  HomeLoadedState({required this.mCat});
}
class HomeErrorState extends HomeState{
  String errorMsg;
  HomeErrorState({required this.errorMsg});
}