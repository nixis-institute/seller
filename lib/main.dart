import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/product_repository.dart';
import 'package:shopping_junction_seller/BLOC/products_bloc/products_bloc.dart';
import 'package:shopping_junction_seller/BLOC/subproducts_bloc/subproduct_bloc.dart';
import 'package:shopping_junction_seller/BLOC/subproducts_bloc/subproduct_repository.dart';
import 'package:shopping_junction_seller/Graphql/services.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/ImageUploadScreen.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/createProduct.dart';
import 'package:shopping_junction_seller/screens/ProductScreens/productList.dart';
import 'package:shopping_junction_seller/screens/home.dart';
// import 'package:shopping_junction_seller/screens/login.dart';

// import 'BLOC/Bloc/Authentication_bloc.dart';
// import 'BLOC/event/Authentication_event.dart';
// import 'BLOC/repository/UserRepository.dart';
// import 'BLOC/state/Authentication_state.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() 
{
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  // final userRepository = UserRepository();
  ProductRepository productRepository = ProductRepository();
  SubProductRepository subProductRepository = SubProductRepository();
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    
  
    // MyApp()
      MultiBlocProvider(
        providers: [
          BlocProvider<ProductsBloc>(
            create: (context) => ProductsBloc(productRepository),
          ),
          BlocProvider<SubproductBloc>(
            create: (context) => SubproductBloc(repository: subProductRepository),
          )
        ],
        child: MyApp(productRepository:productRepository,subProductRepository:subProductRepository),
      )
    
  );
}

class MyApp extends StatelessWidget{
  final ProductRepository productRepository;
  final SubProductRepository subProductRepository;
  
  MyApp({Key key, @required this.productRepository,this.subProductRepository})
      : assert(productRepository != null,subProductRepository!=null),
        super(key: key);
  
  @override
  Widget build(BuildContext context){
    return BlocBuilder<ProductsBloc,ProductsState>(
      builder: (context,state){
        return MaterialApp(
          title: 'Shopping Junction Seller',
          theme: ThemeData(
            primaryColor: Colors.teal
          ),
          
          routes: <String,WidgetBuilder>{
            '/home':(BuildContext context) => new HomeScreen(),
            '/productList':(BuildContext context) => new ProductScreen(),
            '/image':(BuildContext context) => new ImageScreen(),
          },

        home: BlocProvider(
          create: (context)=>ProductsBloc(
            productRepository
          ),
          child: HomeScreen(),
        ),

        );
      },
    );
  }
}

// class MyApp extends StatelessWidget {


// //  App({Key key, @required this.weatherRepository})
// //       : assert(weatherRepository != null),
// //         super(key: key);

//   final ProductRepository productRepository;
//   final SubProductRepository subProductRepository;

//   MyApp({Key key, @required this.productRepository,this.subProductRepository}) :assert(productRepository!=null,subProductRepository!=null),
//   super(key: key) ;
//   // This widget is the root of your application.
//   // final UserRepository userRepository;
//   // MyApp()
//   // ProductsBloc _productsBloc = ProductsBloc(productRepository);
//   @override
//   Widget build(BuildContext context) {
//     print(subProductRepository);
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider<ProductsBloc>(
//             create: (context) => ProductsBloc(productRepository),
//           ),
//           BlocProvider<SubproductBloc>(
//             create: (context) => SubproductBloc(repository: subProductRepository),
//           )
//         ],
//         // create: (context)=>ProductsBloc(productRepository),
        
        
//         child: 
        
        
//         MaterialApp(
//         title: 'Shopping Junction Seller',
//         theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // Try running your application with "flutter run". You'll see the
//           // application has a blue toolbar. Then, without quitting the app, try
//           // changing the primarySwatch below to Colors.green and then invoke
//           // "hot reload" (press "r" in the console where you ran "flutter run",
//           // or simply save your changes to "hot reload" in a Flutter IDE).
//           // Notice that the counter didn't reset back to zero; the application
//           // is not restarted.
//           primarySwatch: Colors.teal,
//         ),
//         routes: <String,WidgetBuilder>{
//           '/home':(BuildContext context) => new HomeScreen(),
//           '/productList':(BuildContext context) => new ProductScreen(),
//           '/image':(BuildContext context) => new ImageScreen(),
//           // '/createProduct':(BuildContext context) => new CreateProductScreen(),
//           // '/subProduct':(BuildContext context) => new HomeScreen(),
//           // '/subProduct':(BuildContext context) => new HomeScreen(),

//         },
//         home: HomeScreen(),
        
//         // home: MyHomePage(title: 'Flutter Demo Home Page'),

        
//         // home:BlocBuilder<AuthenticationBloc, AuthenticationState>(
//         //   builder:(context,state){
//         //     if(state is AuthenticationUnauthenticated){
//         //       return LoginScreen(userRepository: userRepository);
//         //     }
//         //     if(state is AuthenticationAuthenticated){
//         //       return HomeScreen();
//         //     }
//         //     if(state is AuthenticationUninitialized){
//         //       return HomeScreen();
//         //     }
//         //     if(state is AuthenticationLoading){
//         //       return HomeScreen();
//         //     }
//         //   }
//         // )

//         // home: GraphQLProvider(
//         //   client: client,
//         //   child: CacheProvider(
//         //     child: LoginScreen(userRepository: null,)
//         //     ),
//         // ),


//       ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
