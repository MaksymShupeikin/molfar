import 'package:molfar/core/imports.dart';
import 'package:molfar/presentation/pages/home_page.dart';

void main() {
  runApp(ProviderScope(child: const MolfarApp()));
}

class MolfarApp extends StatelessWidget {
  const MolfarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}
