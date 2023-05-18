import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// 로그인 상태가 변할 시, 화면 초기화를 위해 ChangeNotifier
class AuthService extends ChangeNotifier {
  final validNumbers = RegExp(r'(\d+)');
  final validAlphabet = RegExp(r'[a-zA-Z]');

  // firebase_auth의 User클래스
  User? currentUser() {
    // 현재 로그인 된 유저의 객체 (User) 반환(로그인 되지 않은 경우 null 반환)
    return FirebaseAuth.instance.currentUser;
  }

  void signUp({
    required String email, // 이메일
    required String password, // 비밀번호
    required String passwordcheck,
    required Function() onSuccess, // 가입 성공시 호출되는 함수
    required Function(String err) onError, // 에러 발생시 호출되는 함수
  }) async {
    // 회원가입 유효성 검사, 이메일 및 비밀번호 입력 여부 확인
    if (email.isEmpty) {
      onError("이메일을 입력해 주세요");
      return;
    } else if (password.isEmpty) {
      onError("비밀번호를 입력해 주세요");
      return;
    } else if (password != passwordcheck) {
      onError("비밀번호가 동일하지 않아요");
    } else if (password.length > 16) {
      // 비밀번호 유효성 검사 1 (16자 이하)
      onError("비밀번호는 16자 이하로 입력해 주세요");
    } else if (!validNumbers.hasMatch(password)) {
      // 비밀번호 유효성 검사 2 (숫자 포함)
      onError("비밀번호는 숫자를 포함해 주세요");
    } else if (!validAlphabet.hasMatch(password)) {
      // 비밀번호 유효성 검사 3 (문자 포함)
      onError("비밀번호는 문자를 포함해 주세요");
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      // Firebase auth 에러; email 형식을 지키지 않았거나, 등
      // onError(e.message!);
      // onError를 한국어로 나오게 경우의 수 추가
      if (e.code == 'weak-password') {
        onError('비밀번호를 6자리 이상 입력해 주세요.');
      } else if (e.code == 'email-already-in-use') {
        onError('이미 가입된 이메일 입니다.');
      } else if (e.code == 'invalid-email') {
        onError('이메일 형식을 확인해주세요.');
      } else if (e.code == 'user-not-found') {
        onError('일치하는 이메일이 없습니다.');
      } else if (e.code == 'wrong-password') {
        onError('비밀번호가 일치하지 않습니다.');
      } else {
        onError(e.message!);
      }
    } catch (e) {
      // Firebase auth 이외의 에러
      onError(e.toString());
    }
  }

  void signIn({
    required String email, // 이메일
    required String password, // 비밀번호
    required Function() onSuccess, // 로그인 성공시 호출되는 함수
    required Function(String err) onError, // 에러 발생시 호출되는 함수
  }) async {
    // 로그인 유효성 검사
    if (email.isEmpty) {
      onError('이메일을 입력해 주세요.');
      return;
    } else if (password.isEmpty) {
      onError('비밀번호를 입력해 주세요.');
      return;
    }

    // 로그인 시도
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // 성공 시
      onSuccess();
      notifyListeners(); // 로그인 성공 시, 상태 변경
    } on FirebaseAuthException catch (e) {
      // Firebase auth 에러; email 형식을 지키지 않았거나, 등
      onError(e.message!);
    } catch (e) {
      // Firebase auth 이외의 에러
      onError(e.toString());
    }
  }

  void signOut() async {
    // 로그아웃
    await FirebaseAuth.instance.signOut();
    notifyListeners(); // 로그아웃 시, 상태 변경
  }
}
