import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NearPharmaciesScreen extends StatefulWidget {
  const NearPharmaciesScreen({super.key});

  @override
  State<NearPharmaciesScreen> createState() => _NearPharmaciesScreenState();
}

class _NearPharmaciesScreenState extends State<NearPharmaciesScreen> {
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  // ignore: prefer_typing_uninitialized_variables
  late var url;
  var initialUrl = "https://www.google.com/";

  double progress = 0;
  var urlController = TextEditingController();
  @override
  void initState() {
    super.initState();
    refreshController = PullToRefreshController(
      onRefresh: () {
        webViewController!.reload();
      },
      options: PullToRefreshOptions(
        color: Colors.white,
        backgroundColor: Colors.black87,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      urlController.text = "Yakındaki Eczaneler";
      Future.delayed(const Duration(milliseconds: 300), () {
        _submitUrl(); // Otomatik olarak URL'yi yükle
      });
    });
  }

  void _submitUrl() {
    String value = urlController.text;
    url = Uri.parse(value);
    if (url.scheme.isEmpty) {
      url = Uri.parse("${initialUrl}search?q=$value");
    }
    webViewController?.loadUrl(urlRequest: URLRequest(url: url));
  }

  @override
  Widget build(BuildContext context) {
    urlController.text = "Yakındaki Eczaneler";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () async {
            if (await webViewController!.canGoBack()) {
              webViewController!.goBack();
            }
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: TextField(
            onEditingComplete: _submitUrl,
            onSubmitted: (_) => _submitUrl(),
            controller: urlController,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              webViewController!.reload();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              onLoadStart: (controller, url) {
                var v = url.toString();
                setState(() {
                  urlController.text = v;
                });
              },
              onLoadStop: (controller, url) {
                refreshController!.endRefreshing();
              },
              pullToRefreshController: refreshController,
              onWebViewCreated: (controller) => webViewController = controller,
              initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
            ),
          ),
        ],
      ),
    );
  }
}
