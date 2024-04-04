import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_game/models/result_model.dart';
import 'package:number_game/services/result_db.dart';

class ResultController extends GetxController {
  static ResultController get to => Get.put(ResultController());
  var results = <ResultModel>[].obs;
  late ResultModel resultModel;
  var resultLength = 0.obs;
  var maxScore = 0.obs;
  final ScrollController scrollController = ScrollController();

  onInit() {
    super.onInit();
    initDateData();
    print('Init');
  }

  scrollToLast() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.viewportDimension,
          duration: Duration(milliseconds: 300), // Adjust duration as needed
          curve: Curves.decelerate, // Adjust curve as needed
        );
      }
    });
  }

  findMaxScore(var dbResponse) async {
    var maxItem = dbResponse[0];
    for (var e in dbResponse) {
      if (e.win >= maxItem.win &&
          e.win >= maxItem.lose &&
          e.win >= maxItem.pass) {
        maxScore.value = e.win;
        maxItem = e;
      }
      if (e.lose >= maxItem.win &&
          e.lose >= maxItem.lose &&
          e.lose >= maxItem.pass) {
        maxScore.value = e.lose;
        maxItem = e;
      }
      if (e.pass >= maxItem.win &&
          e.pass >= maxItem.lose &&
          e.pass >= maxItem.pass) {
        maxScore.value = e.pass;
        maxItem = e;
      }
    }
  }

  checkFirstPlay(var latestResponse) {
    DateTime now = DateTime.now();
    DateTime dateToAdd;
    for (var i = 4; i >= 0; i--) {
      dateToAdd = now.subtract(Duration(days: i));
      ResultDB.addDate(
        ResultModel(
          date: DateFormat('yyyy-MM-dd').format(dateToAdd),
          win: 0,
          lose: 0,
          pass: 0,
        ),
      );
      results.add(
        ResultModel(
          date: DateFormat('yyyy-MM-dd').format(dateToAdd),
          win: 0,
          lose: 0,
          pass: 0,
        ),
      );
    }
    resultLength.value = results.length;
  }

  checkLongTimeNoPlay(DateTime latestDate, DateTime now) {
    do {
      latestDate = latestDate.add(Duration(days: 1));
      ResultDB.addDate(
        ResultModel(
          date: DateFormat('yyyy-MM-dd').format(latestDate),
          win: 0,
          lose: 0,
          pass: 0,
        ),
      );
      results.add(
        ResultModel(
          date: DateFormat('yyyy-MM-dd').format(latestDate),
          win: 0,
          lose: 0,
          pass: 0,
        ),
      );
    } while (latestDate.isBefore(now));
    resultLength.value = results.length;
  }

  initDateData() async {
    var latestResponse = await ResultDB.getLatestDate();
    if (latestResponse!.isEmpty) {
      checkFirstPlay(latestResponse);
      print('First time to play');
    } else {
      DateTime now = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      DateTime latestDate = DateTime(
        int.parse(latestResponse[0].date.substring(0, 4)),
        int.parse(latestResponse[0].date.substring(5, 7)),
        int.parse(latestResponse[0].date.substring(8, 10)),
      );
      print('latest date: ' + latestDate.toString());
      if (latestDate.isBefore(now)) {
        checkLongTimeNoPlay(latestDate, now);
        print('Long time no play');
      }
    }
    var dbResponse = await ResultDB.getFiveLatestDate();
    results.assignAll(dbResponse);
    resultLength.value = results.length;
    findMaxScore(dbResponse);
    print('get 5 latest date: ' + resultLength.toString());
  }

  // 1: win, 2: lose, 0:pass
  updateScore(int result) async {
    var latestResponse = await ResultDB.getLatestDate();
    DateTime dateNow = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    DateTime latestDate = DateTime(
      int.parse(latestResponse![0].date.substring(0, 4)),
      int.parse(latestResponse[0].date.substring(5, 7)),
      int.parse(latestResponse[0].date.substring(8, 10)),
    );
    print('latest date: ' + latestDate.toString());
    if (latestDate.isBefore(dateNow)) {
      checkLongTimeNoPlay(latestDate, dateNow);
      print('new date already come!');
      var newResponse = await ResultDB.getFiveLatestDate();
      results.assignAll(newResponse);
      results.refresh();
    }

    // Old
    var now = await ResultDB.getNow();
    int win = now![0].win, lose = now[0].lose, pass = now[0].pass;
    ResultDB.updateDate(
      ResultModel(
        id: now[0].id,
        date: now[0].date,
        win: result == 1 ? win + 1 : win,
        lose: result == 2 ? lose + 1 : lose,
        pass: result == 0 ? pass + 1 : pass,
      ),
    );
    results[4] = ResultModel(
      id: now[0].id,
      date: now[0].date,
      win: result == 1 ? win + 1 : win,
      lose: result == 2 ? lose + 1 : lose,
      pass: result == 0 ? pass + 1 : pass,
    );
    var dbResponse = await ResultDB.getFiveLatestDate();
    findMaxScore(dbResponse);
  }
}
