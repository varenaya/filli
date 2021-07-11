import 'package:bloc/bloc.dart';
import 'package:filli/Screens/DmScreen.dart';
import 'package:filli/Screens/HomeScreen/HomeScreen.dart';
import 'package:filli/Screens/ProfileScreen.dart';

enum NavigationEvents {
  HomeScreenClickedEvent,
  ProfileScreenClickedEvent,
  DmScreenClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(NavigationStates initialState) : super(initialState);

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomeScreenClickedEvent:
        yield HomeScreen();
        break;
      case NavigationEvents.ProfileScreenClickedEvent:
        yield ProfileScreen();
        break;
      case NavigationEvents.DmScreenClickedEvent:
        yield DmScreen();
        break;
    }
  }
}
