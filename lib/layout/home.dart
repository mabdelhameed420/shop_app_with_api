import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/favorites_screen/favorites_screen.dart';
import 'package:shop_app/modules/profile_screen/profile_screen.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/style/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: cubit.currentIndex != 3
                ? [
                    IconButton(
                        onPressed: () {
                          navigateTo(context, const SearchScreen());
                        },
                        icon: const Icon(Icons.search_rounded)),
                  ]
                : [],
          ),
          body: cubit.screens[cubit.currentIndex],
          drawer: Drawer(
            backgroundColor: Colors.white.withOpacity(.01),
            child: Column(
              children: [
                if (cubit.profileModel != null)
                  Container(
                    color: HexColor('#EB4C64'),
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          color: HexColor('#EB4C64'),
                          borderRadius: const BorderRadiusDirectional.only(
                              topEnd: Radius.circular(50))),
                      currentAccountPicture: Image(
                        image: NetworkImage(cubit.profileModel!.data.image),
                      ),
                      accountName: Text(
                        cubit.profileModel!.data.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      accountEmail: Text(
                        cubit.profileModel!.data.email,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: HexColor('#F01738'),
                    borderRadius: const BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(50)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Home',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          navigateTo(context, const HomeScreen());
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'WishList',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          navigateTo(context, const FavoritesScreen());
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          navigateTo(context, const ProfileScreen());
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      defaultTextButton(
                          onPressed: () {},
                          text: 'About Us',
                          color: Colors.white60),
                      defaultTextButton(
                          onPressed: () {
                            cubit.clearLoginData(context);
                          },
                          text: 'Log Uot',
                          color: Colors.white60),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: defaultColor, width: 2)),
            ),
            child: BottomNavigationBar(
              items: cubit.itemNavButton,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeScreens(index);
              },
            ),
          ),
        );
      },
    );
  }
}
