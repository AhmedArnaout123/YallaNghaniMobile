import 'package:yallangany/providers/user_identity_provider.dart';

class ConstDataHelper {
  static const String baseUrl = 'https://yallanghani.ahmedarnaout.com';

  static const String apiKey =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiOTUwM2YyMzk4ZWQzNGZjN2YyYzcxZDIzOTY1ZDI0MzdlOGZmMjgyZWU3ZTVkNGQ5OWUyMTE3ZmJjNzlhMTdjZGM4YTg3MTYxMWQxZGUwM2MiLCJpYXQiOjE1NzU5MDU1MDUsIm5iZiI6MTU3NTkwNTUwNSwiZXhwIjoxNjA3NTI3OTA1LCJzdWIiOiIiLCJzY29wZXMiOlsiKiJdfQ.ZnQ6vthIoi4bTo2RjRWjJ0rnndk5wASqjud_eNZVdWHgFT6Pot9I6ODrm9wLKasJFTBhd3PInZ0gNZZwQgSZFUMbAfAuws1JL36Cw9FUHEONaUU9coWTJaLWI-d3rp-_xf8l0saoe8oPzDgjbfsfOmkteLeYdFYTqLhqs3099r4Zrh2UngllLmhS7hhj74Vja6kClUbkiKoUyV645ajIbz5oSc2oaAxN5_0N_EBoDsL3avLP-k0mwkrfK6wA3I3EXyy8yx6A1xczx9WLcrwXzSiCz0LnNhs7WkWFrhrzWbvaeBs5EeacLdAERv8vjq4OJGJv31kkJ8XFf3aGwCqNpl7Cpbkkn0PEfGOlHYzvuHsdc_e6F1ux2CDAB_842B6WznRmnV-bFleexjW4ez_HpvXKP7EOO5Lj1tGjYm9jdKAwjPO5jTpB2lfJyc7o63W4uRuwYgS-mdkM2XhuhtVzNJLSQL0uaBrrMeEh9QGJ8IerwXd5xxPRmZIeQffRGVpc25T_LbuPUoFeaSc29LVwSh2XNBEewbdKK11QNBlEwRdzgBkVgVv6MEivrTsuQlzyaHYV77uYueI2ant9YnPWQ_Uxaz3NOVpLeMTn8UAjSweohB2fUlXcq7Bzc_RiFWsv4rnLNId7jggt4xVzdxPZhFHpVo3zu0cd2Bc6ui8SRt0';

  static Map<String, String> get apiCommonHeaders => {
        'Authorization': 'Bearer ${UserIdentityProvieder().getToken()}',
        'Content-Type': 'application/json'
      };

  static const String passwordPattern =
      'Password must contain at least one letter, at least one number, and shuold be at least  8 charaters length.';
}
