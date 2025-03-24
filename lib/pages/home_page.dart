import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'station_list_page.dart';
import 'seat_page.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('기차 예매'),
        centerTitle: true,
        actions: [
          // 설정 버튼 추가
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('설정'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('다크 모드'),
                          Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (value) {
                              themeProvider.toggleTheme();
                              Navigator.pop(context);
                            },
                            activeColor: Colors.purple,
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('닫기', style: TextStyle(color: Colors.purple)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).brightness == Brightness.dark 
            ? Colors.black
            : Colors.grey[200],
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 출발역, 도착역 선택 컨테이너
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? Color(0xFF333333) 
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 출발역 선택
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StationListPage(
                                isForDeparture: true,
                                selectedStation: arrivalStation,
                              ),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              departureStation = result;
                            });
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '출발역',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? Colors.grey[400] 
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              departureStation ?? '선택',
                              style: TextStyle(
                                fontSize: 40,
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // 중앙 구분선
                    Container(
                      width: 1,
                      height: 80,
                      color: Theme.of(context).brightness == Brightness.dark 
                          ? Colors.grey[700] 
                          : Colors.grey[400],
                    ),
                    
                    // 도착역 선택
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StationListPage(
                                isForDeparture: false,
                                selectedStation: departureStation,
                              ),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              arrivalStation = result;
                            });
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '도착역',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? Colors.grey[400] 
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              arrivalStation ?? '선택',
                              style: TextStyle(
                                fontSize: 40,
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // 좌석 선택 버튼
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: departureStation != null && arrivalStation != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeatPage(
                                departureStation: departureStation!,
                                arrivalStation: arrivalStation!,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    disabledBackgroundColor: Theme.of(context).brightness == Brightness.dark 
                        ? Color(0xFF9E6EB0)  // 연한 퍼플 (다크 모드)
                        : Color(0xFFE1BEE7),  // 더 연한 퍼플 (라이트 모드)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    '좌석 선택',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 