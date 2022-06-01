import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../modules/webview_module/webview_module.dart';

class CustomNewItem extends StatelessWidget {
  const CustomNewItem({
    Key? key,
    required this.title,
    required this.publishedAt,
    required this.description,
    required this.urlToImg,
  }) : super(key: key);
  final String title, publishedAt, description, urlToImg;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150.0,
            width: 150.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image(
                image: NetworkImage(
                  urlToImg,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  publishedAt,
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.controller,
    required this.type,
    required this.validateFunc,
    required this.label,
    required this.prefix,
    this.isSecure = false,
    this.onSuffixPressed,
    this.suffix,
    this.onChange,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?)? validateFunc;
  final Function? onSuffixPressed;
  final ValueChanged<String>? onChange;
  final String label;
  final IconData prefix;
  final IconData? suffix;
  final bool isSecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validateFunc,
      obscureText: isSecure,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: () {
                  onSuffixPressed!();
                },
              )
            : null,
      ),
    );
  }
}

class ArticleBuilder extends StatelessWidget {
  const ArticleBuilder({
    Key? key,
    required this.list,
    this.fromSearch = false,
  }) : super(key: key);

  final List list;
  final bool fromSearch;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (list[index]['description'] != null &&
              list[index]['urlToImage'] != null) {
            return InkWell(
              onTap: () {
                navigate(
                  context,
                  WebviewModule(list[index]['url']),
                );
              },
              child: CustomNewItem(
                title: list[index]['title'],
                publishedAt: list[index]['publishedAt'],
                description: list[index]['description'],
                urlToImg: list[index]['urlToImage'],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
        separatorBuilder: (context, index) {
          if (list[index]['description'] != null &&
              list[index]['urlToImage'] != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 1.0,
                color: Colors.grey,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
        itemCount: list.length,
      ),
      fallback: (context) => fromSearch
          ? const SizedBox.shrink()
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

void navigate(BuildContext context, Widget route) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) => route),
    ),
  );
}
