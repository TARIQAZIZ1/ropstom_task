import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ropstom_task/cubits/authentication_cubits/authentication_cubit.dart';
import 'package:ropstom_task/cubits/category_cubit.dart';
import 'package:ropstom_task/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:ropstom_task/cubits/showpassword_cubit.dart';
import 'package:ropstom_task/views/authentication/log_in_screen.dart';
import 'data/init_sambast.dart';

import 'data/shared_pref.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var init =   InitSembast.initialize();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=> AuthenticationCubit()),
            BlocProvider(create: (context)=> DashboardCubit()),
            BlocProvider(create: (context)=> CarCategoryCubit()),
            BlocProvider(create: (context)=> ShowPasswordCubit(show: false)),
          ],
          child: MaterialApp(
            title: 'Ropstom Task',
            theme: ThemeData(

              primarySwatch: Colors.blue,
            ),
            home: child,
          ),
        );
      },
      ///initializing sembast, we can initialize it in any other screen also
      child: FutureBuilder(
        future: InitSembast.initialize(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const SizedBox();
          }else if(snapshot.hasError){
            return Material(child: Center(child: Text(snapshot.error.toString()),),);
          }else{
            return const LogInScreen();
          }
        }
      ),
    );
  }
}
