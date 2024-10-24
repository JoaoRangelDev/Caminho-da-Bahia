import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:projeto_integracao_api/database/classes/api_text.dart';
import '../../../database/services/config/api.dart';

var api = Api.key;
final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: api);


class HomeController extends ChangeNotifier {
  HomeController();
  List<ApiText> apiText = [];
  GenerativeModel? model;
  ChatSession? chat;

  start() async {
    try {
      notifyListeners();

      model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: api);
      chat = model!.startChat(history: [
        Content.text(
            'Você quem ira comandar um jogo chamado "O Caminho da Bahia", que é uma cópia brasileira do jogo original chamado "Oregon Trail", você começara com a história'
                'Você quem irá fazer o jogo rodar, dando sempre opções pro player o que ele deve fazer, Use cenarios brasileiros para falar dos cenarios'
                'O jogo pode ter game over dependendo de situações, o personagem tera progressão'
                'Ele ira se situar no Amazonas, se o jogo for acontecer antes de 1850, antes da provincia autonoma Amazonas existir, será chamado de Grão-Pará , em uma cidade, o objetivo do jogador é chegar a Bahia, percorrendo de oeste a leste do Brasil para chegar'
                'Ira se situar no século XIX (19), pode escolher o ano exato que quiser'
                'O dinheiro do jogo será chamado de Réis'
                'A vida cotidiana no Brasil no século XIX era marcada por hábitos como a lavagem de algumas partes do corpo, a alimentação influenciada pela cultura indígena, a montaria em cavalos e burros, e a comunicação por meio de jornais e revistas. '
                'A alimentação, influenciada pela cultura indígena, incluía produtos como mandioca, batata, milho, peixe, carne e frutas. Outros foram trazidos pelos portugueses, como a jaca e a manga. No século 19, o café da manhã era feito com leite, pão, frutas e bolos. No almoço, o mais comum era o consumo de arroz e feijão, acompanhados de batata, carne e salada. Para o jantar, as sopas eram o prato principal.'
                'Você ira dar um nome BRASILEIRO para o personagem, A cidade ou vila inicial, utilize fatos históricos e cidades da época para fazer o caminho até Salvador'
                'As opções dada pelo jogador, serão enumeradas, o jogador ira responder apenas com os numeros das opções dadas'
        )
      ]);

      var content = Content.text(
          'Comece o jogo'
      );

      var response = await chat!.sendMessage(content);

      if (response.text != null) {
        ApiText text = ApiText(tipoText: 1, text: response.text!.replaceAll('*', ''));
        apiText.add(text);
      } else {
        ApiText text = ApiText(tipoText: 1, text: 'Erro.');
        apiText.add(text);
      }
    } catch (e) {
      ApiText text = ApiText(tipoText: 1, text: 'Erro.');
      apiText.add(text);
    } finally {
      notifyListeners();
    }
  }

  acao(String message) async {
    ApiText text = ApiText(tipoText: 0, text: " >> $message");
    apiText.add(text);

    notifyListeners();

    var content = Content.text(message);
    final response = await chat!.sendMessage(content);
    ApiText textApi = ApiText(tipoText: 1, text: response.text!.replaceAll('*', ''));

    apiText.add(textApi);
    notifyListeners();
  }
}
