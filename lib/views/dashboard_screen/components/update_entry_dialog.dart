import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ropstom_task/cubits/category_cubit.dart';
import 'package:ropstom_task/views/custom_widgets/my_text_field.dart';

import '../../../cubits/dashboard_cubit/dashboard_cubit.dart';
import '../../../data/models/dashboard_model/dashboard_model.dart';
import '../../custom_widgets/custom_button.dart';

class UpdateEntryDailog extends StatefulWidget {
  final DashboardModel model;

  const UpdateEntryDailog({Key? key, required this.model}) : super(key: key);

  @override
  State<UpdateEntryDailog> createState() => _UpdateEntryDailogState();
}

class _UpdateEntryDailogState extends State<UpdateEntryDailog> {
  ///text controllers, variables and initializing cubits
  TextEditingController carNameController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController carColorController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late CarCategoryCubit carCategoryCubit;
  @override
  ///init function to get call those cubits and function
  ///which i want to be called before build fucntion
  void initState() {
    ///
    carCategoryCubit = context.read<CarCategoryCubit>();
    carNameController.text = widget.model.carName;
    carModelController.text = widget.model.carModel;
    carColorController.text = widget.model.carColor;
    ownerNameController.text = widget.model.ownerName;
    carCategoryCubit.selectCategory(carCategoryCubit.category=='Toyota'?
    'Toyota':carCategoryCubit.category);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///dialog
    return Dialog(
      child: SizedBox(
        height: 450.h,
        width: 1.sw,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            shrinkWrap: true,
            children: [
              Text('Edit Car Details',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              ///category dropdown button
              BlocBuilder<CarCategoryCubit, String>(
                builder: (context, state) {
                  return ButtonTheme(
                    alignedDropdown: true,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        isExpanded: true,
                        value: carCategoryCubit.category,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: [
                          'Toyota',
                          'Honda',
                          'Suzuki',
                        ].map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (newValue) {

                          carCategoryCubit.selectCategory(newValue!);
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10.sp,
              ),

              ///model field
              MyTextField(
                controller: carModelController, hintText: 'Enter new model',
                validate: (validator) {
                  if (validator!.isEmpty) {
                    return 'Empty';
                  }
                  return null;
                },),

              SizedBox(
                height: 10.sp,
              ),

              ///color field
              MyTextField(
                controller: carColorController, hintText: 'Enter new Color',
                validate: (validator) {
                  if (validator!.isEmpty) {
                    return 'Empty';
                  }
                  return null;
                },),

              SizedBox(
                height: 10.sp,
              ),


              ///owner name field
              MyTextField(controller: ownerNameController,
                hintText: 'Enter new owner name',
                validate: (validator) {
                  if (validator!.isEmpty) {
                    return 'Empty';
                  }
                  return null;
                },),

              SizedBox(
                height: 30.sp,
              ),

              ///update custom button to update data in db
              ///on basis for specific id
              BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardLoading) {
                      return SizedBox(
                        height: 40.sp,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return CustomButton(
                          text: 'Update',
                          onPress: () async {
                            ///fields validation
                            if (_formKey.currentState!.validate()) {
                              DashboardModel model = DashboardModel(
                                  id: widget.model.id,
                                  carName: carCategoryCubit.category,
                                  carModel: carModelController.text
                                      .trim(),
                                  carColor: carColorController.text
                                      .trim(),
                                  ownerName:
                                  ownerNameController.text.trim());
                              await context
                                  .read<DashboardCubit>()
                                  .updateRecord(model: model);
                              ///closing dialog
                              Navigator.of(context).pop();
                            }
                          }


                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
