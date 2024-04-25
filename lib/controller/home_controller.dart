import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:news_multi_language/model/response/news_response.dart';
import 'package:news_multi_language/service/network/api/api_service.dart';
import 'package:translator/translator.dart';

class HomeController extends GetxController {
  RxList<Article> newsList = <Article>[].obs;
  ApiService apiService = ApiService();
  final translator = GoogleTranslator();
  RxString description = ''.obs;
  final isSelectedKorea = false.obs;
  final isSelectedEnglish = true.obs;
  RxList listDesc = [].obs;

  Future getNews() async {
    final response = await apiService.getNews();
    response.when(success: (data) {
      newsList.value = data.articles!;
      for (int index = 0; index < newsList.length; index++) {
        description.value = newsList[index].description!;
        listDesc.add(description.value);
      }
      print(listDesc);
      // for (Article article in newsList) {
      //   description.value = article.description!;
      // }
    }, failure: ((error, stackTrace) {
      print('Error');
    }));
  }

  Future<void> translateDescriptionToKor() async {
    for (int index = 0; index < listDesc.length; index++) {
      description.value = listDesc[index];
      final translatedDescription =
          await translator.translate(description.value, from: 'en', to: 'ko');

      listDesc[index] = translatedDescription.toString();
    }
  }

  Future<void> translateDescriptionToEng() async {
    for (int index = 0; index < listDesc.length; index++) {
      description.value = listDesc[index];
      final translatedDescription =
          await translator.translate(description.value, from: 'ko', to: 'en');

      listDesc[index] = translatedDescription.toString();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getNews();
  }
}

//final input = "Здравствуйте. Ты в порядке?";
      // translator.translate(input, from: 'ru', to: 'ko').then(print);
