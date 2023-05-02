import 'package:calculator_app/button.dart';
import 'package:calculator_app/provider/answer_provider.dart';
import 'package:calculator_app/provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<String> buttons = [
    'C',
    '(',
    ')',
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
    '%',
    '0',
    '.',
    '=',
  ];

  final List<String> operator = ['÷', '×', '-', '+', '%'];

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
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.centerRight,
                          child: Consumer<QuestionProvider>(
                            builder: (context, questionProvider, _) => Text(
                              questionProvider.question,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.centerRight,
                          child: Consumer<AnswerProvider>(
                            builder: (context, answerProvider, _) => Text(
                              answerProvider.answer,
                              style: const TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: const Alignment(0.85, 0.0),
                  child: Consumer<QuestionProvider>(
                    builder: (context, questionProvider, _) => Consumer<AnswerProvider>(
                      builder: (context, answerProvider, _) => IconButton(
                        onPressed: (){
                          questionProvider.question = questionProvider.question.substring(0, questionProvider.question.length-1);
                          for(int i = 0; i < 5; i++){
                            if(questionProvider.question.contains(operator[i])){
                              if(!isOperator(questionProvider.question.substring(questionProvider.question.length-1, questionProvider.question.length))){
                                answerProvider.answer = questionProvider.question;
                              }else{
                                answerProvider.answer = '';
                              }
                              break;
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.backspace_outlined,
                          color: Color(0xFF8f83d7),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 11,
                  child: Center(
                    child: Consumer<QuestionProvider>(
                      builder: (context, questionProvider, _) => Consumer<AnswerProvider>(
                        builder: (context, answerProvider, _) => GridView.builder(
                          itemCount: buttons.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (context, index) {
                            // clear button
                            if(buttons[index] == 'C'){
                              return MyButton(
                                buttonTapped: (){
                                  questionProvider.question = '';
                                  answerProvider.answer = '';
                                },
                                color: const Color(0xFF5e5d7d),
                                textColor: Colors.white,
                                buttonText: buttons[index]);
                            }
                            // percent button
                            else if(buttons[index] == '%'){
                              return MyButton(
                                buttonTapped: (){
                                  questionProvider.question += buttons[index];
                                  for(int i = 0; i < 5; i++){
                                    if(questionProvider.question.contains(operator[i])){
                                      answerProvider.answer = questionProvider.question;
                                      break;
                                    }
                                  }
                                },
                                color: const Color(0xFF464765),
                                textColor: Colors.white,
                                buttonText: buttons[index]);
                            }
                            // operator button
                            else if(isOperator(buttons[index])){
                              return MyButton(
                                  buttonTapped: (){
                                    bool endWithOperator = false;
                                    for(int i = 0; i < 4; i++){
                                      if(questionProvider.question.endsWith(operator[i])){
                                        endWithOperator = true;
                                        break;
                                      }
                                    }
                                    if(endWithOperator){
                                      questionProvider.question = questionProvider.question.substring(0, questionProvider.question.length-1);
                                    }
                                    questionProvider.question += buttons[index];
                                    answerProvider.answer = '';
                                  },
                                  color: const Color(0xFF8f83d7),
                                  textColor: Colors.white,
                                  buttonText: buttons[index]);
                            }
                            // equal button
                            else if(buttons[index] == '='){
                              return MyButton(
                                  buttonTapped: (){
                                    if(answerProvider.answer != 'Infinity'){
                                      answerProvider.answer = questionProvider.question;
                                      questionProvider.question = answerProvider.answer;
                                      answerProvider.answer = '';
                                    }
                                  },
                                  color: const Color(0xFF8f83d7),
                                  textColor: Colors.white,
                                  buttonText: buttons[index]);
                            }
                            else{
                              return MyButton(
                                buttonTapped: (){
                                  questionProvider.question += buttons[index];
                                  for(int i = 0; i < 5; i++){
                                    if(questionProvider.question.contains(operator[i])){
                                      answerProvider.answer = questionProvider.question;
                                      break;
                                    }
                                  }
                                },
                                color: (index == 1 || index == 2)
                                    ? const Color(0xFF5e5d7d)
                                    : const Color(0xFF464765),
                                textColor: Colors.white,
                                buttonText: buttons[index]);
                            }
                          },
                        ),
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
    return (x == '÷' || x == '×' || x == '-' || x == '+')
        ? true
        : false;
  }
}
