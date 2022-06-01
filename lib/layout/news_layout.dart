import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search_module/search_module.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  navigate(context, const SearchModule());
                },
              ),
              IconButton(
                icon: cubit.isDark
                    ? const Icon(Icons.brightness_4_rounded)
                    : const Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  cubit.changeAppTheme();
                },
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavBarItems,
            onTap: (index) {
              cubit.changeBotNavBarIndex(index);
            },
          ),
        );
      },
    );
  }
}
