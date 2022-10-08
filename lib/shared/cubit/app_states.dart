
import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:shop_app/models/change_password_model/change_password_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/models/profile_model/profile_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates{}

class AppLoadingLoginState extends AppStates{}

class AppSuccessfullyLoginState extends AppStates{
  final LoginModel? loginModel;

  AppSuccessfullyLoginState(this.loginModel);
}

class AppErrorLoginState extends AppStates{
  final String error;

  AppErrorLoginState(this.error);
}

class AppLoadingRegistrationState extends AppStates{}

class AppSuccessfullyRegistrationState extends AppStates{
  final LoginModel? registrationModel;

  AppSuccessfullyRegistrationState(this.registrationModel);
}

class AppErrorRegistrationState extends AppStates{
  final String error;

  AppErrorRegistrationState(this.error);

}

class AppChangeNavScreens extends AppStates{}

class AppChangeButtonSheet extends AppStates{}

class AppCheckButtonState extends AppStates{}

class AppChangeModeState extends AppStates{}

class AppChangeSuffixState extends AppStates{}

class AppLoadingHomeDataState extends AppStates{}

class AppSuccessfullyHomeDataState extends AppStates{}

class AppErrorHomeDataState extends AppStates{}

class AppSuccessfullyCategoryDataState extends AppStates{}

class AppErrorCategoryDataState extends AppStates{}

class AppSuccessfullyChangeFavoritesState extends AppStates{
  final ChangeFavoritesModel model;

  AppSuccessfullyChangeFavoritesState(this.model);
}

class AppChangeFavoritesState extends AppStates{}

class AppChangeTextState extends AppStates{}

class AppErrorChangeFavoritesState extends AppStates{}

class AppSuccessfulGetFavoritesState extends AppStates{}

class AppErrorGetFavoritesState extends AppStates{}

class AppProfileLoadingState extends AppStates{}

class AppSuccessfulGetProfileState extends AppStates{}

class AppErrorGetProfileState extends AppStates{}

class AppSuccessfulUpdateProfileState extends AppStates{
  ProfileModel profileModel;

  AppSuccessfulUpdateProfileState(this.profileModel);
}

class AppErrorUpdateProfileState extends AppStates{}

class AppLoadingCartState extends AppStates{}

class AppSuccessfulChangeCartState extends AppStates{}

class AppErrorChangeCartState extends AppStates{}

class AppLoadingSearchState extends AppStates{}

class AppSuccessfulSearchState extends AppStates{}

class AppErrorSearchState extends AppStates{}

class AppCartLoadingDataState extends AppStates{}

class AppSuccessfulGetCartState extends AppStates{}

class AppErrorGetCartState extends AppStates{}

class AppLoadingChangePasswordState extends AppStates{}

class AppSuccessfulChangePasswordState extends AppStates{
  ChangePassword changePassword;

  AppSuccessfulChangePasswordState(this.changePassword);
}

class AppErrorChangePasswordState extends AppStates{}
