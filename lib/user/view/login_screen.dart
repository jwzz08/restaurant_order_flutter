import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant_order/common/const/colors.dart';
import 'package:restaurant_order/common/const/data.dart';
import 'package:restaurant_order/common/layout/default_layout.dart';
import 'package:restaurant_order/common/view/root_tab.dart';

import '../../common/component/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: SingleChildScrollView(
        //드래그 할 시에 자동으로 키보드 닫힘
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          bottom: false,
          top: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), //양쪽으로 패딩 넣어줌
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(
                  height: 16.0,
                ),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width /
                      3 *
                      2, // 즉, 전체화면 너비의 2/3
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  onChanged: (value) {
                    username = value;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    //ID:PWD
                    final rawString = '$username:$password';

                    //일반 string을 base64로 바꿔줌
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    String token = stringToBase64.encode(rawString);

                    // 여기에서 resp는 represh token과 access token이 들어있는 map
                    final resp = await dio.post(
                      'http://$ip/auth/login',
                      options:
                          Options(headers: {'authorization': 'Basic $token'}),
                    );

                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    await storage.write(
                        key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(
                        key: ACCESS_TOKEN_KEY, value: accessToken);

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RootTab(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                    onPressed: () async {

                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: Text('회원가입'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인을 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
