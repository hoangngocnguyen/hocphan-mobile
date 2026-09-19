## BÀI 3: Báo cáo tư vấn công nghệ cho Startup EduLearn

### 1. Phân tích yêu cầu

EduLearn là một startup hoạt động trong lĩnh vực giáo dục trực tuyến, dự kiến xây dựng ứng dụng cho phép người dùng đăng ký tài khoản, tìm kiếm khóa học, xem bài giảng, theo dõi tiến độ học tập, làm bài kiểm tra và nhận thông báo.
Ứng dụng cần hỗ trợ Android và iOS, có giao diện dễ sử dụng và có khả năng kết nối với hệ thống backend thông qua API. Trong tương lai, hệ thống có thể mở rộng thêm phiên bản Web.
Với đặc điểm trên, framework mobile cần đáp ứng các yêu cầu chính:

- Hỗ trợ phát triển Android và iOS từ một codebase.
- Có khả năng xây dựng giao diện tương tác và responsive.
- Kết nối tốt với REST API.
- Hỗ trợ video, thông báo và các chức năng native.
- Có khả năng mở rộng khi số lượng người dùng và chức năng tăng.
- Có cộng đồng, tài liệu và hệ sinh thái đủ lớn để startup duy trì sản phẩm lâu dài.

Hai công nghệ phù hợp để xem xét là Flutter và React Native.

### 2. Đề xuất công nghệ

Đối với EduLearn, Flutter được đề xuất làm framework phát triển ứng dụng mobile.
Flutter hỗ trợ Android và iOS, đồng thời có khả năng triển khai sang Web và desktop. Flutter sử dụng hệ thống widget riêng và tự quản lý quá trình rendering giao diện, giúp đội ngũ kiểm soát giao diện tương đối thống nhất giữa các nền tảng.
Flutter cũng hỗ trợ tích hợp với các chức năng native thông qua plugin và Platform Channels. Điều này phù hợp với EduLearn vì ứng dụng có thể cần sử dụng camera, microphone, thông báo, lưu trữ thiết bị hoặc video player.
Một yếu tố khác là khả năng tổ chức kiến trúc. Ứng dụng có thể được chia thành các lớp giao diện, xử lý nghiệp vụ và dữ liệu. Cách tổ chức này giúp giảm sự phụ thuộc giữa các thành phần và thuận lợi hơn khi mở rộng hoặc kiểm thử hệ thống.
React Native cũng đáp ứng được yêu cầu của EduLearn. Công nghệ này đặc biệt phù hợp nếu đội ngũ đã có kinh nghiệm với React và TypeScript. Vì vậy, quyết định cuối cùng vẫn cần xem xét kỹ năng thực tế của đội ngũ phát triển.

### 3. Kiến trúc đề xuất

EduLearn nên xây dựng mobile app theo kiến trúc phân lớp.
Lớp giao diện chịu trách nhiệm hiển thị màn hình và nhận tương tác từ người dùng. Lớp xử lý nghiệp vụ chịu trách nhiệm quản lý trạng thái và các logic của ứng dụng. Lớp dữ liệu chịu trách nhiệm giao tiếp với backend, xử lý API và lưu trữ dữ liệu cần thiết trên thiết bị.
Luồng xử lý có thể được tổ chức theo hướng:
Người dùng → Giao diện → Xử lý nghiệp vụ → Repository → API Service → Backend → Database.
Cách tổ chức này giúp mobile app không truy cập trực tiếp vào database. Khi EduLearn phát triển thêm Web hoặc một ứng dụng khác, các client mới có thể sử dụng chung hệ thống backend API.

### 4. Phân tích rủi ro

**Rủi ro về hiệu năng:** EduLearn có video, hình ảnh và danh sách khóa học nên có thể sử dụng nhiều tài nguyên thiết bị. Nếu không tối ưu, ứng dụng có thể tiêu tốn bộ nhớ và gây hiện tượng giật khi sử dụng. Có thể giảm rủi ro bằng cách tối ưu hình ảnh, sử dụng caching, phân trang dữ liệu và kiểm thử trên các thiết bị Android có cấu hình thấp.
**Rủi ro về tích hợp native:** Một số chức năng như thông báo, camera, microphone hoặc video có thể yêu cầu truy cập API của Android và iOS. Flutter có hệ thống plugin và Platform Channels để giải quyết những trường hợp này. Tuy nhiên, trước khi sử dụng thư viện bên thứ ba cần kiểm tra khả năng tương thích và tình trạng bảo trì của thư viện.
**Rủi ro về nhân sự:** Nếu đội ngũ chưa có kinh nghiệm với Flutter, cần thời gian học Dart, Flutter, widget và cách quản lý trạng thái. Startup có thể giảm rủi ro bằng cách đào tạo trước khi triển khai sản phẩm chính thức.
**Rủi ro về thư viện:** Việc phụ thuộc quá nhiều vào thư viện bên thứ ba có thể dẫn đến xung đột phiên bản hoặc thư viện ngừng được hỗ trợ. Do đó, các thư viện quan trọng nên được lựa chọn dựa trên mức độ phổ biến, khả năng bảo trì và khả năng tương thích với phiên bản Flutter đang sử dụng.

### 5. Lộ trình học tập 8 tuần

**Tuần 1:** Học Dart cơ bản, bao gồm biến, hàm, class, collection, null safety, Future và xử lý bất đồng bộ.
**Tuần 2:** Học Flutter cơ bản, widget, layout, navigation, form và xây dựng các màn hình đơn giản.
**Tuần 3:** Học xây dựng giao diện hoàn chỉnh, responsive layout, theme và validation. Hoàn thành giao diện đăng nhập, danh sách khóa học, chi tiết khóa học và hồ sơ cá nhân.
**Tuần 4:** Học REST API, JSON, authentication, repository và xử lý lỗi. Kết nối ứng dụng với backend.
**Tuần 5:** Học quản lý state và kiến trúc ứng dụng. Tách giao diện, logic nghiệp vụ và tầng dữ liệu để chuẩn bị cho việc phát triển ứng dụng lớn hơn.
**Tuần 6:** Xây dựng các chức năng đặc thù của EduLearn như xem video, cập nhật tiến độ học tập, quiz và thông báo.
**Tuần 7:** Thực hiện unit test, widget test và kiểm thử các luồng chính. Đồng thời kiểm tra hiệu năng và khả năng hoạt động khi mạng yếu.
**Tuần 8:** Chuẩn bị bản release, cấu hình môi trường, build Android/iOS và thiết lập quy trình CI/CD.
Sau 8 tuần, đội ngũ nên hoàn thành một phiên bản MVP có thể đăng nhập, xem khóa học, học bài, cập nhật tiến độ và làm bài kiểm tra.

### 6. Kết luận

Flutter và React Native đều có khả năng đáp ứng yêu cầu phát triển ứng dụng mobile cho EduLearn. React Native phù hợp với những đội ngũ đã có nền tảng React và TypeScript, trong khi Flutter cung cấp một hệ thống widget và mô hình phát triển đa nền tảng tương đối thống nhất.
Đối với EduLearn, Flutter được đề xuất do phù hợp với yêu cầu Android và iOS, có khả năng kiểm soát giao diện tốt, hỗ trợ tích hợp native và có khả năng mở rộng sang các nền tảng khác. Tuy nhiên, startup vẫn cần xem xét kỹ năng hiện tại của đội ngũ trước khi đưa ra quyết định triển khai cuối cùng.
Lộ trình 8 tuần tập trung từ kiến thức nền tảng, xây dựng giao diện, kết nối API, kiến trúc, phát triển chức năng, kiểm thử đến triển khai. Cách tiếp cận này giúp đội ngũ vừa học công nghệ vừa tạo ra MVP thực tế cho EduLearn.