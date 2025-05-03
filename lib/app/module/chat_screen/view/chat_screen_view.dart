import 'package:field_king_admin/app/module/chat_screen/controller/chat_screen_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';

class ChatScreenView extends StatelessWidget {
    ChatScreenView({super.key});

  final controller =Get.put(ChatScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Chat',
        ),
        isLeading: true,
      ),
    );
  }
}
