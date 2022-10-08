import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 20),
              child: categoryBuild(cubit.categoryModel.data.data[index]),
            ),
            separatorBuilder: (context, index) => divider(),
            itemCount: cubit.categoryModel.data.data.length,
          ),
        );
      },
    );
  }
}
