// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_manage/Screens/update.dart';
import 'package:state_manage/bloc/profile_bloc.dart';

class AllUserScreen extends StatefulWidget {
  static const routeName = '/alluser';
  AllUserScreen({Key? key}) : super(key: key);

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileFinish) {
          return Scaffold(
            appBar: AppBar(
              title: Text('All Personal Information'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Text('Back to add user'),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
                  ),
                  ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.profiles!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          trailing: Wrap(
                            spacing: -10,
                            children: [
                              IconButton(
                                color: Colors.blue,
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/update',
                                      arguments: UpdateArguments(
                                          index, state.profiles![index]));
                                },
                              ),
                              IconButton(
                                color: Colors.red,
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(DeleteProfileEvant(index));
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('${state.profiles![index].name}'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'name: ${state.profiles![index].name}'),
                                        Text(
                                            'surname ${state.profiles![index].surname}'),
                                        Text(
                                            'age ${state.profiles![index].age}'),
                                        Text(
                                            'address ${state.profiles![index].address}'),
                                        Text(
                                            'portcode ${state.profiles![index].portcode}'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          leading: const Icon(Icons.account_box),
                          title: Text('${state.profiles![index].name}'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
