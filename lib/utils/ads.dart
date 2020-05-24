import 'package:firebase_admob/firebase_admob.dart';

class Ads {
  static const _appId = "ca-app-pub-9828953482644875~7485081775";
  static const _screenAdId = "ca-app-pub-9828953482644875/5526160511";

  static Ads _instance;
  InterstitialAd _screenAd;

  static Ads get instance {
    return _instance ??= Ads._();
  }

  Ads._() {
    FirebaseAdMob.instance.initialize(appId: _appId, analyticsEnabled: true);
  }

  InterstitialAd _createAd() {
    MobileAdTargetingInfo targetInfo = MobileAdTargetingInfo(
      keywords: ["game", "casual game", "arcade game"],
      childDirected: false,
    );

    return InterstitialAd(
        adUnitId: _screenAdId,
        targetingInfo: targetInfo,
        listener: (event) {
          switch (event) {
            case MobileAdEvent.clicked:
              print("Ad clicked");
              break;
            case MobileAdEvent.impression:
              print("Ad impression");
              break;
            case MobileAdEvent.loaded:
              print("Ad loaded");
              break;
            default:
              print("Failed to load Ad: $event");
              hideAd();
          }
        });
  }

  Future<void> showAd() async {
    _screenAd ??= _createAd();
    await _screenAd.load();
    await _screenAd.show();
  }

  void hideAd() {
    _screenAd?.dispose();
    _screenAd = null;
  }
}