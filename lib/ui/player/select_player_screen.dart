import 'package:animated_background/animated_background.dart';
import 'package:animated_background/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:g1tool/common/c/dimen_constant.dart';
import 'package:g1tool/model/player.dart';
import 'package:get/get.dart';

import '../../common/c/string_constant.dart';
import '../../common/core/base_stateful_state.dart';
import '../../common/utils/ui_utils.dart';
import '../../controller/player/select_player_controller.dart';

class SelectPlayerScreen extends StatefulWidget {
  final Function(List<Player> listPlayerSelected) onListPlayerSelected;

  const SelectPlayerScreen({
    Key? key,
    required this.onListPlayerSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectPlayerScreenState();
  }
}

class _SelectPlayerScreenState extends BaseStatefulState<SelectPlayerScreen>
    with TickerProviderStateMixin {
  final _cSelectPlayer = Get.put(SelectPlayerController());

  @override
  void initState() {
    super.initState();
    _cSelectPlayer.getListPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: UIUtils.getAppBar(
          "Chọn người chơi",
          () {
            Get.back();
          },
          null,
        ),
        body: Stack(
          children: [
            UIUtils.buildCachedNetworkImage(StringConstants.bkgLink),
            AnimatedBackground(
              behaviour: BubblesBehaviour(),
              vsync: this,
              child: _buildListPlayerView(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: _cSelectPlayer.isValidListPlayerSelected()
                ? ColorConstants.appColor
                : Colors.grey,
            onPressed: () {
              if (_cSelectPlayer.isValidListPlayerSelected()) {
                widget.onListPlayerSelected
                    .call(_cSelectPlayer.getListPlayerSelected());
                Get.back();
              }
            },
            child: const Icon(Icons.done_all)),
      );
    });
  }

  Widget _buildListPlayerView() {
    var list = _cSelectPlayer.listPlayer;
    if (list.isEmpty) {
      return UIUtils.buildNoDataView();
    } else {
      Widget buildItem(Player p, GestureTapCallback onTap) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
            margin:
                const EdgeInsets.only(top: DimenConstants.marginPaddingMedium),
            color: Colors.white70,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(150.0),
                  child: Image.network(
                    p.avatar ?? '',
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: DimenConstants.marginPaddingMedium),
                Expanded(
                  child: UIUtils.getText(
                    p.getName(),
                    fontSize: DimenConstants.txtLarge,
                  ),
                ),
                if (p.isSelected == true)
                  Image.asset(
                    "assets/images/ic_success.png",
                    width: 35,
                    height: 35,
                  ),
              ],
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, i) {
            Player p = list[i];
            return buildItem(
              p,
              () {
                _cSelectPlayer.toggleSelectPlayer(i);
              },
            );
          },
        ),
      );
    }
  }
}
