import 'package:calc1/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:hold_down_button/hold_down_button.dart';
import 'nav-drawer.dart';
import 'package:quickalert/quickalert.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController varController;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    varController = TextEditingController();
  }

  @override
  void dispose() {
    varController.dispose();

    super.dispose();
  }

  var inputString = '';
  var outputString = '0';
  var lastOutput = '0';
  var functionName = '';

  final List<String> funNames = [
    'fun1',
    'fun2',
    'fun3',
    'fun4',
    'fun5',
    'fun6',
    'fun7',
  ];

  final List<String> funFormulas = [
    'X x Y',
    'V^2',
    'sqrt(W)',
    'V',
    'Z',
    'V+W+X+Y+Z',
    'cos(X)',
  ];

  final List<List<double?>> funVars = [
    [null, null, null, null, null], //Fun1 V, W, X, Y, Z
    [null, null, null, null, null],
    [null, null, null, null, null],
    [null, null, null, null, null],
    [null, null, null, null, null],
    [null, null, null, null, null],
    [null, null, null, null, null],
  ];

  final List<double> varIndex = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
  ];

  final List<String> buttonsIndex = [
    'LOG',
    '\u03C0', //PI
    '\u2191', //UP
    'FUNC',

    'CLR',
    'LN',
    '\u2190', //LEFT
    '\u2193', //DOWN
    '\u2192', //RIGHT

    'DEL',
    'SIN',
    'E',
    '(',
    ')',
    '\u00F7',
    'COS',
    '7',
    '8',
    '9',
    'x',
    'TAN',
    '4',
    '5',
    '6',
    '-',
    'SQRT',
    '1',
    '2',
    '3',
    '+',
    '^',
    '0',
    '.',
    'ANS',
    '=',

    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'REAL GOOD CALC',
        ),
        backgroundColor: Colors.amber,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text(funNames[0]),
              trailing: const Text('FUNCTION 1'),
              subtitle: Text(funFormulas[0]),
              onTap: () async {
                await functionInput(context, 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text(funNames[1]),
              trailing: const Text('FUNCTION 2'),
              subtitle: Text(funFormulas[1]),
              onTap: () async {
                await functionInput(context, 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text(funNames[2]),
              trailing: const Text('FUNCTION 3'),
              subtitle: Text(funFormulas[2]),
              onTap: () async {
                await functionInput(context, 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text(funNames[3]),
              trailing: const Text('FUNCTION 4'),
              subtitle: Text(funFormulas[3]),
              onTap: () async {
                await functionInput(context, 3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text(funNames[4]),
              trailing: const Text('FUNCTION 5'),
              subtitle: Text(funFormulas[4]),
              onTap: () async {
                await functionInput(context, 4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text(funNames[5]),
              trailing: const Text('FUNCTION 6'),
              subtitle: Text(funFormulas[5]),
              onTap: () async {
                await functionInput(context, 5);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text(funNames[6]),
              trailing: const Text('FUNCTION 7'),
              subtitle: Text(funFormulas[6]),
              onTap: () async {
                await functionInput(context, 6);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      body: Column(
        children: <Widget>[
          //top Container
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //SizedBox(
                  //height: ,
                  //),
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      inputString,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerRight,
                    child: Text(
                      outputString,
                      style: TextStyle(fontSize: 60),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //bottom container
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                itemCount: buttonsIndex.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 3: //FUNC
                      {
                        return ButtonList(
                          buttonTapped: () {
                            setState(() {
                              if (!hasAnyVar(inputString)) {
                                QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.info,
                                    backgroundColor:
                                        Color.fromARGB(255, 35, 122, 191),
                                    titleColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    textColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    title: 'Store a Function',
                                    text:
                                        'Functions need at least 1 variable to be set.');
                              } else {
                                _showPopupMenu();
                              }
                            });
                          },
                          buttonOutput: buttonsIndex[index],
                          color: Color.fromARGB(255, 35, 122, 191),
                          textColor: Colors.white,
                        );
                      }

                    case 2: //arrow keys
                    case 8:
                    case 6:
                    case 7:
                      {
                        return ButtonList(
                          buttonOutput: buttonsIndex[index],
                          color: Colors.white,
                          textColor: Colors.black,
                        );
                      }

                    case 4: //CLR
                      {
                        return ButtonList(
                          buttonTapped: () {
                            setState(() {
                              inputString = "";
                            });
                          },
                          buttonOutput: buttonsIndex[index],
                          color: Color.fromARGB(255, 143, 12, 2),
                          textColor: Colors.white,
                        );
                      }
                    case 9: //DEL
                      {
                        return ButtonList(
                          buttonTapped: () {
                            setState(() {
                              if (inputString.isNotEmpty) {
                                inputString = inputString.substring(
                                    0, inputString.length - 1);
                              }
                            });
                          },
                          buttonOutput: buttonsIndex[index],
                          color: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                    case 12: // "()"
                    case 13:
                      {
                        return ButtonList(
                          buttonTapped: () {
                            setState(
                              () {
                                if (index == 12) {
                                  if (inputString.isNotEmpty) {
                                    if (!lastIsOperator(
                                        inputString[inputString.length - 1])) {
                                      inputString += 'x';
                                    }
                                  }
                                  inputString += "(";
                                } else {
                                  inputString += ")";
                                }
                              },
                            );
                          },
                          buttonOutput: buttonsIndex[index],
                          color: Colors.black,
                          textColor: Colors.white,
                        );
                      }
                    /*
                    case 14:
                    case 19:
                    case 24:
                    case 29:
                      {
                        return ButtonList(
                          buttonTapped: () {
                            setState(() {
                              inputString += buttonsIndex[index];
                            });
                          },
                        );
                      }
                      */
                    case 16:
                    case 17:
                    case 18:
                    case 21:
                    case 22:
                    case 23:
                    case 26:
                    case 27:
                    case 28:
                    case 31:
                    case 32:
                      {
                        return ButtonList(
                          buttonTapped: () {
                            setState(() {
                              inputString += buttonsIndex[index];
                            });
                          },
                          buttonOutput: buttonsIndex[index],
                          color: Colors.white,
                          textColor: Colors.black,
                        );
                      }

                    case 33:
                    case 34:
                      {
                        return ButtonList(
                          buttonTapped: () {
                            setState(() {
                              if (index == 33) {
                                if (inputString.isNotEmpty &&
                                    lastOutput
                                        .isNotEmpty) if (!lastIsOperator(
                                    inputString[inputString.length - 1])) {
                                  inputString += 'x';
                                }
                                if (lastOutput.isNotEmpty)
                                  inputString += lastOutput;
                              } else {
                                evaluationStation();
                              }
                            });
                          },
                          buttonOutput: buttonsIndex[index],
                          color: Color.fromARGB(255, 35, 122, 191),
                          textColor: Colors.white,
                        );
                      }

                    case 35:
                    case 36:
                    case 37:
                    case 38:
                    case 39:
                    case 40:
                    case 41:
                    case 42:
                    case 43:
                    case 44:
                      {
                        return ButtonList(
                          buttonHold: () async {
                            final grabVar =
                                await openDialog(buttonsIndex[index]);
                            if (grabVar == null || grabVar.isEmpty) {
                              setState(() {
                                varIndex[index - 35] = double.parse(lastOutput);
                              });
                              return;
                            }
                            setState(() {
                              varIndex[index - 35] = double.parse(grabVar);
                            });
                          },
                          buttonTapped: () {
                            setState(() {
                              if (inputString.isNotEmpty) if (!lastIsOperator(
                                  inputString[inputString.length - 1])) {
                                inputString += 'x';
                              }
                              inputString += buttonsIndex[index];
                            });
                          },
                          buttonOutput: buttonsIndex[index],
                          color: Colors.grey,
                          textColor: Colors.amber,
                        );
                      }

                    default:
                      {
                        return ButtonList(
                          buttonTapped: () {
                            setState(() {
                              inputString += buttonsIndex[index];
                            });
                          },
                          buttonOutput: buttonsIndex[index],
                          color: Color.fromARGB(255, 0, 159, 98),
                          textColor: Colors.white,
                        );
                      }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void evaluationStation() {
    lastOutput = outputString;
    String normalizedInput = inputString;

    normalizedInput = normalizedInput.replaceAll('x', '*');
    normalizedInput = normalizedInput.replaceAll('\u00f7', '/');

    for (var i = 35; i < 40; i++) {
      String vari = buttonsIndex[i];
      String numi = varIndex[i - 35].toString();
      normalizedInput = normalizedInput.replaceAll(vari, numi);
    }

    Parser p = Parser();
    if (normalizedInput.isEmpty) {
      return;
    }

    Expression exp;

    try {
      exp = p.parse(normalizedInput);
    } catch (e) {
      outputString = "ERROR";
      return;
    }
    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    outputString = eval.toString();
    lastOutput = eval.toString();
    //inputString = '';
  }

  Future<String?> openDialog(String x) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(x),
          content: TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Default: ANS'),
            controller: varController,
          ),
          actions: [TextButton(onPressed: submit, child: const Text('SUBMIT'))],
        ),
      );

  Future<void> functionInput(BuildContext context, int functionID) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _var1Controller = TextEditingController();
          final TextEditingController _var2Controller = TextEditingController();
          final TextEditingController _var3Controller = TextEditingController();
          final TextEditingController _var4Controller = TextEditingController();
          final TextEditingController _var5Controller = TextEditingController();
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: funFormulas[functionID].contains('V'),
                    child: TextFormField(
                      controller: _var1Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't Be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(hintText: "Value of V"),
                    ),
                  ),
                  Visibility(
                    visible: funFormulas[functionID].contains('W'),
                    child: TextFormField(
                      controller: _var2Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't Be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(hintText: "Value of W"),
                    ),
                  ),
                  Visibility(
                    visible: funFormulas[functionID].contains('X'),
                    child: TextFormField(
                      controller: _var3Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't Be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(hintText: "Value of X"),
                    ),
                  ),
                  Visibility(
                    visible: funFormulas[functionID].contains('Y'),
                    child: TextFormField(
                      controller: _var4Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't Be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(hintText: "Value of Y"),
                    ),
                  ),
                  Visibility(
                    visible: funFormulas[functionID].contains('Z'),
                    child: TextFormField(
                      controller: _var5Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't Be Empty";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(hintText: "Value of Z"),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        String output = funFormulas[functionID];

                        output = output.replaceAll(
                            'V', _var1Controller.text.toString());
                        output = output.replaceAll(
                            'W', _var2Controller.text.toString());
                        output = output.replaceAll(
                            'X', _var3Controller.text.toString());
                        output = output.replaceAll(
                            'Y', _var4Controller.text.toString());
                        output = output.replaceAll(
                            'Z', _var5Controller.text.toString());

                        inputString += output;
                      });

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Submit'))
            ],
          );
        });
  }

  void submit() {
    Navigator.of(context).pop(varController.text);
  }

  bool hasAnyVar(String x) {
    if (x.contains('V') ||
        x.contains('W') ||
        x.contains('X') ||
        x.contains('Y') ||
        x.contains('Z')) {
      return true;
    }
    return false;
  }

  bool lastIsOperator(String x) {
    if (x.endsWith('x') ||
        x.endsWith('+') ||
        x.endsWith('-') ||
        x.endsWith('\u00F7')) return true;

    return false;
  }

  void _showPopupMenu() async {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 0, 0, 0),
      items: [
        PopupMenuItem(
          value: 1,
          child: Text("Function 1"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Function 2"),
        ),
        PopupMenuItem(
          value: 3,
          child: Text("Function 3"),
        ),
        PopupMenuItem(
          value: 4,
          child: Text("Function 4"),
        ),
        PopupMenuItem(
          value: 5,
          child: Text("Function 5"),
        ),
        PopupMenuItem(
          value: 6,
          child: Text("Function 6"),
        ),
        PopupMenuItem(
          value: 7,
          child: Text("Function 7"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        setState(() {
          funFormulas[value - 1] = inputString;
          _displayTextInputDialog(context, value);
        });
      }
      ;
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context, int y) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Function ' + y.toString()),
            content: TextField(
              onChanged: (value) {},
              controller: varController,
              decoration: InputDecoration(hintText: "Name your new function"),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      if (varController.text.isEmpty) {
                        funNames[y - 1] = ('funn' + y.toString());
                      } else {
                        funNames[y - 1] = varController.text.toString();
                      }
                    });
                  },
                  child: Text('Submit'))
            ],
          );
        });
  }
}
