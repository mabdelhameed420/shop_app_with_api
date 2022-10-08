import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/style/color.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var searchController = TextEditingController();
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                    child: defaultTextField(
                      context: context,
                      text: 'Search',
                      controller: searchController,
                      radius: 10,
                      validator: (value) =>
                          value!.isEmpty ? 'please enter a value' : null,
                      prefixIcon: Icons.search,
                      onChange: (value){
                        searchController.text = value.toString();
                      }
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: defaultTextButton(onPressed: (){
                      cubit.search(searchController.text);
                    }, text: 'Search',color: Colors.white),
                  )
                ]),
                const SizedBox(height: 20,),
                if (state is AppLoadingSearchState)
                  LinearProgressIndicator(
                    color: defaultColor,
                  ),
                if (cubit.searchModel != null &&
                    state is AppSuccessfulSearchState)
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: listProduct(
                            cubit.searchModel!.data!.data![index], context,
                            isSearch: true),
                      ),
                      separatorBuilder: (context, index) => divider(),
                      itemCount: cubit.searchModel!.data!.data!.length,
                    ),
                  ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        );
      },
    );
  }
}
