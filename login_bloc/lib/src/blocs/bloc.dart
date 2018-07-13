import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
  //Private fields
  /*final _emailController = StreamController<
      String>.broadcast(); //Since we will only be dealing with string data
  final _passwordController = StreamController<
      String>.broadcast(); //A StreamController by default makes a "Single-subscription" stream.
  */

  final _emailController = BehaviorSubject<
      String>(); //RxDart's implementation of StreamController. Broadcast stream by default
  final _passwordController = BehaviorSubject<String>();

  //Retreive data from the stream
  Stream<String> get email => _emailController.stream
      .transform(validateEmail); //Return the transformed stream
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  //Merging email and password streams
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  //Add data to the stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print('Email is $validEmail');
    print('Password is $validPassword');
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

//Single Global Instance of Bloc
//final bloc = Bloc();