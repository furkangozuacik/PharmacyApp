import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class NearPharmaciesScreen extends StatefulWidget {
  const NearPharmaciesScreen({super.key});

  @override
  State<NearPharmaciesScreen> createState() => _NearPharmaciesScreenState();
}

class _NearPharmaciesScreenState extends State<NearPharmaciesScreen> {
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  late var url;
  var initialUrl = "https://www.google.com/";

  double progress = 0;
  var urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: TextField(
              controller: urlController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  hintText: "Search...", prefixIcon: Icon(Icons.search))),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
      ),
      body: Column(children: [
        Expanded(
            child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
        ))
      ]),
    );
  }
}
