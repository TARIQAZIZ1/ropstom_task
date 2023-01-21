import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ropstom_task/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:ropstom_task/data/models/dashboard_model/dashboard_model.dart';
import 'package:ropstom_task/views/dashboard_screen/components/update_entry_dialog.dart';

class CarDetailCard extends StatelessWidget {
  final DashboardModel model;
  const CarDetailCard({Key? key, required this.model,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///custom card for showing car data
    return Container(
      height: 90.h,
      width: 1.sw,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: .1.sp,
            blurRadius: 1.sp,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                ///car category
                Text(
                  'Car Name: ${model.carName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
                ///car model
                Text(
                  'Car Model: ${model.carModel}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),

                ///car color
                Text(
                  'Car Color: ${model.carColor}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),

                Row(
                  children: [
                    ///delete Icon
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: (){
                            ///dialog box to confirm deletion
                            showDialog(context: context, builder: (context){

                              return AlertDialog(
                                title: Text('Confirmation!!!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                content: Text('Are you sure to delete "${model.carName}" entry',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No'),),
                                  ElevatedButton(
                                    onPressed: (){
                                      context.read<DashboardCubit>().deleteRecord(id: model.id!);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Yes'),),
                                ],
                              );
                            });

                          } ,
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ),
                    ///edit dialog box
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: (){
                          showDialog(context: context, builder: (context){
                            ///edit custom dialog box for editing data
                            return UpdateEntryDailog(model: model,);
                          }
                          );
                          } ,
                          icon: const Icon(Icons.edit, ),
                          label: const Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                child: Text('Edit'),
                              ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [

                   Expanded(
                     child: Align(
                       alignment: Alignment.center,
                       child: Text(
                         'Owner Details',
                         style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.w600,
                           fontSize: 15.sp,
                         ),
                       ),
                     ),
                   ),

                Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 50.sp,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Owner Name: ${model.ownerName}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
