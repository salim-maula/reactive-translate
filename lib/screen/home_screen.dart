import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:news_multi_language/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        if (controller.isSelectedEnglish.value ==false) {
                          controller.isSelectedEnglish.value =
                            !controller.isSelectedEnglish.value;

                        controller.isSelectedKorea.value =
                            !controller.isSelectedKorea.value;

                        if (controller.isSelectedEnglish.value) {
                          controller.translateDescriptionToEng();
                        }
                        }
                        
                      },
                      child: Row(
                        children: [
                          Text('🇬🇧 English'),
                          Icon(controller.isSelectedEnglish.value
                              ? Icons.check_circle_outline_rounded
                              : null)
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        if (controller.isSelectedKorea.value == false) {
                           controller.isSelectedEnglish.value =
                            !controller.isSelectedEnglish.value;

                        controller.isSelectedKorea.value =
                            !controller.isSelectedKorea.value;

                            if (controller.isSelectedKorea.value) {
                          controller.translateDescriptionToKor();
                        }
                        }
                       
                      },
                      child: Row(
                        children: [
                          Text('🇰🇷 Korea'),
                          Icon(controller.isSelectedKorea.value
                              ? Icons.check_circle_outline_rounded
                              : null)
                        ],
                      ),
                    ),
                  ])
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
              itemCount: controller.newsList.length,
              itemBuilder: (conte, index) {
                // var desc = controller.newsList[index].description!;
                // controller.translator.translate(desc, from: 'en', to: 'ko');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.newsList[index].author!,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Obx(() {
                      return Text(controller.listDesc[index]);
                    })
                  ],
                );
              }),
        );
      }),
    );
  }
}
