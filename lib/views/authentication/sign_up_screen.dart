import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ropstom_task/cubits/authentication_cubits/authentication_cubit.dart';
import 'package:ropstom_task/views/authentication/log_in_screen.dart';

import '../../cubits/showpassword_cubit.dart';
import '../custom_widgets/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  ///text controller
  TextEditingController fullName = TextEditingController();

  TextEditingController contact = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirmPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///listener for authentication cubit if state changes
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          ///if user is registered and loaded state is emitted then will
          ///navigate to login screen
          if(state is AuthenticationLoaded){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return const LogInScreen();
            }));
          }
          // TODO: implement listener
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

            ///form for text fields validation
            Form(
              key: _formKey,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ///I also made custom textfield for update and create user
                  ///id didn't make these fields custom just to show you both the cases
                  ///Name text field
                  TextFormField(
                    //key: form,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z ]")),
                      ],
                      obscureText: false,
                      controller: fullName,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.only(top: 5.sp, left: 0.sp),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.green,
                          size: 18.sp,
                        ),

                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: const Color(0xffB2B2B2), width: 1.sp),
                        // ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.green, width: 1.sp),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.sp),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.red, width: 1.sp)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green, width: 1.1.sp),
                        ),
                        hintText: 'Full Name (Min 4 Characters)',
                        hintStyle: TextStyle(
                          fontSize: 20.h,
                          color: Colors.green,
                        ),
                      ),
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return 'Empty';
                        } else {
                          if (validator.length < 4) {
                            return 'Name must be at-least 4 characters';
                          }
                        }
                        return null;
                      }),
                  //noShadowTextField("Full Name", full_name),
                  SizedBox(
                    height: 15.h,
                  ),
                  ///number text field
                  TextFormField(
                    //key: form,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      obscureText: false,
                      controller: contact,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.only(top: 5.sp, left: 0.sp),
                        prefixIcon: Icon(
                          Icons.quick_contacts_dialer,
                          color: Colors.green,
                          size: 18.sp,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.green, width: 1.sp),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.sp),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.red, width: 1.sp)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green, width: 1.1.sp),
                        ),
                        hintText: 'Mobile Number (+923051234456)',
                        hintStyle: TextStyle(
                          fontSize: 20.h,
                          color: Colors.green,
                        ),
                      ),
                      validator: (validator) {
                        if (validator!.isEmpty) {
                          return 'Empty';
                        } else {
                          if (validator.length < 11) {
                            return 'Please provide mobile number in correct mentioned format';
                          }
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15.h,
                  ),
                  ///email text field
                  TextFormField(
                    //key: form,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z@.]")),
                      ],
                      obscureText: false,
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.only(top: 5.sp, left: 0.sp),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.green,
                          size: 18.sp,
                        ),

                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: const Color(0xffB2B2B2), width: 1.sp),
                        // ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.green, width: 1.sp),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.sp),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.red, width: 1.sp)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green, width: 1.1.sp),
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
                  SizedBox(
                    height: 15.h,
                  ),
                  ///password text field
                  BlocBuilder<ShowPasswordCubit, bool?>(
                    builder: (context, state) {
                      return TextFormField(
                          obscureText: state!,
                          controller: password,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.only(top: 5.sp, left: 0.sp),
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
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.sp),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red, width: 1.sp)),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 1.sp),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.1.sp),
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
                    height: 15.h,
                  ),

                  ///confirm password text field
                  BlocBuilder<ShowPasswordCubit, bool?>(
                    builder: (context, state) {
                      return TextFormField(
                          obscureText: state!,
                          controller: confirmPass,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.only(top: 5.sp, left: 0.sp),
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
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.sp),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 1.sp),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red, width: 1.sp)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green, width: 1.1.sp),
                            ),
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.green,
                            ),
                          ),
                          validator: (validator) {
                            if (validator!.isEmpty) {
                              return 'Empty';
                            } else {
                              if (validator != password.text) {
                                return 'Password does not match';
                              }
                            }
                            return null;
                          });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            SizedBox(
              height: 25.h,
            ),

            ///signup button and builder
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationLoading) {
                  return SizedBox(
                    height: 40.sp,
                    child: const Center(child: CircularProgressIndicator(),),
                  );
                } else {
                  ///sign up custom button and if form is validated then call
                  ///authentication cubit
                  return CustomButton(
                    text: 'Sign Up',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthenticationCubit>().registerUser(
                            userName: fullName.text.trim(),
                            email: email.text.trim(),
                            password: password.text.trim());
                      }
                    },
                  );
                }
              },
            ),
            SizedBox(height: 12.h,),

            ///if user already have an account then will be able to navigate
            ///to login screen
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const LogInScreen()));
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Already signed up? ',
                      style: TextStyle(color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(color: Colors.green,
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
