import 'package:assignment_zarity_health/generics/list_item_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetBlog {
  static Future<dynamic> getBlogData() async {
    List<ListItemForBlog> blogList = [];
      final firebase = await FirebaseFirestore.instance.collection("/blogs").orderBy("index").get();
      for(int i = 0; i < firebase.docs.length; i++) {
        dynamic element = firebase.docs[i];
        if(element["image"] == null) {
          element["image"] = "No image";
        }
        if(element["title"] == null) {
          element["title"] = "No title";
        }
        if(element["summary"] == null) {
          element["summary"] = "No summary";
        }

        if(element != null) {
          blogList.add(ListItemForBlog(image: element["image"], title: element["title"], summary: element["summary"], index: element["index"]));
        }
      }
      return blogList;
  }
}