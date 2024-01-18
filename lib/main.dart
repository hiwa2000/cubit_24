// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Event
// abstract class CounterEvent {}

// class IncrementEvent extends CounterEvent {}

// class DecrementEvent extends CounterEvent {}

// // State
// class CounterState {
//   final int count;

//   CounterState(this.count);
// }

// // Cubit
// class CounterCubit extends Cubit<CounterState> {
//   CounterCubit() : super(CounterState(0));

//   void increment() => emit(CounterState(state.count + 1));

//   void decrement() => emit(CounterState(state.count - 1));
// }

// // UI
// class CounterScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Counter with Cubit'),
//       ),
//       body: BlocProvider(
//         create: (context) => CounterCubit(),
//         child: CounterWidget(),
//       ),
//     );
//   }
// }

// class CounterWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final CounterCubit counterCubit = BlocProvider.of<CounterCubit>(context);

//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           BlocBuilder<CounterCubit, CounterState>(
//             builder: (context, state) {
//               return Text(
//                 'Count: ${state.count}',
//                 style: TextStyle(fontSize: 24),
//               );
//             },
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () => counterCubit.increment(),
//                 child: Icon(Icons.add),
//               ),
//               ElevatedButton(
//                 onPressed: () => counterCubit.decrement(),
//                 child: Icon(Icons.remove),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: CounterScreen(),
//   ));
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Definieren des States
enum AuthStatus { authenticated, unauthenticated }

// Definieren des Cubit
class AuthCubit extends Cubit<AuthStatus> {
  AuthCubit() : super(AuthStatus.unauthenticated);

  void logIn() {
    // Hier würde die eigentliche Anmelde-Logik stehen
    emit(AuthStatus.authenticated);
  }

  void logOut() {
    // Hier würde die Abmelde-Logik stehen
    emit(AuthStatus.unauthenticated);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AuthCubit(), // Bereitstellen des AuthCubit
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AuthCubit '),
      ),
      body: Center(
        child: BlocBuilder<AuthCubit, AuthStatus>(
          builder: (context, state) {
            if (state == AuthStatus.authenticated) {
              return Text('Benutzer ist angemeldet');
            } else {
              return Text('Benutzer ist nicht angemeldet');
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logIn(); // Benutzer anmelden
            },
            tooltip: 'Anmelden',
            child: Icon(Icons.login),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logOut(); // Benutzer abmelden
            },
            tooltip: 'Abmelden',
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}