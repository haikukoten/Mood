// 允许输入字母和数字
// 不允许全是数字
// 不允许全是字母
// 密码长度必须在8-20位之间
final passwordRegExp = RegExp(r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z@]{8,20}$");

bool testPassword(String pwd, bool expect) {
  final result = passwordRegExp.hasMatch(pwd);
  print(
      "$pwd \ttest \t${result.toString().toUpperCase()} \texpect \t${expect.toString().toUpperCase()}");
  return result;
}

main(List<String> args) {
  testPassword("test13", false);
  testPassword("test12312312", true);
  testPassword("test124124-0140", false);
  testPassword("test1232`13", false);
  testPassword("test1232", true);
  testPassword("123test123", true);
  testPassword("testqwdqwdqwdq", false);
  testPassword("123789123123", false);
}
