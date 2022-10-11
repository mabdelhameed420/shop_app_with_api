import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cart_model/cart_model.dart';
import 'package:shop_app/models/change_cart_model/change_cart_model.dart';
import 'package:shop_app/models/change_favorites_model/change_favorites_model.dart';
import 'package:shop_app/models/change_password_model/change_password_model.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/models/get_categories_model/get_categories_model.dart';
import 'package:shop_app/models/home_data_model/home_data_model.dart';
import 'package:shop_app/models/login_model/login_model.dart';
import 'package:shop_app/models/profile_model/profile_model.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/cart_screen/cart_screen.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/products_screen/products_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio.dart';
import '../network/local/cach_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  bool isDark = false;
  bool isPassword = true;
  bool isShowed = false;
  int currentIndex = 0;
  IconData checkIcon = Icons.check_box_outline_blank;
  IconData fabIcon = Icons.mode_edit_outline_outlined;
  IconData suffixIcon = Icons.visibility_outlined;

  List<Widget> screens = const [
    ProductsScreen(),
    CartScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Dexter',
    'Cart',
    'Categories',
    'Settings',
  ];

  List<BottomNavigationBarItem> itemNavButton = const [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_basket_outlined), label: 'Cart'),
    BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined), label: 'Categories'),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      label: 'Settings',
    ),
  ];

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CachedHelper.putBoolean(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  void changeScreens(int index) {
    currentIndex = index;
    emit(AppChangeNavScreens());
  }

  void changeButtonSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isShowed = isShow;
    fabIcon = icon;
    emit(AppChangeButtonSheet());
  }

  void changeCheckState() {
    emit(AppCheckButtonState());
  }

  void pressSuffixButton() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppChangeSuffixState());
  }

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoadingLoginState());
    AppDio.postData(
      url: login,
      data: {'email': email, 'password': password},
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      if (loginModel!.data != null) token = loginModel!.data!.token;
      emit(AppSuccessfullyLoginState(loginModel!));
      getProfileData();
      getFavoritesData();
      getCartData();
    }).catchError((error) {
      emit(AppErrorLoginState(error.toString()));
    });
  }

  LoginModel? registrationModel;

  void userRegistration({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(AppLoadingLoginState());
    AppDio.postData(
      url: registration,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password
      },
    ).then((value) {
      registrationModel = LoginModel.fromJson(value.data);
      if (registrationModel!.data != null)
        token = registrationModel!.data!.token;
      emit(AppSuccessfullyRegistrationState(registrationModel!));
      getProfileData();
      getFavoritesData();
      getCartData();
    }).catchError((error) {
      emit(AppErrorRegistrationState(error.toString()));
    });
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(AppLoadingHomeDataState());
    AppDio.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJason(value.data);
      if (homeModel != null) {
        for (var element in homeModel!.data.products) {
          favorites.addAll({element.id: element.inFavorites!});
        }
      }
      emit(AppSuccessfullyHomeDataState());
    }).catchError((error) {
      emit(AppErrorHomeDataState());
    });
  }

  late CategoryModel categoryModel;

  void getCategoryData() {
    AppDio.getData(
      url: category,
    ).then((value) {
      categoryModel = CategoryModel.fromJason(value.data);
      emit(AppSuccessfullyCategoryDataState());
    }).catchError((error) {
      emit(AppErrorCategoryDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int id) {
    favorites[id] = !favorites[id]!;
    emit(AppChangeFavoritesState());
    AppDio.postData(url: favoritesEnd, data: {'product_id': id}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      emit(AppChangeTextState());
      if (!changeFavoritesModel!.status) {
        favorites[id] = !favorites[id]!;
        emit(AppChangeFavoritesState());
      } else {
        getFavoritesData();
      }
      emit(AppSuccessfullyChangeFavoritesState(changeFavoritesModel!));
      getHomeData();
    }).catchError((error) {
      emit(AppErrorChangeFavoritesState());
    });
  }

  GetFavoritesModel? getFavoritesModel;

  void getFavoritesData() {
    AppDio.getData(
      url: favoritesEnd,
      token: token,
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      emit(AppSuccessfulGetFavoritesState());
    }).catchError((error) {
      emit(AppErrorGetFavoritesState());
    });
  }

  void clearLoginData(context) {
    CachedHelper.clearData(key: 'token').then((value) {
      navigateWithoutBack(context, const LoginScreen());
    });
  }

  ProfileModel? profileModel;

  void getProfileData() {
    emit(AppProfileLoadingState());
    AppDio.getData(
      url: getProfile,
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      if (profileModel!.data != null) token = profileModel!.data.token;
      emit(AppSuccessfulGetProfileState());
    }).catchError((error) {
      emit(AppErrorGetProfileState());
    });
  }

  ProfileModel? updateProfileModel;

  void updateProfileData(
      String name, String phone, String email) {
    emit(AppProfileLoadingState());
    AppDio.putData(url: updateProfile, token: token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      updateProfileModel = ProfileModel.fromJson(value.data);
      emit(AppSuccessfulUpdateProfileState(updateProfileModel!));
      getProfileData();
    }).catchError((error) {
      emit(AppErrorUpdateProfileState());
    });
  }

  ChangeCartModel? changeCartModel;

  void changeToCart(int id, context) {
    emit(AppLoadingCartState());
    AppDio.postData(url: cart, data: {'product_id': id}, token: token)
        .then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);
      getHomeData();
      emit(AppChangeTextState());
      getCartData();
      emit(AppSuccessfulChangeCartState());
    }).catchError((error) {
      emit(AppErrorChangeCartState());
    });
  }

  GetCartModel? getCartModel;

  void getCartData() {
    emit(AppCartLoadingDataState());
    AppDio.getData(
      url: cart,
      token: token,
    ).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      emit(AppSuccessfulGetCartState());
    }).catchError((error) {
      emit(AppErrorGetCartState());
    });
  }

  ChangePassword? changePassword;

  void newPassword({
    required String oldPassword,
    required String newPassword,
    required context,
  }) {
    emit(AppLoadingChangePasswordState());
    AppDio.postData(url: password, token: token, data: {
      'current_password': oldPassword,
      'new_password': newPassword,
    }).then((value) {
      changePassword = ChangePassword.fromJson(value.data);
      getProfileData();
      emit(AppSuccessfulChangePasswordState(changePassword!));
    }).catchError((error) {
      emit(AppErrorChangePasswordState());
    });
  }

  SearchModel? searchModel;

  void search(String text) {
    emit(AppLoadingSearchState());
    AppDio.postData(url: searchEnd, data: {'text': text}, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(AppSuccessfulSearchState());
    }).catchError((error) {
      emit(AppErrorSearchState());
    });
  }
}
