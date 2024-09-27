import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/decorations.dart';
import '../utils/images.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class MyWebViewFlutter extends StatefulWidget {
  const MyWebViewFlutter({Key? key}) : super(key: key);

  @override
  State<MyWebViewFlutter> createState() => _MyWebViewFlutterState();
}

class _MyWebViewFlutterState extends State<MyWebViewFlutter> {
  var checkoutURL = 'www.google.com';

  @override
  void initState() {
    super.initState();

    checkoutURL = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: bizAppBarDecorationBox(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              verticalSpace(height: 8),
              SafeArea(
                child: MySecondAppBar(
                  appbarLogo: ic_backIcon,
                  appbarText: 'Fund Wallet',
                  fontStyle: FontStyle.normal,
                  onPress: () {},
                ),
              ),
              verticalSpace(height: 12),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: getBody(size),
    );
  }

  getBody(Size size) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onProgress: (int progress) {
                      // Update loading bar if needed
                    },
                    onPageStarted: (String url) {
                      // Handle page start if needed
                    },
                    onPageFinished: (String url) {
                      // Handle page finish if needed
                    },
                    onHttpError: (HttpResponseError error) {
                      // Handle HTTP errors if needed
                    },
                    onWebResourceError: (WebResourceError error) {
                      // Handle web resource errors if needed
                    },
                    onNavigationRequest: (NavigationRequest request) {
                      var url = request.url;
                      logMessage(url);
                      if (isNotEmpty(url)) {
                        var segments = Uri.parse(url).pathSegments;
                        var segmentsLength = segments.length;
                        if (segmentsLength > 0) {
                          var response = segments[segmentsLength - 1];
                          if (response == 'error' || response == 'success') {
                            Future.delayed(const Duration(seconds: 3), () {
                              Get.back(
                                  result: {'success': (response == 'success')});
                            });
                          }
                        }
                      }
                      // Prevent navigation to YouTube URLs
                      if (url.startsWith('https://www.youtube.com/')) {
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                )
                ..loadRequest(Uri.parse(checkoutURL)), // Load the checkout URL
            ),
          ),
        ],
      ),
    );
  }
}
