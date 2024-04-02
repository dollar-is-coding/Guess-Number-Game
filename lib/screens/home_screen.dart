import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:number_game/controllers/number_controller.dart';
import 'package:number_game/controllers/result_controller.dart';
import 'package:number_game/widgets/common_widgets.dart';

class HomeScreen extends StatelessWidget {
  final numberController = NumberController.to;
  final resultController = ResultController.to;
  @override
  Widget build(BuildContext context) {
    var briefNumbers = numberController.numbers;
    var briefResults = resultController.results;

    Widget newRoundButton() {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            const Color.fromARGB(255, 37, 36, 157),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onPressed: () {
          numberController.resetNumbers();
          Get.back(result: true);
        },
        child: Text(
          'New round',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      );
    }

    Widget nextRoundAcceptedButton() {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            const Color.fromARGB(255, 245, 123, 86),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onPressed: () {
          numberController.resetNumbers();
          resultController.updateScore(0);
          Get.back(result: true);
        },
        child: Text(
          'Yes',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      );
    }

    Widget analyseChart = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/image/bg.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                'Analyse chart',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: .8,
                      color: Colors.white.withOpacity(.4),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                      child: IconButton(
                        onPressed: () {
                          Get.back(result: true);
                        },
                        icon: Icon(
                          Icons.close_outlined,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Obx(
            () {
              return resultController.maxScore != 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          analyseSign(
                            text: 'Win',
                            color: Color.fromARGB(255, 229, 244, 177),
                            context: context,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: analyseSign(
                              text: 'Lose',
                              color: Color.fromARGB(255, 232, 195, 127),
                              context: context,
                            ),
                          ),
                          analyseSign(
                            text: 'Skip',
                            color: Colors.white38,
                            context: context,
                          ),
                        ],
                      ),
                    )
                  : Container();
            },
          ),
          Obx(
            () {
              return resultController.maxScore == 0
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'There\'s no data!',
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.black38,
                                  ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: resultController.scrollController,
                        children: List.generate(
                          resultController.resultLength.value,
                          (index) {
                            print('screen listview: ${briefResults.length}');
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: FractionallySizedBox(
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      margin: EdgeInsets.only(bottom: 6),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1,
                                            color: Colors.white30,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          singleColumnChart(
                                            message: briefResults[index]
                                                .win
                                                .toString(),
                                            heightSize: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .3) *
                                                briefResults[index].win /
                                                resultController.maxScore.value,
                                            color: Color.fromARGB(
                                                255, 229, 244, 177),
                                            context: context,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4,
                                              right: 4,
                                            ),
                                            child: singleColumnChart(
                                              message: briefResults[index]
                                                  .lose
                                                  .toString(),
                                              heightSize:
                                                  (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .3) *
                                                      briefResults[index].lose /
                                                      resultController
                                                          .maxScore.value,
                                              color: Color.fromARGB(
                                                  255, 232, 195, 127),
                                              context: context,
                                            ),
                                          ),
                                          singleColumnChart(
                                            message: briefResults[index]
                                                .pass
                                                .toString(),
                                            heightSize: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .3) *
                                                briefResults[index].pass /
                                                resultController.maxScore.value,
                                            color: Colors.white38,
                                            context: context,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    briefResults[index].date.substring(8, 10) +
                                        '.' +
                                        briefResults[index]
                                            .date
                                            .substring(5, 7),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          color: Colors.white.withOpacity(.9),
                                        ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
            },
          )
        ],
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                'Guess Number',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: const Color.fromARGB(255, 4, 16, 58),
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Row(
              children: [
                Tooltip(
                  message: 'Skip round',
                  triggerMode: TooltipTriggerMode.longPress,
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.black45),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: IconButton(
                    onPressed: () {
                      if (briefNumbers[0].isShow == 1) {
                        showGeneralDialog(
                          barrierDismissible: false,
                          barrierLabel: 'Don\'t tap outside',
                          barrierColor: Colors.black.withOpacity(.24),
                          context: context,
                          transitionDuration: const Duration(milliseconds: 180),
                          pageBuilder: (context, animation1, animation2) {
                            return Container();
                          },
                          transitionBuilder:
                              (context, animation1, animation2, child) {
                            return ScaleTransition(
                              scale: Tween<double>(
                                begin: 0,
                                end: 1,
                              ).animate(animation1),
                              child: skipDialog(
                                nextRoundButton: nextRoundAcceptedButton(),
                                context: context,
                              ),
                            );
                          },
                        );
                      }
                    },
                    icon: Icon(
                      Icons.refresh_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Analyse chart',
                  triggerMode: TooltipTriggerMode.longPress,
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.black45),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: IconButton(
                    onPressed: () {
                      resultController.scrollToLast();
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          Get.put(ResultController());
                          return analyseChart;
                        },
                      );
                    },
                    icon: Icon(Icons.equalizer_outlined),
                  ),
                ),
                Tooltip(
                  message: 'Theme',
                  triggerMode: TooltipTriggerMode.longPress,
                  textStyle: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.black45),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.light_mode_rounded),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/image/bg3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white54,
                ),
                child: DataTable(
                  columns: [
                    headerTitle(text: 'Your Guess', context: context),
                    headerTitle(text: 'Right Number', context: context),
                    headerTitle(text: 'Right Position', context: context),
                  ],
                  rows: List.generate(
                    numberController.numberLength.value,
                    (index) {
                      return DataRow(
                        color: WidgetStateProperty.resolveWith(
                          (states) {
                            if (index == numberController.currentPosition - 1) {
                              return Colors.white30;
                            }
                            return null;
                          },
                        ),
                        cells: [
                          bodyCell(
                            text:
                                '${briefNumbers[index].numberA}${briefNumbers[index].numberB}${briefNumbers[index].numberC}${briefNumbers[index].numberD}',
                            context: context,
                            fontweight: FontWeight.bold,
                            color: briefNumbers[index].isShow == 1
                                ? Color.fromARGB(255, 12, 4, 83)
                                : Colors.transparent,
                          ),
                          bodyCell(
                            text: '${briefNumbers[index].rightNumber}',
                            context: context,
                            fontweight: FontWeight.normal,
                            color: briefNumbers[index].isShow == 1
                                ? Color.fromARGB(255, 12, 4, 83)
                                : Colors.transparent,
                          ),
                          bodyCell(
                            text: '${briefNumbers[index].rightPosition}',
                            context: context,
                            fontweight: FontWeight.normal,
                            color: briefNumbers[index].isShow == 1
                                ? Color.fromARGB(255, 12, 4, 83)
                                : Colors.transparent,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: numberController.inputNumber,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Color.fromARGB(255, 12, 4, 83),
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: 'Type your guess here...',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black38),
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white70,
                      ),
                    ),
                    suffixIcon: Obx(
                      () => numberController.isValid.value
                          ? Icon(
                              Icons.check_circle_rounded,
                              color: Color.fromARGB(255, 116, 144, 69)
                                  .withOpacity(.8),
                            )
                          : Icon(
                              Icons.cancel_rounded,
                              color: Color.fromARGB(255, 209, 42, 30)
                                  .withOpacity(.8),
                            ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length == 4)
                      numberController.acceptNewNumber(true);
                    else
                      numberController.acceptNewNumber(false);
                  },
                  onSubmitted: (value) {
                    if (value.length == 4) {
                      numberController.acceptNewNumber(false);
                      numberController.updateNumber(value);
                      if (numberController.rightNumber == 4 &&
                          numberController.rightPosition == 4) {
                        resultController.updateScore(1);
                        numberController.tempNumber =
                            briefNumbers[0].correctNumber;
                        showGeneralDialog(
                          barrierDismissible: false,
                          barrierLabel: 'Don\'t tap outside',
                          barrierColor: Colors.black.withOpacity(.24),
                          context: context,
                          transitionDuration: const Duration(milliseconds: 180),
                          pageBuilder: (context, animation1, animation2) {
                            return Container();
                          },
                          transitionBuilder:
                              (context, animation1, animation2, child) {
                            return ScaleTransition(
                              scale: Tween<double>(begin: 0, end: 1)
                                  .animate(animation1),
                              child: resultDialog(
                                result: 'YOU WIN',
                                gif: 'asset/image/win.gif',
                                context: context,
                                correctNumber: numberController.tempNumber,
                                nextRoundButton: newRoundButton(),
                              ),
                            );
                          },
                        );
                      } else if (briefNumbers[9].isShow == 1) {
                        resultController.updateScore(2);
                        numberController.tempNumber =
                            briefNumbers[0].correctNumber;
                        showGeneralDialog(
                          barrierDismissible: false,
                          barrierLabel: 'Don\'t tap outside',
                          barrierColor: Colors.black.withOpacity(.24),
                          context: context,
                          transitionDuration: const Duration(milliseconds: 180),
                          pageBuilder: (context, animation1, animation2) {
                            return Container();
                          },
                          transitionBuilder:
                              (context, animation1, animation2, child) {
                            return ScaleTransition(
                              scale: Tween<double>(begin: 0, end: 1)
                                  .animate(animation1),
                              child: resultDialog(
                                result: 'YOU LOSE',
                                gif: 'asset/image/lose.gif',
                                context: context,
                                correctNumber: numberController.tempNumber,
                                nextRoundButton: newRoundButton(),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
