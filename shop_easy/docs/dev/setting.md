# Kế hoạch xử lý chế độ tối toàn hệ thống

## Mục tiêu

Khi bật chế độ tối ở màn hình cài đặt, toàn bộ ứng dụng phải đổi giao diện đồng bộ: nền, chữ, card, divider, nút, switch, dialog, menu, ... Không chỉ riêng màn hình settings. Mục tiêu là có một nguồn màu duy nhất, dễ quản lý và dễ mở rộng cho tương lai.

## Nguyên tắc triển khai

1. Không hardcode màu trực tiếp trên từng màn hình.
2. Mọi màn hình dùng Theme của Flutter thay vì `Colors.white`, `Colors.black`, `Colors.grey`.
3. Chế độ tối được lưu lại và khôi phục khi mở lại app.
4. Màu chủ đạo của app vẫn giữ xanh theo thiết kế hiện có.
5. Tất cả màn hình phải đọc từ cùng một `ThemeData` để đảm bảo đồng nhất.

## Phương án triển khai

### 1. Tạo theme riêng cho app

Trong thư mục `lib/core/theme/` tạo file `app_theme.dart`:

- `lightTheme`: theme cho giao diện sáng
- `darkTheme`: theme cho giao diện tối
- `ColorScheme` nên định nghĩa rõ:
  - `primary`
  - `background`
  - `surface`
  - `onPrimary`
  - `onSurface`
  - `textPrimary`
  - `textSecondary`
  - `divider`

Ví dụ:

- Light:
  - background: trắng / xám nhạt
  - surface: trắng
  - textPrimary: màu tối
- Dark:
  - background: xám đen / đen sâu
  - surface: xám đậm
  - textPrimary: trắng/sáng

Mục đích là tất cả screen dùng `Theme.of(context).colorScheme` thay vì màu cố định.

### 2. Tạo state quản lý trạng thái theme

Có 2 cách phổ biến:

- Sử dụng `ValueNotifier` / `ChangeNotifier`
- Sử dụng `Provider` / `Riverpod` nếu app đang có kiến trúc quản lý state rõ ràng

Khuyến nghị cho app này: dùng `ChangeNotifier` hoặc `ThemeController` đơn giản.

Ví dụ hoạt động:

- `bool isDarkMode`
- `toggleDarkMode()`
- lưu vào `SharedPreferences`
- phát ra thông báo cho UI rebuild

### 3. Lưu trạng thái dưới local storage

Khi người dùng bật/tắt chế độ tối:

- lưu vào `SharedPreferences` với key như `is_dark_mode`
- khi app start, đọc lại giá trị
- nếu có, khởi tạo `ThemeController` với giá trị đó

Điều này giúp chế độ tối không bị mất khi đóng ứng dụng.

### 4. Gắn theme vào MaterialApp

Trong `main.dart`:

- `MaterialApp(
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    themeMode: controller.themeMode,
  )`

`themeMode` sẽ là:

- `ThemeMode.light` nếu chế độ sáng
- `ThemeMode.dark` nếu chế độ tối
- `ThemeMode.system` nếu muốn tự động theo hệ thống

Trong dự án này nên chọn `ThemeMode.dark` / `ThemeMode.light` do thiết kế và yêu cầu rõ ràng.

### 5. Cập nhật màn hình cài đặt

Trong [shop_easy/lib/features/settings/screens/settings_screen.dart](shop_easy/lib/features/settings/screens/settings_screen.dart):

- `SwitchListTile` cho “Chế độ tối” phải gọi `setState` hoặc `ThemeController.toggleDarkMode()`
- Khi bật, cập nhật `themeMode` toàn app
- Không cần mỗi màn hình tự giữ màu riêng để đổi

Ví dụ logic:

```dart
SwitchListTile(
  value: isDarkMode,
  activeThumbColor: AppColors.primary,
  activeTrackColor: AppColors.primaryLight,
  onChanged: (value) {
    themeController.setDarkMode(value);
  },
)
```

### 6. Refactor toàn bộ màu sắc trong app

Sau khi có theme, cần sửa các màn hình đã dùng màu cứng như:

- `Colors.white`
- `Colors.black`
- `Colors.grey.shade50`
- `Colors.blue`
- `Colors.red`

thành:

- `Theme.of(context).colorScheme.surface`
- `Theme.of(context).colorScheme.onSurface`
- `Theme.of(context).colorScheme.primary`
- `Theme.of(context).dividerColor`

Đặc biệt cần chú ý các thành phần:

- AppBar
- Scaffold background
- Card
- Container border
- Text
- Button
- Dialog
- Switch
- Chip
- BottomSheet

### 7. Quy tắc màu theo theme

Để tránh xung đột, nên quy ước dùng token màu như sau:

- `primary`: xanh chủ đạo
- `surface`: nền card / container
- `background`: nền toàn màn hình
- `textPrimary`: chữ chính
- `textSecondary`: chữ phụ
- `divider`: đường chia
- `success`, `warning`, `error`: giữ riêng cho trạng thái

Dùng `AppColors.primary` cho màu chủ đạo nhưng vẫn cho phép `darkTheme` override nếu cần. Nếu muốn đồng nhất hơn, nên dùng `ColorScheme` cho toàn bộ.

## Luồng thực thi cho dự án này

1. Tạo `AppTheme` và `ThemeController`.
2. Thêm `SharedPreferences` để lưu trạng thái chế độ tối.
3. Gắn `themeMode` vào `MaterialApp` ở `main.dart`.
4. Cập nhật toggle “Chế độ tối” trong settings.
5. Dùng theme thay cho các màu cứng ở màn hình chính, danh mục, giỏ hàng, profile, ...
6. Kiểm tra từng màn hình xem text còn mờ, nền card không tương phản, nút vẫn đọc được.
7. Chạy `flutter analyze` và test UI trên emulator.

## Ưu điểm của cách làm này

- Dễ quản lý
- Tất cả màn hình đổi cùng lúc
- Không phải sửa từng screen riêng
- Dễ mở rộng thêm chế độ tự động theo hệ thống
- Dễ bảo trì và update giao diện sau này

## Kết luận

Chế độ tối toàn hệ thống nên được triển khai như một theme layer chung, không phải là biến cục bộ riêng từng màn hình. Khi người dùng bật chế độ tối ở cài đặt, toàn bộ app sẽ đổi qua `darkTheme`, còn khi tắt thì về `lightTheme`. Đây là cách đúng chuẩn và bền vững trong Flutter.

## Nhiệm vụ triển khai tiếp theo

- [ ] Tạo `AppTheme` cho light/dark
- [ ] Tạo `ThemeController` và lưu trạng thái
- [ ] Gắn vào `MaterialApp`
- [ ] Chỉnh `settings_screen.dart` để gọi controller
- [ ] Refactor tất cả màn hình dùng màu cứng
- [ ] Test trên device/emulator và sửa contrast
