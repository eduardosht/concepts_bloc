import 'package:bloc_pattern/screens/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/widgets/custom_icon_button.dart';
import 'package:bloc_pattern/widgets/custom_text_field.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: loginBloc.output,
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            body: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(32),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CustomTextField(
                          hint: 'E-mail',
                          prefix: Icon(Icons.account_circle),
                          textInputType: TextInputType.emailAddress,
                          onChanged: loginBloc.setEmail,
                          enabled: !loginBloc.isEmailValid,
                        ),
                        const SizedBox(height: 16,),
                        CustomTextField(
                          hint: 'Senha',
                          prefix: Icon(Icons.lock),
                          obscure: loginBloc.passwordVisible,
                          onChanged: loginBloc.setPassword,
                          enabled: !loginBloc.loading,
                          suffix: CustomIconButton(
                            radius: 32,
                            iconData: Icons.visibility,
                            onTap: loginBloc.togglePasswordVisibility,
                          ),
                        ),
                        const SizedBox(height: 16,),
                        SizedBox(
                          height: 44,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: loginBloc.loading ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ) : Text('Login'),
                              color: Theme.of(context).primaryColor,
                              disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                              textColor: Colors.white,
                              onPressed: loginBloc.loginPressed
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ),
        );
      }
    );
  }
}
