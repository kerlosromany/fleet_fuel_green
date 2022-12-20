import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:magdsoft_flutter_structure/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft_flutter_structure/constants/constants.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/toast.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import '../../../constants/strings.dart';
import '../../styles/colors.dart';
import '../../view/default_grapping.dart';
import '../../view/fuel_station_sheet_content.dart';
import '../../view/fuel_station_sheet_content2.dart';
import '../../view/fuel_station_sheet_content3.dart';
import '../../widget/default_text.dart';
import '../../widget/default_text_field.dart';

class FindFuelStationScren extends StatefulWidget {
  FindFuelStationScren({Key? key}) : super(key: key);

  @override
  State<FindFuelStationScren> createState() => _FindFuelStationScrenState();
}

class _FindFuelStationScrenState extends State<FindFuelStationScren> {
  final ScrollController _scrollController = ScrollController();

  TextEditingController searchFindFuelStationController =
      TextEditingController();

  late GoogleMapController googleMapController;
  Set<Marker> markers = {};

  Future<Position> _determinePosition() async {
    late bool serviceEnabled;
    late LocationPermission locationPermission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(showToast("Location services are disables", context,
          toastDuration: 5));
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error(showToast("Location Permission is denied", context,
            toastDuration: 5));
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(showToast(
          "Location Permissions are permanently denied", context,
          toastDuration: 5));
    }
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      AppConstants.latitude = position.latitude;
      AppConstants.longtude = position.longitude;
    });

    print("latitude => ${AppConstants.latitude}");
    print("longitude => ${AppConstants.longtude}");
    return position;
  }

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
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(30.033333, 31.233334),
              zoom: 12,
            ),
            markers: markers,
            onMapCreated: (controller) {
              googleMapController = controller;
            },
          ),
          SnappingSheet(
            lockOverflowDrag: true,
            snappingPositions: const [
              SnappingPosition.factor(
                positionFactor: 0.7,
                grabbingContentOffset: GrabbingContentOffset.bottom,
              ),
              SnappingPosition.factor(
                positionFactor: 0.4,
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
              child: BlocBuilder<GlobalCubit, GlobalState>(
                builder: (context, state) {
                  if (state is ChangeSheetContentToSecondSheet) {
                    return FuelStationSheetContent2(
                      controller: _scrollController,
                      reverse: false,
                    );
                  }
                  if (state is ChangeSheetContentToThirdSheet) {
                    return FuelStationSheetContent3(
                      controller: _scrollController,
                      reverse: false,
                    );
                  }
                  return FuelStationSheetContent(
                    controller: _scrollController,
                    reverse: false,
                  );
                },
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
                    isSearch: true,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14),
            ),
          );
          markers.clear();
          markers.add(
            Marker(
              markerId: const MarkerId("currentLocation"),
              position: LatLng(position.latitude, position.longitude),
            ),
          );
          setState(() {});
        },
        label: const Text("Current Location"),
        icon: const Icon(Icons.location_on),
        backgroundColor: AppColor.teal,
      ),
    );
  }
}
