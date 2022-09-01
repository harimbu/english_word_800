import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsHomeController extends GetxController {
  static const unitId = 'ca-app-pub-3940256099942544/6300978111';
  late BannerAd staticAd;
  RxBool staticAdLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadStaticBannerAd();
  }

  void loadStaticBannerAd() {
    staticAd = BannerAd(
        adUnitId: unitId,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(onAdLoaded: (ad) {
          staticAdLoaded.value = true;
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }));

    staticAd.load();
  }
}
