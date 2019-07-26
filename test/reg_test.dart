import 'package:flutter_test/flutter_test.dart';

// 允许输入字母和数字
// 不允许全是数字
// 不允许全是字母
// 密码长度必须在8-20位之间
final passwordRegExp =
    RegExp(r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z!@#$%^&*_-]{8,20}$");

bool testPassword(String pwd, bool expect) {
  final result = passwordRegExp.hasMatch(pwd);
  print("$pwd test $result expect $expect");
  return result;
}

main(List<String> args) {
  test("password verify", () {
    expect(false, testPassword("test13", false));
    expect(true, testPassword("test12312312", true));
    expect(true, testPassword("test124124-0140", true));
    expect(true, testPassword("test1232`13", true));
    expect(true, testPassword("test1232", true));
    expect(true, testPassword("123test123", true));
    expect(false, testPassword("testqwdqwdqwdq", false));
    expect(false, testPassword("123789123123", false));
  });
}
