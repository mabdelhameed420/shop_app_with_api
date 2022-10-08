import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Wish List'),
          ),
          body: ConditionalBuilder(
            condition: cubit.getFavoritesModel!.data!.data!.isNotEmpty &&
                cubit.getFavoritesModel != null,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: listProduct(
                          cubit.getFavoritesModel!.data!.data![index].product, context),
                    ),
                separatorBuilder: (context, index) => divider(),
                itemCount: cubit.getFavoritesModel!.data!.data!.length),
            fallback: (context) => noItemFallBack(
                icon: Icons.heart_broken_outlined, text: 'No Favorites,yet'),
          ),
        );
      },
    );
  }
}
