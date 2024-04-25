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

  Future getNews() async {
    final response = await apiService.getNews();
    response.when(success: (data) {
      newsList.value = data.articles!;
      for(Article article in newsList){
         description.value = article.description!;
      }
    }, failure: ((error, stackTrace) {
      print('Error');
    }));
  }

  Future<void> translateDescriptionToKor() async {
    for (Article article in newsList) {
      if (article.description != null) {
        final translatedDescription = await translator
            .translate(article.description!, from: 'en', to: 'ko');
        article.description = translatedDescription.text;
        description.value = article.description!;
        // print(article.description);
      }
    }
  }

  Future<void> translateDescriptionToEng() async {
    for (Article article in newsList) {
      if (article.description != null) {
        final translatedDescription = await translator
            .translate(article.description!, from: 'ko', to: 'en');
        article.description = translatedDescription.text;
        description.value = article.description!;
        // print(article.description);
      }
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
