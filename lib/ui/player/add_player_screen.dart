import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g1tool/common/c/color_constant.dart';
import 'package:g1tool/common/c/dimen_constant.dart';
import 'package:g1tool/common/core/base_stateful_state.dart';
import 'package:get/get.dart';

import '../../common/utils/ui_utils.dart';
import '../../controller/add_player_controller.dart';

class AddPlayerScreen extends StatefulWidget {
  final VoidCallback onAddSuccess;

  const AddPlayerScreen({
    Key? key,
    required this.onAddSuccess,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddPlayerScreenState();
  }
}

class _AddPlayerScreenState extends BaseStatefulState<AddPlayerScreen> {
  final _cAddPlayer = Get.put(AddPlayerController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: UIUtils.getAppBar(
          "Thêm người chơi",
          () {
            SystemNavigator.pop();
          },
          null,
        ),
        body: Stack(
          children: [
            UIUtils.buildCachedNetworkImage(
                "https://live.staticflickr.com/65535/48556433996_fb33140ec1_b.jpg"),
            ListView(
              padding: const EdgeInsets.all(DimenConstants.marginPaddingMedium),
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.all(DimenConstants.marginPaddingMedium),
                  child: TextFormField(
                    maxLength: 30,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(Icons.person),
                      hintText: 'Nhập tên người chơi',
                      labelText: 'Tên *',
                    ),
                    onChanged: (text) {
                      _cAddPlayer.setName(text);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: _cAddPlayer.isValidName()
                ? ColorConstants.appColor
                : Colors.grey,
            onPressed: () {
              if (_cAddPlayer.isValidName()) {
                _cAddPlayer.addPlayer(_cAddPlayer.name.value);
              }
            },
            child: const Icon(Icons.add)),
      );
    });
  }
}
