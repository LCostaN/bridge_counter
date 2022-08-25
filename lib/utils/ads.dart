import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  static const _androidId = "ca-app-pub-9828953482644875~7485081775";
  static const _iosId = "";
  // static const _screenAdId = "ca-app-pub-9828953482644875/5526160511";

  static Ads _instance = Ads._();

  static Ads get instance => _instance;

  Ads._() {
    MobileAds.instance.initialize();
  }

  static final AdRequest request = AdRequest(
    keywords: ["game", "casual game", "arcade game"],
    nonPersonalizedAds: true,
  );

  InterstitialAd? _ad;
  int _numInterstitialLoadAttempts = 0;
  static const int _maxFailedLoadAttempts = 3;

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? _androidId
            : _iosId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _ad = ad;
            _numInterstitialLoadAttempts = 0;
            _ad!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _ad = null;
            if (_numInterstitialLoadAttempts < _maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (_ad == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _ad!.show();

    _createInterstitialAd();
  }

  void disposeAd() {
    _ad?.dispose();
  }
}