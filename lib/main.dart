import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_producer/environment.dart';
import 'package:mobile_producer/models/product/product_model.dart';
import 'package:mobile_producer/screens/login/login_screen.dart';
import 'package:mobile_producer/screens/nav_pages/my_store/bloc/my_store_bloc.dart';
import 'package:mobile_producer/screens/nav_pages/my_store/my_store_screen.dart';
import 'package:mobile_producer/screens/nav_pages/main_nav_page.dart';
import 'package:mobile_producer/screens/order_details_screen/order_details_screen.dart';
import 'package:mobile_producer/screens/product_screen/product_screen.dart';
import 'package:mobile_producer/screens/update_product_picture/update_product_picture_screen.dart';
import 'package:mobile_producer/screens/update_product_screen/bloc/update_product_bloc.dart';
import 'package:mobile_producer/services/product_service.dart';
import 'package:mobile_producer/shared/blocs/product_bloc/product_bloc.dart';
import 'package:mobile_producer/shared/repositories/geolocation/geolocation_repository.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ProductService(),
        ),
        RepositoryProvider(
          create: (context) => GeolocationRepository(),
        ),
        BlocProvider(create: (context) => ProductBloc(productService: RepositoryProvider.of<ProductService>(context))),
        BlocProvider(create: (context) => UpdateProductBloc(productService: RepositoryProvider.of<ProductService>(context))),
        BlocProvider(create: (context) => MyStoreBloc(productService: RepositoryProvider.of<ProductService>(context)))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => LoginScreen(),
          "/home": (context) => NavigationPage(),
          "/myStore": (context) => MyStoreScreen(),
          "/orderDetails": (context) => const OrderDetailsScreen(),
          "/updatePictures":(context) => const UpdateProductPictureScreen(),
        },
        onGenerateRoute: (settings){
          if(settings.name == "/product"){
            return MaterialPageRoute(builder: (context) => ProductScreen());
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${Environment.apiUrl}You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
