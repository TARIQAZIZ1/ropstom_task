import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ropstom_task/views/custom_widgets/my_text_field.dart';

import '../../../cubits/category_cubit.dart';
import '../../../cubits/dashboard_cubit/dashboard_cubit.dart';
import '../../../data/models/dashboard_model/dashboard_model.dart';
import '../../custom_widgets/custom_button.dart';

class AddNewEntryDialog extends StatefulWidget {
  const AddNewEntryDialog({Key? key}) : super(key: key);

  @override
  State<AddNewEntryDialog> createState() => _AddNewEntryDialogState();
}

class _AddNewEntryDialogState extends State<AddNewEntryDialog> {
  ///text controllers
  TextEditingController carNameController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController carColorController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late CarCategoryCubit carCategoryCubit;

  @override
  ///init function for loading data before building trere
  void initState() {
    ///initializing cubit and calling cubit for dropdown
    carCategoryCubit = context.read<CarCategoryCubit>();
    carCategoryCubit.selectCategory('Toyota');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 450.h,
        width: 0.9.sw,

        ///form for taking data in fields and validating it
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            shrinkWrap: true,
            children: [
              Text('Enter Car Data',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              ///drop down button for categories
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

              ///model custom text field
              MyTextField(
                controller: carModelController, hintText: 'Enter car model',
                validate: (validator) {
                  if (validator!.isEmpty) {
                    return 'Empty';
                  }
                  return null;
                },
              ),

              SizedBox(
                height: 10.sp,
              ),

              ///color custom textfield
              MyTextField(
                controller: carColorController, hintText: 'Enter Color',
                validate: (validator) {
                  if (validator!.isEmpty) {
                    return 'Empty';
                  }
                  return null;
                },
              ),

              SizedBox(
                height: 10.sp,
              ),

              ///owner custom name text field
              MyTextField(
                controller: ownerNameController, hintText: 'Enter owner name',
                validate: (validator) {
                  if (validator!.isEmpty) {
                    return 'Empty';
                  }
                  return null;
                },
              ),

              SizedBox(
                height: 30.sp,
              ),

              ///submit custom button for adding entry to db
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
                          text: 'Submit Button',
                          onPress: () async {
                            ///validating form
                            if (_formKey.currentState!.validate()) {
                              DashboardModel model = DashboardModel(
                                  carName: carCategoryCubit.category,
                                  carModel: carModelController.text
                                      .trim(),
                                  carColor: carColorController.text
                                      .trim(),
                                  ownerName:
                                  ownerNameController.text.trim());
                              await context
                                  .read<DashboardCubit>()
                                  .addNewEntry(model: model);
                              carNameController.clear();
                              carModelController.clear();
                              carColorController.clear();
                              ownerNameController.clear();
                              ///closing dialog box
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
