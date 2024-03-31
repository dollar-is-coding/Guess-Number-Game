import 'package:flutter/material.dart';
import 'package:number_game/widgets/base_appbar_widget.dart';
import 'package:number_game/widgets/body_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: BaseAppbarWidget(),
      body: BaseBodyWidget(),
    );
  }
}
