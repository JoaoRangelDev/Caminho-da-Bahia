import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../routes/route_observer.dart';
import 'home_controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);


    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      HelperRoutes.routeObserver.subscribe(this, ModalRoute.of(context)!);
      await start();
    });
  }

  Future start() async {
    await context.read<HomeController>().start();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...controller.apiText.map((apiTextItem) {

                    final Color textColor = apiTextItem.tipoText == 0
                        ? const Color.fromRGBO(170, 188, 152, 1)
                        : const Color.fromRGBO(28, 144, 55, 1);

                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: textColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              apiTextItem.text,
                              textStyle: TextStyle(
                                color: textColor,
                                fontSize: 16.0,
                              ),
                              cursor: '▊',
                              speed: Duration( milliseconds: apiTextItem.tipoText == 0 ? 1 : 60),
                            ),

                          ],
                          totalRepeatCount: 1,
                          pause: const Duration(milliseconds: 500),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.5),
              color: Colors.black,
              child: TextField(
                controller: _messageController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Color.fromRGBO(170, 188, 152, 1)),
                decoration: InputDecoration(
                  hintText: 'Continue...',
                  hintStyle:
                  const TextStyle(color: Color.fromRGBO(170, 188, 152, 1)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(170, 188, 152, 1)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Color.fromRGBO(170, 188, 152, 1)),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send,
                        color: Color.fromRGBO(170, 188, 152, 1)),
                    onPressed: () async {
                      if (_messageController.text.isNotEmpty) {
                        controller.acao(_messageController.text);
                        _messageController.clear();
                      }
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}