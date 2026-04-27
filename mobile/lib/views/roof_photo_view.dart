import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_mate/I18n/messages.dart';
import 'package:solar_mate/configs/dashed_border_painter.dart';
import 'package:solar_mate/controllers/main_controller.dart';
import 'package:solar_mate/widgets/colors_widget.dart';

class RoofPhotoView extends StatelessWidget {
  const RoofPhotoView({super.key});

  void _showPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return SizedBox(
          height: 380,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  AppMessages.uploadPhoto.tr,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text(AppMessages.chooseFromGallery.tr),
                onTap: () {
                  Navigator.pop(context);
                  MainController.to.pickFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(AppMessages.takeImage.tr),
                onTap: () {
                  Navigator.pop(context);
                  MainController.to.pickFromCamera();
                },
              ),
              if (MainController.to.selectedImage.value != null) ...{
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: Text(AppMessages.deleteImage.tr),
                  onTap: () {
                    Navigator.pop(context);
                    MainController.to.selectedImage.value = null;
                  },
                ),
              },
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppMessages.roofPhoto.tr,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: darkColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                AppMessages.optional.tr,
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
            ),
          ],
        ),

        Text(
          AppMessages.roofPhotoTip.tr,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white54,
          ),
        ),
        SizedBox(height: 20),
        Obx(() {
          if (MainController.to.selectedImage.value != null) {
            return GestureDetector(
              onLongPress: () {
                _showPickerOptions(context);
              },
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    backgroundColor: Colors.black,
                    child: InteractiveViewer(
                      child: Image.file(MainController.to.selectedImage.value!),
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      MainController.to.selectedImage.value!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _showPickerOptions(context),
                    child: Text(AppMessages.changeImage.tr),
                  ),
                ],
              ),
            );
          } else {
            return GestureDetector(
              onTap: () => _showPickerOptions(context),
              child: CustomPaint(
                painter: DashedBorderPainter(
                  color: Colors.white12,
                  strokeWidth: 2.0,
                  dashWidth: 6.0,
                  dashSpace: 6.0,
                ),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 40,
                        color: primaryColor,
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppMessages.uploadPhotoTitle.tr,
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                      Text(
                        AppMessages.photoTypes.tr,
                        style: TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }),
      ],
    );
  }
}
