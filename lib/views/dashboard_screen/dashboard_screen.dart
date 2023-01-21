import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ropstom_task/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:ropstom_task/data/app_constants.dart';
import 'car_detail_card.dart';
import 'components/add_new_entry_dialog.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  @override

  ///fetching data from db in init function for which i need before build function
  void initState() {

    context.read<DashboardCubit>().fetchData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///appBar
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'DashBoard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body:
      ///bloc listener to listen to different state changes
      BlocListener<DashboardCubit, DashboardState>(
          listener: (context, state) {
            ///when new entry is added
            if(state is DashboardNewAdded){
              context.read<DashboardCubit>().fetchData();
            }
            ///when entry is updated
            if(state is DashboardUpdate){
            }

            else if(state is DashboardDeleted){
              context.read<DashboardCubit>().fetchData();
            }
            ///Error state
            else {
              SnackBar(
                backgroundColor: Colors.black,
                content: Text('Some error occurred',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),);
            }
            // TODO: implement listener
          },
          child: Column(
            children: [
              ///Heading
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Text(
                      'Registered cars are:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              ///List of registered cars
              Expanded(
                flex: 10,
                child: BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                    if(state is DashboardLoading){
                      return const Center(child: CircularProgressIndicator());
                    }
                    else if(state is DashboardLoaded){
                      ///If state is loaded but there is no car in the db
                      return state.model.isEmpty ?  Center(
                        child: Text('No Car Registered Yet',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),):
                          ///when we have registered cars in db
                      ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.model.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ///custom card for showing car details
                          return CarDetailCard(model: state.model[index],);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                      );

                    }
                    else if(state is DashboardUpdate){
                      ///when entry is updated
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.model.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CarDetailCard(model: state.model[index],);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                      );
                    }
                    else{
                      ///when error occurs
                      return const Center(child: Text('Something Went wrong'),);
                    }
                  },
                ),
              ),
            ],
          )
      ),

      ///floating action button for adding new entry
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                ///dialog box for adding car details
                return const AddNewEntryDialog();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
