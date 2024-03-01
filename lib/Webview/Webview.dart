// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class InAppWebViewPage extends StatefulWidget {
//   final String url;

//   InAppWebViewPage({required this.url});

//   @override
//   _InAppWebViewPageState createState() => _InAppWebViewPageState();
// }
// class _InAppWebViewPageState extends State<InAppWebViewPage> {
//   InAppWebViewController? webViewController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('In-App WebView Page'),
//       ),
//       body: InAppWebView(
//         initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
//         onWebViewCreated: (controller) {
//           webViewController = controller;
//         },
//         // Handle page navigation requests.
//         onLoadStart: (controller, url) {
//           // Disable the back button when navigating within the web view.
//           if (webViewController != null) {
//             webViewController!.canGoBack().then((value) {
//               // If the web view can go back, disable the mobile back button.
//               if (value) {
//                 webViewController!.clearHistory();
//               }
//             });
//           }
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewPage extends StatefulWidget {
  final String url;

  InAppWebViewPage({required this.url});

  @override
  _InAppWebViewPageState createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Payment Page'),
        ),
        body: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
          ),
        
      
    );
  }
}

