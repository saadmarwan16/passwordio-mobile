import 'package:passwordio/app/data/password.dart';
import 'package:http/http.dart' as http;

class PasswordProvider {
  Future<Password> fetchPassword(
    int length,
    bool uppercase,
    bool lowercase,
    bool numbers,
    bool isUseUppercase,
    bool symbols,
  ) async {
    final uriString =
        "https://marisky-password-generator.herokuapp.com/?length=$length&uppercase=$uppercase&lowercase=$lowercase&numbers=$numbers&symbols=$symbols";
    final url = Uri.parse(uriString);
    final response = await http.get(url);
    final password = passwordFromJson(response.body);

    return password;
  }
}
