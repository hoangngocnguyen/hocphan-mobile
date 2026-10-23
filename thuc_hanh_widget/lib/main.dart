import 'package:flutter/material.dart';
import 'package:thuc_hanh_widget/widgets/th10_image_widget.dart';
import 'package:thuc_hanh_widget/widgets/th11_appbar_action_widget.dart';
import 'package:thuc_hanh_widget/widgets/th12_counter_state_widget.dart';
import 'package:thuc_hanh_widget/widgets/th13_card_widget.dart';
import 'package:thuc_hanh_widget/widgets/th14_circle_avatar_widget.dart';
import 'package:thuc_hanh_widget/widgets/th15_textfield_widget.dart';
import 'package:thuc_hanh_widget/widgets/th16_settings_widget.dart';
import 'package:thuc_hanh_widget/widgets/th17_listview_widget.dart';
import 'package:thuc_hanh_widget/widgets/th18_student_card.dart';
import 'package:thuc_hanh_widget/widgets/th7_text_widget.dart';
import 'package:thuc_hanh_widget/widgets/th8_container_widget.dart';
import 'package:thuc_hanh_widget/widgets/th9_column_row_widget.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tổng hợp các bài thực hành Widget'),
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          actions: [Th11AppBarActionWidget()],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                // Các widget
                Th7TextWidget(),
                Th8ContainerWidget(),
                Th9ColumnRowWidget(),
                Th10ImageWidget(),
                Th12CounterStateWidget(),
                Th13CardWidget(),
                Th14CircleAvatarWidget(),
                Th15TextfieldWidget(),
                Th16SettingsWidget(),
                Th17ListviewWidget(),
                Th18StudentCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
