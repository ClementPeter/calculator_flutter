import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.black,
      ),
      home: SimpleCalulator(),
    );
  }
}

class SimpleCalulator extends StatefulWidget {
  @override
  _SimpleCalulatorState createState() => _SimpleCalulatorState();
}

class _SimpleCalulatorState extends State<SimpleCalulator> {
  //Default values
  String equation = '0'; //Question
  String result = '0'; //Answer
  String expression = '0'; //Accepts Equation and Logical Operators
  double equation_fontSize = 30;
  double result_fontSize = 40;
  //
  //Method that hold Calculations Function
  buttonPressed(String buttonText) {
    setState(
      () {
        //clear button
        if (buttonText == 'C') {
          print('$equation from C ');
          equation = '0';
          result = '0';
          equation_fontSize = 38;
          result_fontSize = 48;
        } //Delete button
        else if (buttonText == 'Del.') {
          print('$equation from Delete ');
          equation_fontSize = 48;
          result_fontSize = 38;
          equation = equation.substring(0, equation.length - 1);
          if (equation == '') {
            equation = '0';
          }
        }
        //Equal too button
        else if (buttonText == '=') {
          print('$equation from equals too');
          equation_fontSize = 38;
          result_fontSize = 48;
          expression = equation;
          expression = expression.replaceAll('x', '*');
          expression = expression.replaceAll('÷', '/');

          //Main Calculation
          try {
            Parser p = Parser();
            //print('$p from parser');
            Expression exp = p.parse(expression);
            //print('$exp from exp');
            ContextModel contextModel = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, contextModel)}';
            //print(result);
          } catch (e) {
            print(e);
          }
        }
        //Final else --which tracks which button is pressed & adds to the equation
        else {
          equation_fontSize = 48.0;
          result_fontSize = 38.0;
          if (equation == '0') {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
        }
      },
    );
  }

  //
  //Build individual buttons for the Calculator
  Widget buildButton(
    String buttonText,
    double buttonHeight,
    Color buttonColor,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        onPressed: () => buttonPressed(buttonText),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            width: 2,
            color: Colors.white12,
            style: BorderStyle.solid,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  //Build Method for Calculator Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Equation container
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child:
                Text(equation, style: TextStyle(fontSize: equation_fontSize)),
          ),
          //Result Container
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: result_fontSize)),
          ),
          Expanded(child: Divider()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.green),
                        buildButton("Del.", 1, Colors.redAccent),
                        buildButton("÷", 1, Colors.black38),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('9', 1, Colors.black),
                        buildButton('8', 1, Colors.black),
                        buildButton('7', 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('6', 1, Colors.black),
                        buildButton('5', 1, Colors.black),
                        buildButton('4', 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('3', 1, Colors.black),
                        buildButton('2', 1, Colors.black),
                        buildButton('1', 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, Colors.black),
                        buildButton('0', 1, Colors.black),
                        buildButton('00', 1, Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
              //Inside Row Widget
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('x', 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('-', 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('+', 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('=', 2, Colors.orange),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

