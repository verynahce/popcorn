import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as inAppWebView;
import 'package:http/http.dart' as http;
import 'constants.dart'; // 상수 파일 임포트

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
  home: WebViewExample(),
));

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late inAppWebView.InAppWebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true, // 뒤로가기 동작을 허용
      onPopInvokedWithResult: (didPop, result) async {
        if (await _controller.canGoBack()) {
          // 이전 페이지로 돌아갈 수 있으면, 뒤로 가기
          await _controller.goBack();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: inAppWebView.InAppWebView(
                initialUrlRequest: inAppWebView.URLRequest(
                  url: inAppWebView.WebUri('$baseUrl/Mobile/Users/LoginForm'),
                ),
                initialSettings: inAppWebView.InAppWebViewSettings(
                  javaScriptEnabled: true, // JavaScript 활성화
                ),
                onWebViewCreated: (controller) {
                  _controller = controller;
                },
                onLoadStop: (controller, url) async {
                  debugPrint('Page finished loading: $url');
                  String? userAgent = await _controller
                      .evaluateJavascript(source: "navigator.userAgent;");
                  debugPrint('User-Agent: $userAgent');
                  await checkCookie();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkCookie() async {
    debugPrint('checkCookie 실행 중');

    final cookies = await getCookiesFromWebView();
    for (var cookie in cookies) {
      print('쿠키 이름: ${cookie.name}, 쿠키 값: ${cookie.value}');
    }

    final cookieHeader =
    cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');

    final response = await http.get(
      Uri.parse('$baseUrl/Mobile/Users/CheckCookie'),
      headers: {
        'Accept': 'application/json',
        'Cookie': cookieHeader,
      },
    );

    debugPrint('HTTP 요청 완료: 상태 코드 ${response.statusCode}');
    if (response.statusCode == 200) {
      debugPrint('쿠키 확인 성공: ${response.body}');
    } else {
      debugPrint('쿠키 확인 실패: ${response.statusCode}');
    }
  }

  Future<List<inAppWebView.Cookie>> getCookiesFromWebView() async {
    final cookieManager = inAppWebView.CookieManager();
    final cookies = await cookieManager.getCookies(
      url: inAppWebView.WebUri('$baseUrl/Mobile/Users/Main'),
    );

    return cookies;
  }

}
