import 'dart:async';

import 'package:assignment_zarity_health/generics/list_item_class.dart';
import 'package:assignment_zarity_health/services/blog_fetching.dart';
import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:assignment_zarity_health/widgets/appbar_widget.dart';
import 'package:assignment_zarity_health/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';


class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  late AppLinks _appLinks;
  int startIndex = 0;
  final ScrollController scrollerController = ScrollController();

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }


  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();
    // Handle links
    _appLinks.uriLinkStream.listen((uri) {
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    List<String> uriSplit = uri.toString().split("/");
    setState(() {
      startIndex = int.parse(uriSplit[uriSplit.length - 1]);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(scrollerController.hasClients){
        scrollerController.animateTo(
          startIndex*100,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
  
      }

      else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          scrollerController.animateTo(
            startIndex * MediaQuery.of(context).size.height*0.75,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        });
      }
    }); 
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets.appBarWidget(ConstantUtils.appTitleString),
      drawer: DrawerWidget(brightness: Theme.of(context).brightness),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ConstantRoutes.addBlogRoute);
        },

        child: const Icon(Icons.add),
      ),

      body: FutureBuilder(
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
 
              } else if (snapshot.hasData) {
                final data = snapshot.data as List<ListItemForBlog>;
                return Expanded(
                    child: ListView.builder(
                    controller: scrollerController,
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListViewItemForBlog.listItemWidget(
                          image: data[index].image,
                          title: data[index].title,
                          summary: data[index].summary,
                          index: data[index].index,
                          context: context,
                          brightness: Theme.of(context).brightness,
                        )
                    );
                    })
                  ),
                );
              }
            }
 
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
 
          future: GetBlog.getBlogData(),
        ),
    );
  }
}