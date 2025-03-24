# Today I Learned (TIL)

## 2024-01-10

### Flutter의 테마 관리 시스템

오늘 Flutter에서 테마를 효과적으로 관리하는 방법에 대해 배웠습니다. Provider 패키지와 ChangeNotifier를 활용하여 앱 전체의 테마를 전환하는 기능을 구현했습니다.

```dart
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
```

이 접근 방식의 가장 큰 장점은 앱의 어느 위젯에서든 테마 상태에 접근하고 변경할 수 있다는 점입니다. 또한 ThemeData 객체를 사용하여 각 테마별로 일관된 색상 체계와 스타일을 정의할 수 있었습니다.

### 조건부 스타일링

다크 모드와 라이트 모드에 따라 UI 요소의 색상을 조건부로 변경하는 방법을 알게 되었습니다:

```dart
final isDarkMode = Theme.of(context).brightness == Brightness.dark;

Container(
  color: isDarkMode ? Colors.black : Colors.white,
  child: Text(
    '텍스트',
    style: TextStyle(
      color: isDarkMode ? Colors.white : Colors.black,
    ),
  ),
)
```

이 패턴을 통해 모든 위젯에서 현재 테마에 맞는 스타일을 쉽게 적용할 수 있었습니다.

### Git 커밋 컨벤션

오늘 Git 커밋 메시지에 대한 컨벤션을 배우고 적용했습니다. 이를 통해 프로젝트 히스토리를 더 명확하게 관리할 수 있게 되었습니다.

- feat: 새 기능 추가
- fix: 버그 수정
- style: UI 관련 변경
- refactor: 코드 구조 개선
- docs: 문서 변경

예시 커밋:
```
feat: add theme switching functionality
fix: resolve seat layout alignment issues
style: update disabled button color to light purple
```

## 2024-01-09

### Flutter의 Cupertino 위젯

iOS 스타일의 UI 컴포넌트를 구현하기 위해 Cupertino 위젯을 사용하는 방법을 배웠습니다. 특히 CupertinoAlertDialog에서 버튼 스타일을 네이티브 iOS와 유사하게 만드는 방법을 알게 되었습니다.

```dart
CupertinoAlertDialog(
  title: const Text('정말 예매하시겠습니까?'),
  content: Text('선택된 좌석: ${selectedSeats.join(', ')}'),
  actions: [
    CupertinoDialogAction(
      isDestructiveAction: true, // 빨간색 스타일 (취소)
      child: const Text('취소'),
      onPressed: () => Navigator.pop(context),
    ),
    CupertinoDialogAction(
      isDefaultAction: true, // 굵은 글씨체 스타일
      textStyle: const TextStyle(
        color: CupertinoColors.activeBlue, // iOS 기본 파란색
        fontWeight: FontWeight.bold,
      ),
      child: const Text('확인'),
      onPressed: () {
        // 로직 처리
        Navigator.pop(context);
      },
    ),
  ],
)
```

이런 세부 사항이 앱의 전체적인 느낌을 크게 향상시킨다는 것을 배웠습니다.

### 효과적인 좌석 배치 UI 설계

복잡한 좌석 배치 UI를 구현하기 위해 Row, Column을 조합하여 레이아웃을 만드는 방법을 배웠습니다. 특히 `...List.generate()`와 `...myList.map()`을 사용한 리스트 확장 연산자를 활용하여 반복적인 UI 요소를 쉽게 생성하는 기법이 매우 유용했습니다.

## 2024-01-08

### Flutter에서 Set 자료구조 활용하기

오늘 Set 자료구조를 사용하여 좌석 선택 상태를 효율적으로 관리하는 방법을 배웠습니다. Set은 중복 요소를 허용하지 않기 때문에 좌석 ID를 관리하는 데 매우 적합했습니다.

```dart
final Set<String> selectedSeats = {};

// 좌석 선택/취소
void toggleSeat(String seatId) {
  setState(() {
    if (selectedSeats.contains(seatId)) {
      selectedSeats.remove(seatId);
    } else {
      selectedSeats.add(seatId);
    }
  });
}
```

이를 통해 좌석 선택 상태를 쉽게 토글하고 선택된 좌석 목록을 효율적으로 관리할 수 있었습니다.

### 상태 관리의 중요성

Flutter 앱에서 상태 관리가 얼마나 중요한지 다시 한번 깨달았습니다. 특히 사용자 입력에 따라 여러 화면이 연결되는 앱에서는 상태를 잘 관리하는 것이 핵심입니다. 이번 프로젝트에서는 출발역, 도착역 선택 상태를 관리하여 좌석 선택 화면으로 자연스럽게 연결하는 흐름을 구현했습니다. 