import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:assignment_zarity_health/widgets/cache_newtork_image.dart';
import 'package:assignment_zarity_health/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ListItemForBlog {
  final String image;
  final String title;
  final String summary;
  final int index;
  ListItemForBlog({required this.image, required this.title, required this.summary, required this.index});
}

class ListViewItemForBlog {
  static Widget listItemWidget({String image = ConstantUtils.noImage, String title = "No Title", String summary = "No Summary Available", int? index, BuildContext? context, Brightness? brightness}) {
    Color textColor = ThemeUtils.darkThemeColor;
    if(brightness == Brightness.dark) {
      textColor = ThemeUtils.foregroundThemeColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,

        children: [

          CachedNetworkImageWidget.returnPrimaryCachedNetworkImage(image, context!),

          const SizedBox(height: 10),

          RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(
                fontFamily: ConstantUtils.appFontFamily,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          

          const SizedBox(height: 10),

          RichTextWidget(text: summary, color: textColor),
          const SizedBox(height: 10),

          SharePallete.returnBlogSharePallete(context, index!),

          const SizedBox(width: 5),

          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: "${ConstantUtils.blogsUrl}$index"));
            }, 
            child: TextWidget(
              text: "Read More", 
              fontFamily: ConstantUtils.appFontFamily, 
              size: ConstantUtils.appFontSize
          )),
          
        ],
      ),
    );
  }
}

class SharePallete {
  static Widget returnBlogSharePallete(BuildContext context, int index) {
    return Row(
            children: [
              TextButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: "${ConstantUtils.blogsUrl}$index"));
                }, 
                child: TextWidget(
                  text: "Copy Link", 
                  fontFamily: ConstantUtils.appFontFamily, 
                  size: ConstantUtils.appFontSize
              )),

              const SizedBox(width: 5),

              TextButton(
                onPressed: () async {
                  var whatsappAndroid =Uri.parse("${ConstantUtils.whatsappUrl}${ConstantUtils.blogsUrl}$index");
                  if (await canLaunchUrl(whatsappAndroid)) {
                      await launchUrl(whatsappAndroid);
                  } 
                  
                  else {
                      if(context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("WhatsApp is not installed on the device"),
                        ),
                        );
                      }
                  }
                },

                child: TextWidget(
                  text: "Whatsapp Share", 
                  fontFamily: ConstantUtils.appFontFamily, 
                  size: ConstantUtils.appFontSize
                )
              ),
            ],
          );
  }
}