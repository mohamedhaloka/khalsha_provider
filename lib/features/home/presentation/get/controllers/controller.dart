import 'package:get/get.dart';
import 'package:khalsha/core/data/models/enums/service_types.dart';
import 'package:khalsha/core/data/models/item_model.dart';
import 'package:video_cached_player/video_cached_player.dart';

class HomeController extends GetxController {
  List<ItemModel> services = <ItemModel>[];

  late CachedVideoPlayerController videoController;

  RxBool showVideo = false.obs;

  @override
  void onInit() {
    videoController = CachedVideoPlayerController.network(
        'https://drive.google.com/uc?export=download&id=1SvcpuZW_-clbKU7ZFg_RRNy3QTZ31-tb')
      ..initialize().then((_) {
        showVideo(true);
      });
    services = const [
      ItemModel(
        id: 1,
        image: 'landshippings',
        text: 'الشحن البري',
        arguments: ServiceTypes.landShipping,
      ),
      ItemModel(
        id: 0,
        image: 'customsclearance',
        text: 'التخليص الجمركي',
        arguments: ServiceTypes.customsClearance,
      ),
      ItemModel(
        id: 3,
        image: 'seashippings',
        text: 'الشحن البحري',
        arguments: ServiceTypes.marineShipping,
      ),
      ItemModel(
        id: 2,
        image: 'warehouses',
        text: 'المخازن',
        arguments: ServiceTypes.stores,
      ),
      ItemModel(
        id: 5,
        image: 'laboratories',
        text: 'المختبرات و المقاييس',
        arguments: ServiceTypes.laboratoryAndStandards,
      ),
      ItemModel(
        id: 4,
        image: 'airshippings',
        text: 'الشحن الجوي',
        arguments: ServiceTypes.airFreight,
      ),
    ];
    super.onInit();
  }
}
