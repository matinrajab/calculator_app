import 'package:calculator_app/button.dart';
import 'package:calculator_app/provider/answer_provider.dart';
import 'package:calculator_app/provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'ANS',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<QuestionProvider>(
            create: (context) => QuestionProvider(),
          ),
          ChangeNotifierProvider<AnswerProvider>(
            create: (context) => AnswerProvider(),
          ),
        ],
        child: Scaffold(
          backgroundColor: const Color(0xFF3e3f5d),
          body: Column(
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.centerRight,
                          child: Consumer<QuestionProvider>(
                            builder: (context, questionProvider, _) => Text(
                              questionProvider.question,
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          alignment: Alignment.centerRight,
                          child: Consumer<AnswerProvider>(
                            builder: (context, answerProvider, _) => Text(
                              answerProvider.answer,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 11,
                  child: Center(
                    child: Consumer<QuestionProvider>(
                      builder: (context, questionProvider, _) => GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) {
                          // clear button
                          if(index == 0){
                            return MyButton(
                              buttonTapped: (){
                                questionProvider.question = '';
                              },
                              color: const Color(0xFF5e5d7d),
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                          }
                          // delete button
                          else if(index == 1){
                            return MyButton(
                              buttonTapped: (){
                                questionProvider.question = questionProvider.question.substring(0, questionProvider.question.length - 1);
                              },
                              color: const Color(0xFF5e5d7d),
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                          }
                          // equal button
                          else if(index == buttons.length-1){
                            return Consumer<AnswerProvider>(
                              builder: (context, answerProvider, _) => MyButton(
                                  buttonTapped: (){
                                    answerProvider.answer = questionProvider.question;
                                  },
                                  color: const Color(0xFF8f83d7),
                                  textColor: Colors.white,
                                  buttonText: buttons[index]),
                            );
                          }
                          else{
                            return MyButton(
                              buttonTapped: (){
                                questionProvider.question += buttons[index];
                              },
                              color: isOperator(buttons[index])
                                  ? const Color(0xFF8f83d7)
                                  : ((index == 2)
                                  ? const Color(0xFF5e5d7d)
                                  : const Color(0xFF464765)),
                              textColor: Colors.white,
                              buttonText: buttons[index]);
                          }
                        },
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  bool isOperator(String x) {
    return (x == '÷' || x == '×' || x == '-' || x == '+' || x == '=')
        ? true
        : false;
  }
}
