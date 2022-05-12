// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_manage/bloc/profile_bloc.dart';
import 'package:state_manage/models/profile.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentStep = 0;
  final GlobalKey<FormState> _formKeyFrist = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeySeconde = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController portcode = TextEditingController();
  Profile profile = Profile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: getStep(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getStep().length - 1;
          if (isLastStep) {
            profile.name = name.text;
            profile.surname = surname.text;
            profile.age = age.text;
            profile.address = address.text;
            profile.portcode = portcode.text;
            _formKeyFrist.currentState!.reset();
            _formKeySeconde.currentState!.reset();
            name.clear();
            surname.clear();
            age.clear();
            address.clear();
            portcode.clear();
            BlocProvider.of<ProfileBloc>(context).add(AddProfileEvent(profile));
            Navigator.pushReplacementNamed(context, '/alluser');
          } else if (currentStep == 1 &&
              _formKeySeconde.currentState!.validate()) {
            setState(() => currentStep += 1);
          } else if (currentStep == 0 &&
              _formKeyFrist.currentState!.validate()) {
            setState(() => currentStep += 1);
          }
        },
        onStepCancel: () =>
            currentStep == 0 ? null : setState(() => currentStep -= 1),
      ),
    );
  }

  List<Step> getStep() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Account'),
          content: Form(
            key: _formKeyFrist,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Name'),
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Surname'),
                  controller: surname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter surname';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Age'),
                  controller: age,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter age';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Address'),
          content: Form(
            key: _formKeySeconde,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Address'),
                  controller: address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Portcode'),
                  controller: portcode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter portcode';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text('Complate'),
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 60, child: Text(name.text)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      'Surname',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 60, child: Text(surname.text)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      'Age',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 60, child: Text(age.text)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      'Address',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 60, child: Text(address.text)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      'Portcode',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(width: 60, child: Text(portcode.text)),
                ],
              ),
            ],
          ),
        ),
      ];
}
