import 'package:flutter/material.dart';
import 'package:restaurant_order/common/const/colors.dart';
import 'package:restaurant_order/common/layout/default_layout.dart';

import '../../common/component/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 16.0,),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width:
                  MediaQuery
                      .of(context)
                      .size
                      .width / 3 * 2, // 즉, 전체화면 너비의 2/3
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16.0,),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (value) {},
                  obscureText: true,
                ),
                const SizedBox(height: 16.0,),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: Text('로그인', style: TextStyle(color: Colors.white),),
                ),
                TextButton(onPressed: () {}, style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ), child: Text('회원가입'))
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
