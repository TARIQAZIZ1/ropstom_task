import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ropstom_task/cubits/authentication_cubits/authentication_cubit.dart';
import 'package:ropstom_task/views/authentication/sign_up_screen.dart';
import 'package:ropstom_task/views/dashboard_screen/dashboard_screen.dart';

import '../../cubits/showpassword_cubit.dart';
import '../custom_widgets/custom_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  ///email and password text controllers
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///bloc listener of authentication cubit to listen to state changes
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          ///if state is loaded then navigate to dashboard
          if(state is AuthenticationLoaded){
            Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => const DashBoardScreen()));

          }
        },
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 100.h,
            ),
            ///heading
            Center(
              child: Text(
                'Log In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.sp,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            ///I also made custom textfield for update and create user
            ///id didn't make these fields custom just to show you both the cases

            ///email text field
            TextFormField(
                //key: form,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@.]")),
                ],
                obscureText: false,
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5.sp, left: 0.sp),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.green,
                    size: 18.sp,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 1.sp),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.sp),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.sp)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.green, width: 1.1.sp),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontSize: 20.h,
                    color: Colors.green,
                  ),
                ),
                validator: (validator) {
                  if (validator!.isEmpty) {
                    return 'Empty';
                  }
                  return null;
                }),
            // noShadowTextField("Email", email,
            //     type: TextInputType.emailAddress),
            SizedBox(
              height: 15.h,
            ),

            ///password textfield
            BlocBuilder<ShowPasswordCubit, bool?>(
              builder: (context, state) {
                return TextFormField(
                    obscureText: state!,
                    controller: password,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5.sp, left: 0.sp),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green,
                        size: 18.sp,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (state == true) {
                            context
                                .read<ShowPasswordCubit>()
                                .showPassword(show: false);
                          } else {
                            context
                                .read<ShowPasswordCubit>()
                                .showPassword(show: true);
                          }
                        },
                        child: Icon(
                          state == true
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: Colors.green,
                          size: 21.sp,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green, width: 1.sp),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red, width: 1.sp)),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red, width: 1.sp),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green, width: 1.1.sp),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.green,
                      ),
                    ),
                    validator: (validator) {
                      if (validator!.isEmpty) {
                        return 'Empty';
                      } else {
                        if (validator.length < 8) {
                          return 'password must not be less than 8 characters';
                        }
                      }
                      return null;
                    });
              },
            ),

            SizedBox(
              height: 45.h,
            ),

            ///authentication builder
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  ///if loading then show loading indicator
              if (state is AuthenticationLoading) {
                return SizedBox(
                  height: 40.sp,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                ///login custom button
                return CustomButton(
                  text: 'LogIn',
                  onPress: () {
                    ///calling cubit to login user
                    context.read<AuthenticationCubit>().signInUser(
                        email: email.text.trim(),
                        password: password.text.trim());

                  },
                );
              }
            }),
            SizedBox(
              height: 12.h,
            ),

            ///if user is new and don't have account be able to navigate to signup screen
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Didn\'t SignedUp yet? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  TextSpan(
                    text: 'SignUp',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
