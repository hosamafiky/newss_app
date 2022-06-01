import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchModule extends StatefulWidget {
  const SearchModule({Key? key}) : super(key: key);

  @override
  State<SearchModule> createState() => _SearchModuleState();
}

class _SearchModuleState extends State<SearchModule> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomFormField(
                controller: searchController,
                type: TextInputType.text,
                onChange: (value) {
                  cubit.getSearchData(value);
                },
                validateFunc: (value) {
                  return null;
                },
                label: 'Search',
                prefix: Icons.search,
              ),
            ),
            Expanded(
              child: ArticleBuilder(
                fromSearch: true,
                list: cubit.searchNews,
              ),
            ),
          ]),
        );
      },
    );
  }
}
