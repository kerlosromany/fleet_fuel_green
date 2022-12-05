import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../../constants/strings.dart';
import '../../styles/colors.dart';
import '../../view/default_grapping.dart';
import '../../view/fuel_station_sheet_content.dart';
import '../../widget/default_text.dart';
import '../../widget/default_text_field.dart';

class FindFuelStationScren extends StatelessWidget {
  FindFuelStationScren({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchFindFuelStationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.teal,
        title: const DefaultText(
          color: AppColor.white,
          fontSize: 24,
          fontWeight: FontWeight.w400,
          text: AppString.sFindFuelStation,
          fontFamily: AppString.sActor,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: ImageIcon(AssetImage(AppString.sNotify)),
          ),
        ],
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: Stack(
        children: [
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(30.033333, 31.233334),
              zoom: 12,
            ),
          ),
          SnappingSheet(
            lockOverflowDrag: true,
            snappingPositions: const [
              SnappingPosition.factor(
                positionFactor: 0.4,
                grabbingContentOffset: GrabbingContentOffset.bottom,
              ),
              SnappingPosition.factor(
                positionFactor: 0.7,
                grabbingContentOffset: GrabbingContentOffset.bottom,
              ),
              SnappingPosition.factor(
                positionFactor: 0.001,
                grabbingContentOffset: GrabbingContentOffset.top,
              ),
            ],
            grabbingHeight: 50,
            grabbing: DefaultGrabbing(
              color: AppColor.white,
              reverse: true,
            ),
            sheetBelow: SnappingSheetContent(
              childScrollController: _scrollController,
              child: FuelStationSheetContent(
                controller: _scrollController,
                reverse: false,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DefaultTextField(
                    height: 50,
                    hintTxt: "Search...",
                    color: AppColor.grey4,
                    isPassword: false,
                    textInputType: TextInputType.text,
                    textEditingController: searchFindFuelStationController,
                    validate: (value) {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
