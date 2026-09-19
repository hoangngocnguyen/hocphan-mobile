## BÀI 2: Báo cáo kỹ thuật: so sánh Flutter và React Native

#### 1. Giới thiệu

Flutter và React Native đều là các framework mã nguồn mở được sử dụng để phát triển ứng dụng đa nền tảng. Thay vì phải xây dựng riêng một ứng dụng Android và một ứng dụng iOS, nhà phát triển có thể chia sẻ phần lớn mã nguồn giữa các nền tảng.
Flutter được phát triển bởi Google và sử dụng ngôn ngữ Dart. Kiến trúc Flutter bao gồm framework, engine và platform embedder. Flutter tự quản lý hệ thống widget và quá trình rendering của giao diện. Ứng dụng Flutter có thể triển khai cho Android, iOS, Windows, macOS, Linux và Web.
React Native được phát triển trong hệ sinh thái React của Meta. React Native sử dụng JavaScript/TypeScript và các React component để xây dựng giao diện. Các component như View, Text, Image được ánh xạ tới các thành phần giao diện của Android và iOS.
Hai công nghệ đều hướng đến mục tiêu **viết một lần, chia sẻ mã nguồn trên nhiều nền tảng**, nhưng cách tiếp cận kỹ thuật của chúng khác nhau.

#### 2. So sánh theo các tiêu chí

| **Tiêu chí** | **Flutter**                               | **React Native**                                 |
| ------------ | ----------------------------------------- | ------------------------------------------------ |
| Ngôn ngữ     | Dart                                      | JavaScript/TypeScript                            |
| Mô hình UI   | Widget của Flutter                        | React Components + Native Components             |
| Rendering    | Flutter tự render giao diện               | Sử dụng các native component của nền tảng        |
| Chia sẻ code | Cao                                       | Cao                                              |
| Android/iOS  | Hỗ trợ chính thức                         | Hỗ trợ chính thức                                |
| Web/Desktop  | Hỗ trợ                                    | Không phải trọng tâm chính của React Native      |
| Hiệu năng    | Tốt, mã Dart có thể được biên dịch native | Tốt; kiến trúc mới cải thiện giao tiếp JS/native |
| Native API   | Platform Channels, plugin                 | Native Modules/Components                        |
| Hệ sinh thái | Package Flutter/Dart                      | Hệ sinh thái JavaScript/NPM rất lớn              |
| Phù hợp với  | Dự án mobile đa nền tảng, UI đồng nhất    | Đội ngũ đã quen React/JavaScript                 |

#### 3. Tiêu chí 1: Khả năng đa nền tảng

Flutter được thiết kế ngay từ đầu cho phát triển đa nền tảng. Theo tài liệu chính thức, Flutter hỗ trợ Android, iOS, Windows, macOS, Linux và Web. Một codebase có thể được sử dụng trên nhiều nền tảng, mặc dù một số chức năng vẫn cần tích hợp riêng cho từng hệ điều hành.
React Native tập trung chủ yếu vào Android và iOS. Framework sử dụng JavaScript để mô tả giao diện nhưng các component được kết nối với khả năng native của hệ điều hành.
**Kết luận theo tiêu chí:** Flutter có phạm vi nền tảng rộng hơn, còn React Native tập trung rõ hơn vào mobile.

#### 4. Tiêu chí 2: Hiệu năng

Flutter sử dụng engine riêng để render giao diện. Dart có thể được biên dịch thành mã máy trong bản release, giúp Flutter kiểm soát trực tiếp quá trình rendering. Tài liệu Flutter mô tả engine chịu trách nhiệm rasterize các scene được compositing và sử dụng Impeller cho rendering trên các nền tảng được hỗ trợ.
React Native truyền thống sử dụng JavaScript giao tiếp với native thông qua một bridge. Tuy nhiên, kiến trúc mới của React Native đã loại bỏ sự phụ thuộc vào bridge này và sử dụng JSI để cho phép giao tiếp trực tiếp hơn giữa JavaScript và native. React Native 0.76 đưa New Architecture thành mặc định.
Do đó, không nên kết luận đơn giản rằng React Native luôn chậm hơn Flutter. Hiệu năng thực tế còn phụ thuộc vào cách viết ứng dụng, số lượng component, animation, network request, quản lý state và cách sử dụng native API.

#### 5. Tiêu chí 3: Giao diện người dùng

Flutter sử dụng hệ thống widget riêng. Các widget được Flutter framework quản lý và render thành giao diện trên thiết bị. Cách tiếp cận này giúp nhà phát triển kiểm soát khá thống nhất giao diện giữa các nền tảng.
React Native sử dụng React component và ánh xạ chúng tới các native component của Android và iOS. Ví dụ, View, Text và Image tương ứng với các thành phần UI của từng nền tảng.
Vì vậy, Flutter thuận lợi khi muốn kiểm soát giao diện đồng nhất, trong khi React Native có lợi thế khi muốn tận dụng cách biểu diễn UI gần với nền tảng native.

#### 6. Tiêu chí 4: Tích hợp chức năng native

Flutter cung cấp Platform Channels để Dart giao tiếp với code native như Kotlin hoặc Swift. Flutter cũng có hệ thống plugin để sử dụng camera, WebView, thanh toán và các dịch vụ nền tảng khác.
React Native cũng cho phép ứng dụng gọi native code thông qua Native Modules và Native Components. Kiến trúc mới bổ sung Turbo Native Modules và Fabric nhằm cải thiện khả năng tích hợp giữa JavaScript và native.
Hai framework đều có khả năng tích hợp native. Vì vậy, đây không phải là tiêu chí mà một framework hoàn toàn loại bỏ framework còn lại.

#### 7. Tiêu chí 5: Hệ sinh thái và nguồn nhân lực

React Native sử dụng JavaScript/TypeScript và nằm trong hệ sinh thái React. Điều này tạo lợi thế cho các đội ngũ đã phát triển Web bằng React. React Native cũng có hệ sinh thái thư viện cộng đồng lớn. Tài liệu chính thức của React Native mô tả cộng đồng có hàng nghìn nhà phát triển và nhiều thư viện bên thứ ba.
Flutter sử dụng Dart. Nhà phát triển phải học Dart và hệ thống widget của Flutter nếu chưa từng sử dụng công nghệ này. Tuy nhiên, Flutter cung cấp tài liệu chính thức khá đầy đủ, bao gồm learning pathway, API documentation và hướng dẫn kiến trúc ứng dụng.

#### 8. Tiêu chí 6: Kiến trúc và khả năng bảo trì

Flutter có tài liệu kiến trúc chính thức khuyến nghị phân tách UI layer và Data layer, đồng thời sử dụng View, ViewModel, Repository và Service trong các ứng dụng có quy mô phù hợp. Mục tiêu là tăng khả năng bảo trì, kiểm thử và cho phép nhiều lập trình viên cùng làm việc trên một codebase.
React Native dựa trên mô hình component của React. Các ứng dụng có thể tổ chức code theo feature, component, hooks, services và state management tùy theo quy mô dự án.
Với cả hai framework, kiến trúc ứng dụng vẫn phụ thuộc nhiều vào cách tổ chức code của đội ngũ, chứ không chỉ phụ thuộc vào framework.

##### 9. Tiêu chí 7: Phù hợp với bối cảnh Việt Nam

Trong một nhóm phát triển phần mềm tại Việt Nam, việc lựa chọn công nghệ nên xét đến kỹ năng hiện có của thành viên, khả năng tuyển dụng, tài liệu, cộng đồng và khả năng tích hợp với backend.
React Native có lợi thế nếu đội ngũ đã sử dụng React/JavaScript/TypeScript cho Web. Khi đó có thể chia sẻ kiến thức về React, component, state và TypeScript giữa Web và Mobile.
Flutter phù hợp khi nhóm muốn tập trung vào một framework mobile có khả năng triển khai nhiều nền tảng và muốn kiểm soát UI thống nhất. Flutter cũng hỗ trợ Android và iOS chính thức, trong đó Android có thể triển khai trên nhiều kiến trúc phần cứng phổ biến.

#### 10. Kết luận

Flutter và React Native đều có khả năng xây dựng ứng dụng mobile đa nền tảng và đều có khả năng tích hợp native.
Flutter có cách tiếp cận riêng về rendering và widget, hỗ trợ nhiều nền tảng ngoài mobile và cung cấp tài liệu kiến trúc khá rõ ràng. React Native tận dụng JavaScript/TypeScript và hệ sinh thái React, đồng thời sử dụng native components và kiến trúc mới để cải thiện khả năng giao tiếp với nền tảng.
Do đó, lựa chọn framework nên dựa trên **đội ngũ phát triển, nền tảng mục tiêu, yêu cầu UI, khả năng tích hợp native và hệ sinh thái mà dự án đang sử dụng** thay vì chỉ dựa vào nhận định framework nào có hiệu năng cao hơn.

