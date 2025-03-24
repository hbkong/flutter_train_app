import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    Key? key,
    required this.departureStation,
    required this.arrivalStation,
  }) : super(key: key);

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // 좌석 선택 상태 저장
  final Set<String> selectedSeats = {};

  List<String> seatColumns = ["A", "B", "C", "D"];
  int totalRows = 20;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('좌석 선택'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 출발역, 도착역 정보
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.departureStation,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 30,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.arrivalStation,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),

          // 좌석 상태 안내
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 선택됨 상태
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text('선택됨', 
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                // 선택 안됨 상태
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Color(0xFF444444) : Colors.grey[300]!,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text('선택안됨',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 좌석 선택 영역
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                // 열 레이블 (A, B, C, D)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // A, B 레이블 (왼쪽)
                    ...seatColumns.sublist(0, 2).map((column) {
                      return Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          column,
                          style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
                    // 중앙 여백
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                    ),
                    // C, D 레이블 (오른쪽)
                    ...seatColumns.sublist(2, 4).map((column) {
                      return Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          column,
                          style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
                  ],
                ),
                
                // 좌석 행 (1부터 20까지)
                ...List.generate(totalRows, (rowIndex) {
                  final rowNumber = rowIndex + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 왼쪽 좌석 (A, B)
                        ...seatColumns.sublist(0, 2).map((column) {
                          final seatId = "$rowNumber$column";
                          final isSelected = selectedSeats.contains(seatId);
                          return Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedSeats.remove(seatId);
                                  } else {
                                    selectedSeats.add(seatId);
                                  }
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.purple
                                      : isDarkMode
                                          ? Color(0xFF444444)
                                          : Colors.grey[300]!,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          );
                        }),
                        
                        // 행 번호 (중앙)
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            rowNumber.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        // 오른쪽 좌석 (C, D)
                        ...seatColumns.sublist(2, 4).map((column) {
                          final seatId = "$rowNumber$column";
                          final isSelected = selectedSeats.contains(seatId);
                          return Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedSeats.remove(seatId);
                                  } else {
                                    selectedSeats.add(seatId);
                                  }
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.purple
                                      : isDarkMode
                                          ? Color(0xFF444444)
                                          : Colors.grey[300]!,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // 예매하기 버튼
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: selectedSeats.isNotEmpty
                    ? () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text('정말 예매하시겠습니까?'),
                              content: Column(
                                children: [
                                  Text('${widget.departureStation} → ${widget.arrivalStation}'),
                                  Text('선택된 좌석: ${selectedSeats.join(', ')}'),
                                ],
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  child: const Text('취소'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  textStyle: const TextStyle(
                                    color: CupertinoColors.activeBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  child: const Text('확인'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    : null,
                child: const Text(
                  '예매 하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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