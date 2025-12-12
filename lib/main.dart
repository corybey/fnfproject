import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Providers
import 'package:provider/provider.dart';

// Repositories
import 'data/repositories/auth_repository.dart';
import 'data/repositories/room_repository.dart';
import 'data/repositories/group_repository.dart';
import 'data/repositories/chat_repository.dart';
import 'data/repositories/schedule_repository.dart';
import 'data/repositories/timer_repository.dart';

// Controllers
import 'controllers/auth_controller.dart';
import 'controllers/study_room_controller.dart';
import 'controllers/group_controller.dart';
import 'controllers/chat_controller.dart';
import 'controllers/schedule_controller.dart';
import 'controllers/timer_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const FNFApp());
}

class FNFApp extends StatelessWidget {
  const FNFApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ------------------------
        // REPOSITORIES
        // ------------------------
        Provider<AuthRepository>(create: (_) => AuthRepository()),
        Provider<RoomRepository>(create: (_) => RoomRepository()),
        Provider<GroupRepository>(create: (_) => GroupRepository()),
        Provider<ChatRepository>(create: (_) => ChatRepository()),
        Provider<ScheduleRepository>(create: (_) => ScheduleRepository()),
        Provider<TimerRepository>(create: (_) => TimerRepository()),

        // CONTROLLERS
        // AUTH CONTROLLER
        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(
            context.read<AuthRepository>(),
          )..loadCurrentUser(),
        ),

        // ROOM CONTROLLER
        ChangeNotifierProvider<StudyRoomController>(
          create: (context) => StudyRoomController(
            context.read<RoomRepository>(),
          ),
        ),

        // GROUP CONTROLLER
        ChangeNotifierProvider<GroupController>(
          create: (context) => GroupController(
            context.read<GroupRepository>(),
            context.read<AuthController>().currentUser?.uid ?? "",
          ),
        ),

        // NOTE: Chat, Schedule, Timer controllers require groupId
        // These will be initialized inside the group screen later.
      ],
      child: MaterialApp(
        title: "FocusNFlow",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        home: const -------, // replace with Landing or Auth screen
      ),
    );
  }
}
