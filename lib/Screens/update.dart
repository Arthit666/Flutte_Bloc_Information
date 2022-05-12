// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_manage/bloc/profile_bloc.dart';
import 'package:state_manage/models/profile.dart';

class UpdateArguments {
  final int _id;
  final Profile _profile;

  UpdateArguments(this._id, this._profile);
}

class UpdateScreen extends StatefulWidget {
  static const routeName = '/update';
  UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UpdateArguments;
    TextEditingController name =
        TextEditingController(text: args._profile.name);
    TextEditingController surname =
        TextEditingController(text: args._profile.surname);
    TextEditingController age = TextEditingController(text: args._profile.age);
    TextEditingController address =
        TextEditingController(text: args._profile.address);
    TextEditingController portcode =
        TextEditingController(text: args._profile.portcode);

    return Scaffold(
      appBar: AppBar(title: Text('Edit User')),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name', style: TextStyle(fontSize: 18)),
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
                  Text('Surname', style: TextStyle(fontSize: 18)),
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
                  Text('Age', style: TextStyle(fontSize: 18)),
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
                  SizedBox(
                    height: 10,
                  ),
                  Text('Address', style: TextStyle(fontSize: 18)),
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
                  Text('Portcode', style: TextStyle(fontSize: 18)),
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
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          profile.name = name.text;
                          profile.surname = surname.text;
                          profile.age = age.text;
                          profile.address = address.text;
                          profile.portcode = portcode.text;
                          _formKey.currentState!.reset();
                          name.clear();
                          surname.clear();
                          age.clear();
                          address.clear();
                          portcode.clear();
                          // print(args._id);
                          BlocProvider.of<ProfileBloc>(context)
                              .add(UpdateProfileEvant(args._id, profile));
                          Navigator.pop(context);
                        }
                        // Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
