import 'package:file_picker/file_picker.dart';

Future<PlatformFile?> pickFile({bool imageOnly = false}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowedExtensions: imageOnly ? ['jpg', 'jpeg', 'png'] : null,
  );

  if (result != null) {
    return result.files.first;
  } else {
    return null;
  }
}
