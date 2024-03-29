import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:tada/components/methods/methods.dart';
import 'package:tada/components/variables/components.dart';
import 'package:tada/state_managment/theme/theme_bloc.dart';
import 'package:vibration/vibration.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //default value of theme
  bool valueTheme = false;
  //to signout
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state){
            if(state is CurrentThemeState){
              return buildSettings(context);
            }
            if(state is ThemeInitial){
              return buildSettings(context);
            }
            return buildSettings(context);
          },
        ),
      ),
    );
  }

  Column buildSettings(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                customListTile( Text('Theme'),  Switch(
                  value: valueTheme,
                  onChanged: (value) {
                    setState(() {
                      Vibration.vibrate(duration: 90);
                      valueTheme = value; // Update the valueTheme variable correctly
                      context.read<ThemeBloc>().add(ChangeThemeEvent(themeValue: value));
                    });
                  },
                ),),
                customListTile(Text('Support',), IconButton(icon: Icon(Icons.call), onPressed: (){Vibration.vibrate(duration: 90);})),
                customListTile(Text('Delete your account',style: TextStyle(color: Colors.red),), IconButton(icon: Icon(Icons.delete_sweep_sharp), onPressed: (){Vibration.vibrate(duration: 90);})),
                customListTile(Text('Signout', style: TextStyle(color: Colors.red),), IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
                  setState(() {
                    Vibration.vibrate(duration: 90);
                    showDialog( barrierDismissible: false,context: context, builder: (context){
                      return Dialog(
                        elevation: 100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(height: 100,width: 100,child: RiveAnimation.asset('asset/riv/rocket_animation.riv'),),
                            Text('Did you wanna sign out? '),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                                    onPressed: (){
                                      firebaseAuth.signOut();
                                      replaceScreenNamed(context, '/SignInPage');
                                      Vibration.vibrate(duration: 90);
                                    }, child: Text('yes', style: TextStyle(color: Colors.white))),
                                SizedBox(width: 30,),
                                TextButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                  onPressed: (){
                                    Navigator.pop(context);
                                    Vibration.vibrate(duration: 90);
                                  }, child: Text('cancel', style: TextStyle(color: Colors.white),),),
                              ],
                            ),
                            SizedBox(height: 5,)
                          ],
                        )
                      );
                    });

                  });
                })),

              ],
            );
  }
}
