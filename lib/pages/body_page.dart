import 'dart:async';

import 'package:assignment_zarity_health/generics/list_item_class.dart';
import 'package:assignment_zarity_health/services/blog_fetching.dart';
import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:assignment_zarity_health/widgets/appbar_widget.dart';
import 'package:assignment_zarity_health/widgets/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<ListItemForBlog>> getBlogData() async {
    dynamic fetchList = await GetBlog.getBlogData();
    return fetchList;
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

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('/blogs').orderBy("index").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            controller: scrollerController,
            itemCount: data.size,
            itemBuilder: (context, index) {
              var blog = data.docs[index];
              return ListViewItemForBlog.listItemWidget(
                image: blog["image"],
                title: blog["title"],
                summary: blog["summary"],
                index: blog["index"],
                context: context,
                brightness: Theme.of(context).brightness,
              );
            },
          );
        },
      ),
    );
  }
}