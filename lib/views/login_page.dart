import 'package:bio_app/main.dart';
import 'package:bio_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const users = {'admin': 'admin'};

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userState = ref.read(userProvier.notifier);

    String? usernameValidator(String? input) {
      if (input == null) return "不可為空白！";
      // if (input.length < 8) return "長度須至少為8碼！";
      // if (input.length >= 128) return "長度太長！";
      // final regExp = RegExp(r"^(?=.*\d)((?=.*[a-z])|(?=.*[A-Z])).{8,128}$");
      // if (!regExp.hasMatch(input)) return "需為英文數字組合！";
      return null;
    }

    String? passwordValidator(String? input) {
      if (input == null) return "不可為空白！";
      // if (input.length < 8) return "長度須至少為8碼！";
      // final regExp = RegExp(r"^(?=.*\d)((?=.*[a-z])|(?=.*[A-Z])).{8,128}$");
      // if (!regExp.hasMatch(input)) return "需為英文數字組合！";

      return null;
    }

    Future<String?> login(LoginData data) async {
      try {
        if (users[data.name] == data.password) {
          return null; // ⭐ 成功
        }
        return "帳號或密碼錯誤";
        // final user = await userState.login(data.name, data.password);
        // if (!user.verified) {
        //   Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => VerifyEmailPage(),
        //   ));
        //   return "";
        // }
      } catch (err) {
        return err.toString();
      }
    }

    Future<String?> signUp(SignupData data) async {
      try {
        if (data.name == null || data.name!.isEmpty) {
          return '使用者名稱不可為空白';
        }

        if (data.password == null || data.password!.isEmpty) {
          return '密碼不可為空白';
        }
        final email = data.additionalSignupData?['email'];
        if (email == null || email.isEmpty) {
          return 'Email 不可為空白';
        }

        return null;
      } catch (err) {
        return err.toString();
      }
    }
    Future<String?> confirmSignup(String email, LoginData data) async {
      try {
        return null;
      } catch (err) {
        return err.toString();
      }
    }
    Future<String?> resetPassword(String email) async {
      try {
        // await userState.forgotPassword(email);
        return null;
      } catch (err) {
        return err.toString();
      }
    }

    return FlutterLogin(
      title: "中油生態地圖",
      onLogin: login,
      onSignup: signUp,
      additionalSignupFields: [
        UserFormField(
          keyName: 'email',
          displayName: 'Email',
          icon: Icon(Icons.email),
          userType: LoginUserType.email,
          fieldValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
            if (!emailRegex.hasMatch(value)) {
              return 'Invalid email format';
            }
            return null;
          },
        ),
      ],
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      },
      // onConfirmSignup: confirmSignup, // 如果要進入confirm code頁面
      onRecoverPassword: resetPassword,
      hideForgotPasswordButton: false,
      theme: LoginTheme(
        primaryColor: Colors.blue,
        titleStyle: TextStyle(color: Colors.white),
        textFieldStyle: TextStyle(fontSize: 18),
        bodyStyle: TextStyle(fontSize: 18),
        buttonStyle: TextStyle(fontSize: 18),
      ),
      userType: LoginUserType.name,
      messages: LoginMessages(
        userHint: '使用者名稱',
        passwordHint: '密碼',
        confirmPasswordHint: '確認密碼',
        loginButton: '登入',
        signupButton: '註冊',
        goBackButton: '返回',
        confirmPasswordError: '密碼不一致！',
        signUpSuccess: "註冊成功！請至電子郵件信箱驗證您的帳號！",
        additionalSignUpSubmitButton: "寄送驗證信件",
        additionalSignUpFormDescription: "驗證電子郵件信箱",
        confirmSignupIntro: "confirmSignupIntro",
        confirmSignupButton: "confirmSignupButton",
        confirmSignupSuccess: "Sign up successfully",
        forgotPasswordButton: "忘記密碼？",
        recoverPasswordButton: "重設密碼",
        recoverPasswordIntro: "請輸入您的電子郵件地址",
        recoverPasswordDescription: "我們將會發送一封重設密碼的郵件至您的電子郵件信箱",
        recoverPasswordSuccess: "重設密碼郵件已發送至您的信箱！",
      ),
      userValidator: usernameValidator,
      passwordValidator: passwordValidator,
      loginAfterSignUp: false,

    );
  }
}

// extension on LoginData {
//   get email => null;
//
//   get legalName => null;
// }

extension on LoginMessages {
  get emailHint => null;
}
