import 'dart:io';

import 'package:flutter/material.dart';

import '../../helpers/auth_form_validator_helper.dart';
import '../../widgets/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext context,
  ) submitFn;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';
  File _userImage;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImage == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();

      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImage,
        _isLogin,
        context,
      );
    }
  }

  void _pickedImage(File pickedImage) {
    _userImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!_isLogin) UserImagePicker(_pickedImage),
                    TextFormField(
                      key: ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) => AuthFormValidatorHelper.validateEmail(value),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'E-mail address'),
                      onSaved: (newValue) => _userEmail = newValue,
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: false,
                        validator: (value) => AuthFormValidatorHelper.validateUsername(value),
                        decoration: InputDecoration(labelText: 'Username'),
                        onSaved: (newValue) => _userName = newValue,
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) => AuthFormValidatorHelper.validatePassword(value),
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (newValue) => _userPassword = newValue,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                        onPressed: () => _trySubmit(),
                      ),
                    if (!widget.isLoading)
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(_isLogin ? 'Create new account' : 'I already have an account'),
                        onPressed: () => setState(() {
                          _isLogin = !_isLogin;
                        }),
                      ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
