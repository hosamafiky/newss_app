abstract class NewsStates {}

class NewsAppInitState extends NewsStates {}

class NewsAppChangeNavBarState extends NewsStates {}

class NewsAppChangeThemeState extends NewsStates {}

class NewsAppGetBusinessDataLoadingState extends NewsStates {}

class NewsAppGetBusinessDataSuccessState extends NewsStates {}

class NewsAppGetBusinessDataErrorState extends NewsStates {
  final String error;

  NewsAppGetBusinessDataErrorState(this.error);
}

class NewsAppGetSportsDataLoadingState extends NewsStates {}

class NewsAppGetSportsDataSuccessState extends NewsStates {}

class NewsAppGetSportsDataErrorState extends NewsStates {
  final String error;

  NewsAppGetSportsDataErrorState(this.error);
}

class NewsAppGetScienceDataLoadingState extends NewsStates {}

class NewsAppGetScienceDataSuccessState extends NewsStates {}

class NewsAppGetScienceDataErrorState extends NewsStates {
  final String error;

  NewsAppGetScienceDataErrorState(this.error);
}

class NewsAppGetSearchDataLoadingState extends NewsStates {}

class NewsAppGetSearchDataSuccessState extends NewsStates {}

class NewsAppGetSearchDataErrorState extends NewsStates {
  final String error;

  NewsAppGetSearchDataErrorState(this.error);
}
