import 'package:field_king_admin/app/module/chat/controller/chat_controller.dart';
import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/packages/screen.dart';
import 'package:field_king_admin/services/custom_app_bar.dart';

class ChatView extends StatelessWidget {
   ChatView({super.key});

  final controller =Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Chat',
        ),
        isLeading: false,
      ),
    );
  }
}
