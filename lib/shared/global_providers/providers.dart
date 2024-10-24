import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../pages/home/home_controller/home_controller.dart';

final providers = <SingleChildWidget>[

  ChangeNotifierProvider<HomeController>(
    create: (context) => HomeController(),
  ),
];
