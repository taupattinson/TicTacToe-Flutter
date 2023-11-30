import 'package:flutter/material.dart';

import '../logic/logic.dart';
import '../theme/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _GameScreenState();
}

class _GameScreenState extends State<MyHomePage> {
  String lastValue = "X";
  String result = "";
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
  int turn = 0;
  Game game = Game();
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
  }

  @override
  Widget build(BuildContext context) {
    double boardHeight = MediaQuery.of(context).size.width;
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "turn - $lastValue",
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: boardWidth,
            height: boardHeight,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/ 3,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(
                Game.boardLength,
                (index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1.5, color: Colors.white),
                    ),
                    child: InkWell(
                      onTap: gameOver
                          ? null
                          : () {
                              if (game.board![index] == "") {
                                setState(() {
                                  game.board![index] = lastValue;
                                  turn++;
                                  gameOver = game.winnerCheck(
                                      lastValue, index, scoreBoard, 3);
                                  if (gameOver) {
                                    result =
                                        "$lastValue _ winner!".toUpperCase();
                                  } else if (!gameOver && turn == 9) {
                                    result = "Draw!!".toUpperCase();
                                    gameOver = true;
                                  }
                                });
                                if (lastValue == "X") {
                                  lastValue = "O";
                                } else {
                                  lastValue = "X";
                                }
                              }
                            },
                      child: Container(
                        width: Game.blocsize,
                        height: Game.blocsize,
                        decoration: BoxDecoration(
                          color: MainColor.secondaryColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Center(
                          child: Text(
                            game.board![index],
                            style: TextStyle(
                                color: game.board![index] == "X"
                                    ? const Color(0xFF69C9D0)
                                    : const Color(0xFFEE1D52),
                                fontSize: 64),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Text(
            result,
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              setState(() {
                //чистка
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.purple,
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(4, 4),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(-4, -4),
                  )
                ],
              ),
              child: const Center(
                child: Text(
                  "REPLAY",
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
