import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as place;
import 'package:location/location.dart';

import '../../../../../core/data/source/local/lang_locale.dart';
import '../../../../../core/domain/error/failures.dart';
import '../../../../../core/domain/use_cases/use_case.dart';
import '../../../data/model/location_details.dart';
import '../../../domain/use_case/get_device_location_use_case.dart';
import '../../../domain/use_case/get_location_name_use_case.dart';
import '../../../domain/use_case/get_place_details_use_case.dart';
import '../../../domain/use_case/get_places_from_search_use_case.dart';

class MapController extends GetxController {
  final GetDeviceLocationUseCase _getDeviceLocationUseCase;
  final GetLocationNameUseCase _getLocationNameUseCase;
  final GetPlacesFromSearchUseCase _getPlacesFromSearchUseCase;
  final GetPlaceDetailsUseCase _getPlaceDetailsUseCase;
  MapController(
    this._getDeviceLocationUseCase,
    this._getLocationNameUseCase,
    this._getPlacesFromSearchUseCase,
    this._getPlaceDetailsUseCase,
  );

  LocationDetails locationDetails = LocationDetails.fromArgs(Get.arguments);

  CameraPosition mapPosition =
      const CameraPosition(target: LatLng(25.345130, 51.250942), zoom: 16);
  RxBool loading = false.obs,
      getLocationDataLoading = false.obs,
      searchLoading = false.obs;
  String locationName = '';

  TextEditingController searchController = TextEditingController();

  RxList<place.Prediction> places = <place.Prediction>[].obs;

  Completer<GoogleMapController> myMapController = Completer();

  @override
  void onInit() {
    getDevLocation();
    super.onInit();
  }

  @override
  void onClose() {
    try {
      searchController.dispose();
    } catch (_) {}
    super.onClose();
  }

  void intMapController(double? lat, double? long) {
    mapPosition = CameraPosition(
        target: LatLng(lat ?? 25.345130, long ?? 51.250942), zoom: 16);
  }

  void changeLatLong(double lat, double long) {
    locationDetails.lat = lat;
    locationDetails.long = long;
  }

  Params get params => Params(loading: loading);

  Future<void> getDevLocation() async {
    final result = await _getDeviceLocationUseCase.execute(params);
    result.fold(_onGetDeviceLocationFail, _onGetDeviceLocationSuccess);
  }

  void _onGetDeviceLocationSuccess(LocationData locationData) async {
    final lat = locationData.latitude ?? 0.0;
    final long = locationData.longitude ?? 0.0;
    if (await checkPointWithinRegion(lat, long)) {
      intMapController(lat, long);
      changeLatLong(lat, long);
    }
    getLocationString();
  }

  void _onGetDeviceLocationFail(Failure failure) {
    log(failure.statusMessage ?? '', name: 'FAILURE');
    intMapController(0, 0);
  }

  Future<bool> checkPointWithinRegion(double lat, double long) async {
    GoogleMapController mapController = await myMapController.future;
    final region = await mapController.getVisibleRegion();
    final currentPoint = LatLng(lat, long);
    return region.contains(currentPoint);
  }

  GetLocationNameParams get getLocationParams => GetLocationNameParams(
        loading: getLocationDataLoading,
        lat: locationDetails.lat,
        long: locationDetails.long,
      );

  Future<void> getLocationString() async {
    final result = await _getLocationNameUseCase.execute(getLocationParams);
    result.fold(
      (failure) => log(failure.statusMessage ?? '', name: 'FAILURE'),
      _onGetLocationStringSuccess,
    );
  }

  void _onGetLocationStringSuccess(String locationName) {
    this.locationName = locationName;
    locationDetails.name = locationName;
  }

  Future<void> getPlacesFromSearch() async {
    places.clear();
    final language = Lang.instance.isEn ? 'en' : 'ar';
    final params = GetPlacesFromSearchParams(
      loading: searchLoading,
      search: searchController.text,
      language: language,
    );
    final result = await _getPlacesFromSearchUseCase.execute(params);
    result.fold(
      (failure) => log(failure.statusMessage ?? '', name: 'FAILURE'),
      (places) => this.places.addAll(places),
    );
  }

  Future<void> getPlaceDetails(String placeId) async {
    final language = Lang.instance.isEn ? 'en' : 'ar';
    final params = GetPlaceDetailsParams(
        loading: false.obs, placeId: placeId, language: language);
    final result = await _getPlaceDetailsUseCase.execute(params);
    result.fold((_) => _, _onGetPlaceDetailsSuccess);
  }

  void _onGetPlaceDetailsSuccess(placeDetails) async {
    searchController.text = placeDetails.result.name;
    final lat = placeDetails.result.geometry!.location.lat;
    final lng = placeDetails.result.geometry!.location.lng;
    changeLatLong(lat, lng);
    final GoogleMapController controller = await myMapController.future;
    controller.moveCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));
  }
}
