// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_module/business_module.dart';
import 'package:news_app/modules/science_module/science_module.dart';
import 'package:news_app/modules/sports_module/sports_module.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsAppInitState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDark = false;
  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    const BusinessModule(),
    const SportsModule(),
    const ScienceModule(),
  ];
  List businessNews = [];
  List sportsNews = [];
  List scienceNews = [];
  List searchNews = [];

  void changeBotNavBarIndex(int index) {
    currentIndex = index;
    if (currentIndex == 1) {
      getSportsData();
    } else if (currentIndex == 2) {
      getScienceData();
    }
    emit(NewsAppChangeNavBarState());
  }

  void changeAppTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsAppChangeThemeState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsAppChangeThemeState());
      });
    }
  }

  void getBusinessData() {
    emit(NewsAppGetBusinessDataLoadingState());
    businessNews = [];
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '01ad04010d5448ebbd953f1b2755b076',
      },
    ).then((value) {
      businessNews = value.data['articles'];
      emit(NewsAppGetBusinessDataSuccessState());
    }).catchError((error) {
      print('Error in getting business data : ${error.toString()}');
      emit(NewsAppGetBusinessDataErrorState(error));
    });
  }

  void getSportsData() {
    emit(NewsAppGetSportsDataLoadingState());
    sportsNews = [];
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '01ad04010d5448ebbd953f1b2755b076',
      },
    ).then((value) {
      sportsNews = value.data['articles'];
      emit(NewsAppGetSportsDataSuccessState());
    }).catchError((error) {
      print('Error in getting sports data : ${error.toString()}');
      emit(NewsAppGetSportsDataErrorState(error));
    });
  }

  void getScienceData() {
    emit(NewsAppGetScienceDataLoadingState());
    scienceNews = [];
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '01ad04010d5448ebbd953f1b2755b076',
      },
    ).then((value) {
      scienceNews = value.data['articles'];
      emit(NewsAppGetScienceDataSuccessState());
    }).catchError((error) {
      print('Error in getting science data : ${error.toString()}');
      emit(NewsAppGetScienceDataErrorState(error));
    });
  }

  void getSearchData(String key) {
    emit(NewsAppGetSearchDataLoadingState());
    searchNews = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': key,
        'apiKey': '01ad04010d5448ebbd953f1b2755b076',
      },
    ).then((value) {
      searchNews = value.data['articles'];
      emit(NewsAppGetSearchDataSuccessState());
    }).catchError((error) {
      print('Error in getting search data : ${error.toString()}');
      emit(NewsAppGetSearchDataErrorState(error));
    });
  }
}
