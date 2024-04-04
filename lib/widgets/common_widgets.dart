import 'package:flutter/material.dart';
import 'package:get/get.dart';

DataColumn headerTitle({
  @required text,
  @required color,
  @required context,
}) {
  return DataColumn(
    label: Flexible(
      child: Text(
        text,
        softWrap: true,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(color: color),
      ),
    ),
  );
}

DataCell bodyCell({
  @required text,
  @required context,
  @required fontweight,
  @required color,
}) {
  return DataCell(
    Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: fontweight,
              color: color,
            ),
      ),
    ),
  );
}

Widget dateFormated({@required result, @required context}) {
  return Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Text(
      result.date.substring(8, 10) +
          '.' +
          result.date.substring(5, 7) +
          ' ' +
          result.total.toString(),
      style: Theme.of(context).textTheme.bodySmall,
    ),
  );
}

Widget singleColumnChart(
    {@required message,
    @required heightSize,
    @required color,
    @required context,
    @required borderColor}) {
  return Tooltip(
    message: message,
    verticalOffset: heightSize - (heightSize * .44),
    triggerMode: TooltipTriggerMode.tap,
    textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Colors.black45,
        ),
    decoration: BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Container(
      height: heightSize,
      width: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        border: Border.all(
          width: .8,
          color: borderColor,
        ),
      ),
    ),
  );
}

Widget resultDialog({
  @required result,
  @required gif,
  @required context,
  @required correctNumber,
  @required nextRoundButton,
  @required color,
  @required background,
}) {
  return AlertDialog(
    contentPadding: EdgeInsets.all(0),
    content: Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 28, 20, 28),
          width: MediaQuery.of(context).size.width * .76,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            image: DecorationImage(
              image: AssetImage(background),
              fit: BoxFit.cover,
            ),
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  result,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  correctNumber,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: color),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    24,
                    0,
                    16,
                  ),
                  child: Image.asset(
                    gif,
                    height: MediaQuery.of(context).size.width * .5,
                  ),
                ),
                Center(
                  child: nextRoundButton,
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget skipDialog(
    {@required nextRoundButton,
    @required context,
    @required color,
    @required background}) {
  return AlertDialog(
    contentPadding: const EdgeInsets.all(0),
    backgroundColor: Colors.transparent,
    content: Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 28, 20, 28),
          width: MediaQuery.of(context).size.width * .76,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            image: DecorationImage(
              image: AssetImage(background),
              fit: BoxFit.cover,
            ),
          ),
          // Height fit in content on its container
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Start a new round?',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: color),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    24,
                    0,
                    16,
                  ),
                  child: Image.asset(
                    'asset/image/reset.gif',
                    height: MediaQuery.of(context).size.width * .5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 107, 80, 171),
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () => Get.back(result: true),
                      child: Text(
                        'No',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .05,
                    ),
                    nextRoundButton,
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget analyseSign(
    {@required text,
    @required color,
    @required context,
    @required colorText,
    @required borderColor}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: colorText),
        ),
      ),
      Container(
        width: 52,
        height: 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
          border: Border.all(
            width: .8,
            color: borderColor,
          ),
        ),
      )
    ],
  );
}
