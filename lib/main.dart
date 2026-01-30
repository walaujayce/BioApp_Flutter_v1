import 'package:bio_app/components/capture_image_fab.dart';
import 'package:bio_app/views/home_page.dart';
import 'package:bio_app/views/introduction_page.dart';
import 'package:bio_app/views/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/bottom_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  if (kDebugMode) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uploaded_species_list'); //TODO 這裏是爲了清楚暫存區
    // 或 prefs.clear(); ⚠️ 會清全部
  }

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '中油生態地圖',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        textTheme: GoogleFonts.notoSansTcTextTheme(Theme.of(context).textTheme),
      ),
      home: const MyHomePage(),
      // home: IntroductionPage(),
      // home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 標題
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text("中油生態地圖",style: TextStyle(color: Colors.white),),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            onSelected: (val) async {
              if (val == 0) {
                // Logout
                // userState.logout();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
              } else if (val == 1) {
                // Delete Account
                final result = await showDialog<bool>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('您確定要刪除帳號嗎？'),
                    content: const Text('您的帳號及資料將永久從平台中刪除\n並且無法復原！'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('取消'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('刪除'),
                      ),
                    ],
                  ),
                );

                if (result != null && result == true) {
                  // userState.deleteAccount().then((_) {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text("帳號已刪除"),
                  //   ));
                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (context) => LoginPage(),
                  //   ));
                  // }).catchError((err) {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     content: Text("刪除失敗：${err.toString()}"),
                  //   ));
                  // });
                }
              } else if (val == 2) {
                // Toggle user image
                // final prefs = await SharedPreferences.getInstance();
                // prefs.setBool("show-image", !showImage);
                // print(!showImage);
                // ref.read(showImageOptionProvier.state).state = !showImage;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 0, child: Text("登出")),
                PopupMenuItem(value: 1, child: Text("刪除帳號")),
                // CheckedPopupMenuItem(
                //   // checked: showImage,
                //   checked: true,
                //   value: 2,
                //   child: Text('顯示使用者圖片'),
                // ),
              ];
            },
          ),
        ],
      ),
      // 主頁面
      body: HomePage(),
      // 浮動按鈕（拍攝照片）
      floatingActionButton: CaptureImageFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // 底部導航
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
