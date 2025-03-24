import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final bool isForDeparture;
  final String? selectedStation;
  
  // 선택할 수 있는 기차역 리스트
  final List<String> stations = [
    "수서", "동탄", "평택지제", "천안아산", "오송", 
    "대전", "김천구미", "동대구", "경주", "울산", "부산"
  ];

  StationListPage({
    Key? key, 
    required this.isForDeparture,
    this.selectedStation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 도전 기능: 이미 선택된 역은 리스트에서 제외
    final filteredStations = stations.where((station) => 
      station != selectedStation
    ).toList();
    
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(isForDeparture ? '출발역' : '도착역'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: filteredStations.length,
        itemBuilder: (context, index) {
          final station = filteredStations[index];
          return GestureDetector(
            onTap: () {
              Navigator.pop(context, station);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDarkMode ? Colors.grey[900]! : Colors.grey[300]!,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  station,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 