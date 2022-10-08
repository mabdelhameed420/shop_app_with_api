import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class ProductInScreen extends StatelessWidget {
  const ProductInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppSuccessfullyChangeFavoritesState){
          inFavorites = !inFavorites;
        }
        if(state is AppSuccessfulChangeCartState){
          inCart = !inCart;
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: const Text('Product'),
            ),
            body: ConditionalBuilder(
              condition: cubit.homeModel != null,
              builder: (context) => SingleChildScrollView(
                child: productInItem(
                    cubit.homeModel!.data.products[index], context),
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
      },
    );
  }
}
