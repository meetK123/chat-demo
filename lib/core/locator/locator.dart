import 'package:chat_demo/core/routes/app_router.dart';
import 'package:get_it/get_it.dart';

 GetIt  getIt = GetIt.instance;

  setupLocator ()  async {

  getIt.registerSingleton(AppRouter());

  //getIt.registerLazySingleton(() => AuthRepository(firebaseAuth: FirebaseAuth.instance, fireStore: FirebaseFirestore.instance));

}