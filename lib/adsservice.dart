import 'dart:io';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:facebook_audience_network/ad/ad_interstitial.dart';

class AdsService {
  bool _isInterstitialAdLoaded = false;
  String getAdId() {
    if (Platform.isIOS) {
      FacebookAudienceNetwork.init(
        testingId: "b9f2908b-1a6b-4a5b-b862-ded7ce289e41",
      );
    } else if (Platform.isAndroid) {
      FacebookAudienceNetwork.init(
        testingId: "b9f2908b-1a6b-4a5b-b862-ded7ce289e41",
      );
    }
    return null;
  }

  String getAdBanner() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047";
    }

    return null;
  }

  String getAdIntegration1() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    } else if (Platform.isAndroid) {
      return 'IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617';
    }
    return null;
  }

  FacebookInterstitialAd loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId:
          getAdIntegration1(), //"IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617" YOUR_PLACEMENT_ID
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          loadInterstitialAd();
        }
      },
    );
  }

  showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstial Ad not yet loaded!");
  }

  FacebookBannerAd showBannerAd() {
    return FacebookBannerAd(
      placementId: getAdBanner(), //testid
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        print("Banner Ad: $result -->  $value");
      },
    );
  }
}
