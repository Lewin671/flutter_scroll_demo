import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 滑块演示',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _dragPosition = 100.0;
  static const double _sliderHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    // 计算最大拖动范围：屏幕高 - AppBar - 状态栏 - 滑块高
    final totalHeight = MediaQuery.of(context).size.height;
    final appBarHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
    final maxPosition = totalHeight - appBarHeight - _sliderHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('滑块演示'),
      ),
      body: Row(
        children: [
          // 左侧可拖动滑块
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  _dragPosition = (_dragPosition + details.delta.dy)
                      .clamp(0.0, maxPosition);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,      // ← 同时指定 left 和 right，子元素就能铺满宽度
                      top: _dragPosition,
                      child: Container(
                        height: _sliderHeight,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 右侧跟随滑块
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,    // ← 同上
                    top: _dragPosition,
                    child: Container(
                      height: _sliderHeight,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
