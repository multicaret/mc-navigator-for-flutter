import 'package:open_share_plus/open.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Todo(suheyl): [2024-11-05 - 8_26_a_m_] Work on extra actions.
class NavigateToExternal {
  static Future<bool> makePhoneCall(String phoneNumber) async {
    bool result = await canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber));
    if (!result) {
      return false;
    }
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    return await launchUrl(launchUri);
  }

  static String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<bool> openEmailTo(String email, String subject) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQueryParameters(<String, String>{
        'subject': subject,
      }),
    );

    bool result = await canLaunchUrl(emailLaunchUri);
    if (!result) {
      return false;
    }
    return await launchUrl(emailLaunchUri);
  }

  // Todo: 2023-05-15 - 8:46 p.m. Don't use it. Check next version of url_launcher
  // https://stackoverflow.com/questions/76244218/flutter-url-launcher-plugin-throws-java-lang-illegalargumentexception-receiver
  static Future<bool> openUrl(String url) async {
    bool isValid = await canLaunchUrlString(url);
    if (isValid) {
      final uri = Uri.parse(url);
      return await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      throw Exception('Could not launch');
    }
  }

  static Future<bool> openUri(Uri uri) async {
    bool isValid = await canLaunchUrl(uri);
    if (isValid) {
      return await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      throw Exception('Could not launch');
    }
  }

  // Todo: 2023-08-26 - 11:09 a.m. - Add webViewConfiguration to params
  static Future<bool> openUrlExternally(String url) async {
    bool isValid = await canLaunchUrlString(url);
    if (isValid) {
      return await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Could not launch');
    }
  }

  // Todo: 2023-05-15 - 8:46 p.m. Don't use it. Check next version of url_launcher
  // https://stackoverflow.com/questions/76244218/flutter-url-launcher-plugin-throws-java-lang-illegalargumentexception-receiver
  static Future<bool> openUrlInAppWebView(String url) async {
    bool isValid = await canLaunchUrlString(url);
    if (isValid) {
      return await launchUrlString(
        url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: false,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        ),
      );
    } else {
      throw Exception('Could not launch');
    }
  }

  static Future<bool> openAppWithUniversalLinkIos(String url) async {
    try {
      const LaunchMode launchMode = LaunchMode.externalNonBrowserApplication;
      final bool isSucceeded = await launchUrlString(url, mode: launchMode);

      if (!isSucceeded) {
        return await launchUrlString(url, mode: LaunchMode.inAppWebView);
      }
      return isSucceeded;
    } catch (e) {
      throw Exception('Could not launch');
    }
  }

  static Future<bool> appCanOpenUrl(String url) async {
    final Uri uri = Uri.parse(url);
    return await canLaunchUrl(uri);
  }

  static Future<bool> openWhatsApp({required String whatsAppNumber, String text = ""}) async {
    bool isSuccess = false;
    isSuccess = await Open.whatsApp(
      whatsAppNumber: whatsAppNumber,
      text: text,
    );
    if (!isSuccess) {
      Uri uri = Uri.parse("https://api.whatsapp.com/send?phone=$whatsAppNumber&text=$text");
      isSuccess = await openUri(uri);
    }
    return isSuccess;
  }
}
