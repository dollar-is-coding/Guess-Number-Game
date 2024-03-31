import 'package:flutter/material.dart';

DataColumn headerTitle({
  @required text,
  @required context,
}) {
  return DataColumn(
    label: Flexible(
      child: Text(
        text,
        softWrap: true,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.black38,
            ),
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

Widget singleColumnChart({
  @required message,
  @required heightSize,
  @required color,
}) {
  return Tooltip(
    message: message,
    triggerMode: TooltipTriggerMode.tap,
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
          color: Colors.white60,
        ),
      ),
    ),
  );
}
