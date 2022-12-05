import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../constants/strings.dart';
import '../../styles/colors.dart';
import '../../view/default_grapping.dart';
import '../../view/workshop_sheet_content.dart';
import '../../widget/default_text_field.dart';

class FindWorkShopsScreen extends StatelessWidget {
  FindWorkShopsScreen({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchFindWorkshopController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.teal,
        title: const Text(AppString.sFindworkshop),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 0.02 * screenWidth),
            child: const ImageIcon(
              AssetImage(AppString.sNotify),
            ),
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
                positionFactor: 0.001,
                grabbingContentOffset: GrabbingContentOffset.top,
              ),
            ],
            grabbingHeight: 0.06 * screenHeight,
            grabbing: DefaultGrabbing(
              color: AppColor.white,
              reverse: true,
            ),
            sheetBelow: SnappingSheetContent(
              childScrollController: _scrollController,
              child: WorkshopSheetContent(
                controller: _scrollController,
                reverse: false,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(0.05 * screenWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DefaultTextField(
                      height: 50,
                      hintTxt: "Search...",
                      color: AppColor.grey4,
                      isPassword: false,
                      textInputType: TextInputType.text,
                      textEditingController: searchFindWorkshopController,
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
