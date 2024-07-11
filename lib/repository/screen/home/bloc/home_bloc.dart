import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales/data/remote/url_helper.dart';
import 'package:sales/domain/model/category_model.dart';
import 'package:sales/repository/screen/home/bloc/home_event.dart';
import 'package:sales/repository/screen/home/bloc/home_state.dart';

import '../../../../data/remote/api_helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  ApiHelper apiHelper;
  HomeBloc({required this.apiHelper}) : super(HomeInitialState()){
    
    on<GetCategoryEvent>((event, emit)async {
      emit(HomeLoadingState());

      try {
        dynamic data = await apiHelper.getApi(url: UrlHelper.Get_Cat_URL);
        List<CategoryModel> mCategories = [];

        for(Map<String, dynamic> eachCat in data){
          mCategories.add(CategoryModel.fromJson(eachCat));
        }

        emit(HomeLoadedState(mCat: mCategories));


      } catch (e){
        emit(HomeErrorState(errorMsg: e.toString()));
      }
      
      
    });
    
  }
  
}