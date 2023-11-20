part of '../core.dart';

class Dialogs {
  static void showLoading(BuildContext context, String label) {
    waitFrame(
      () => unawaited(
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(width: 32),
                    Text(label),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
