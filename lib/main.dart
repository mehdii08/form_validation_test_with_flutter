import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinokio_flutter/HomeBloc.dart';
import 'package:pinokio_flutter/HomeEvent.dart';
import 'package:pinokio_flutter/HomeState.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinokio Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.isLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Submitting...')),
              );
          }
          if (state.isSubmitted) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showDialog<void>(
              context: context,
              builder: (_) => const SuccessDialog(),
            );
          }
        },
        child: HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage("images/doodle.png"))),
            ),
            Align(
              alignment: const Alignment(1, 1),
              child: GestureDetector(
                onTap: () => print('contact-us'),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                  child: Text("تماس با ما"),
                ),
              ),
            ),
            const Align(
              alignment: Alignment(-1, 1),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Text("v0.1"),
              ),
            ),
            Center(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              color: Color.fromRGBO(255, 255, 255, 0.6),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "کد میز را وارد کنید",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 10),
                                  child: BlocBuilder<HomeBloc, HomeState>(
                                    // buildWhen: (prev,current)=>prev != current,
                                    builder: (context, state) {
                                      return TextField(
                                        controller: myController,
                                        autofocus: false,
                                        onChanged: (content) => context
                                            .read<HomeBloc>()
                                            .add(CodeChanged(code: content)),
                                        style: const TextStyle(
                                            fontSize: 22.0,
                                            color: Colors.black87),
                                        decoration: InputDecoration(
                                          errorText: state.showErrorMessage()
                                              ? "کد میز باید ۵ رقمی باشد"
                                              : null,
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: '123456',
                                          hintStyle: const TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.black45),
                                          contentPadding: const EdgeInsets.only(
                                              left: 14.0, bottom: 8.0, top: 8.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => context.read<HomeBloc>().add(
                                      FormSubmitted(code: myController.text)),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    margin: const EdgeInsets.all(20),
                                    child: const Center(
                                        child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Text("ورود"))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: const <Widget>[
                Icon(Icons.info),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
