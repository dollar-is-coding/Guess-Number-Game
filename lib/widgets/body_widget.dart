import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_game/widgets/common_widgets.dart';

class BaseBodyWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/image/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white30,
            ),
            child: DataTable(
              columns: [
                headerTitle(text: 'Your Guess', context: context),
                headerTitle(text: 'Right Number', context: context),
                headerTitle(text: 'Right Position', context: context),
              ],
              rows: List.generate(
                10,
                (index) {
                  return DataRow(
                    // color: WidgetStateProperty.resolveWith(
                    //   (states) {
                    //     if (index == numberController.currentPosition - 1) {
                    //       return Colors.white30;
                    //     }
                    //     return null;
                    //   },
                    // ),
                    cells: [
                      bodyCell(
                        text: '1234',
                        context: context,
                        fontweight: FontWeight.bold,
                        color: Color.fromARGB(255, 12, 4, 83),
                      ),
                      bodyCell(
                        text: '0',
                        context: context,
                        fontweight: FontWeight.normal,
                        color: Color.fromARGB(255, 12, 4, 83),
                      ),
                      bodyCell(
                        text: '0',
                        context: context,
                        fontweight: FontWeight.normal,
                        color: Color.fromARGB(255, 12, 4, 83),
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
              maxLength: 4,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color.fromARGB(255, 12, 4, 83),
                    fontWeight: FontWeight.bold,
                  ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white54,
                hintText: 'Type your guess here...',
                hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.grey,
                    ),
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
