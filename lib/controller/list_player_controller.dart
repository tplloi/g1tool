import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../common/db/db_provider.dart';

class ListPlayerController extends GetxController {
  var listPlayer = <Player>[].obs;

  void getListPlayer() async {
    var list = await DBProvider.db.getAllPlayer();
    listPlayer.clear();
    listPlayer.addAll(list);
    listPlayer.refresh();
    print(">>>getListPlayer ${listPlayer.length}");
  }
}
