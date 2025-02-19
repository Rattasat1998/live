import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:shortie/custom/custom_format_number.dart';
import 'package:shortie/shimmer/hash_tag_bottom_sheet_shimmer_ui.dart';
import 'package:shortie/ui/no_data_found_ui.dart';
import 'package:shortie/main.dart';
import 'package:shortie/pages/upload_post_page/controller/upload_post_controller.dart';
import 'package:shortie/utils/asset.dart';
import 'package:shortie/utils/color.dart';
import 'package:shortie/utils/enums.dart';
import 'package:shortie/utils/font_style.dart';

class PreviewPostCaptionUi extends StatefulWidget {
  const PreviewPostCaptionUi({super.key});

  @override
  State<PreviewPostCaptionUi> createState() => _PreviewPostCaptionUiState();
}

class _PreviewPostCaptionUiState extends State<PreviewPostCaptionUi> {
  final controller = Get.find<UploadPostController>();
  FocusNode focusNode = FocusNode();

  String caption = "";

  @override
  void initState() {
    focusNode.requestFocus();
    controller.onToggleHashTag(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.transparent,
        flexibleSpace: SafeArea(
          bottom: false,
          child: Container(
            color: AppColor.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  45.width,
                  Spacer(),
                  Text(
                    EnumLocal.txtCaption.name.tr,
                    style: AppFontStyle.styleW700(AppColor.black, 19),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: AppColor.transparent,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        EnumLocal.txtDone.name.tr,
                        style: AppFontStyle.styleW700(AppColor.primary, 16),
                      ),
                    ),
                  ),
                  5.width,
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          15.height,
          Container(
            height: 130,
            width: Get.width,
            padding: const EdgeInsets.only(left: 15),
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: AppColor.colorBorder.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
            ),
            child: TextFormField(
              onChanged: (value) => controller.onChangeHashtag(),
              controller: controller.captionController,
              maxLines: 4,
              focusNode: focusNode,
              cursorColor: AppColor.colorTextGrey,
              style: AppFontStyle.styleW600(AppColor.black, 15),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: EnumLocal.txtEnterYourTextWithHashtag.name.tr,
                hintStyle: AppFontStyle.styleW400(AppColor.coloGreyText, 15),
              ),
            ),
          ),
          15.height,
          Expanded(
            child: Obx(
              () => Visibility(
                visible: controller.isShowHashTag.value,
                child: GetBuilder<UploadPostController>(
                  id: "onGetHashTag",
                  builder: (controller) => controller.isLoadingHashTag
                      ? HashTagBottomSheetShimmerUi()
                      : controller.filterHashtag.isEmpty
                          ? Center(child: SingleChildScrollView(child: NoDataFoundUi(iconSize: 160, fontSize: 19)))
                          : SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.filterHashtag.length,
                                itemBuilder: (context, index) => GetBuilder<UploadPostController>(
                                  id: "onSelectHastTag",
                                  builder: (controller) => GestureDetector(
                                    onTap: () => controller.onSelectHashtag(index),
                                    child: Container(
                                      height: 70,
                                      width: Get.width,
                                      padding: EdgeInsets.only(left: 20, right: 20),
                                      decoration: BoxDecoration(
                                        border: Border(top: BorderSide(color: AppColor.grey_100)),
                                      ),
                                      child: Row(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              text: "# ",
                                              style: AppFontStyle.styleW600(AppColor.primary, 20),
                                              children: [
                                                TextSpan(
                                                  text: controller.filterHashtag[index].hashTag,
                                                  style: AppFontStyle.styleW700(AppColor.black, 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              Image.asset(
                                                AppAsset.icViewBorder,
                                                color: AppColor.colorTextGrey,
                                                width: 20,
                                              ),
                                              5.width,
                                              Text(
                                                CustomFormatNumber.convert(controller.filterHashtag[index].totalHashTagUsedCount ?? 0),
                                                style: AppFontStyle.styleW700(AppColor.colorTextGrey, 13),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CaptionTextFieldUi extends StatelessWidget {
  const CaptionTextFieldUi({
    super.key,
    this.height,
    required this.title,
    required this.maxLines,
    required this.controller,
    this.onClick,
    this.focusNode,
    this.enabled,
  });

  final String title;
  final int? maxLines;
  final double? height;

  final Callback? onClick;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: RichText(
            text: TextSpan(
              text: title,
              style: AppFontStyle.styleW700(AppColor.black, 15),
              children: [
                TextSpan(
                  text: " ${EnumLocal.txtOptionalInBrackets.name.tr}",
                  style: AppFontStyle.styleW400(AppColor.coloGreyText, 10),
                ),
              ],
            ),
          ),
        ),
        5.height,
        GestureDetector(
          onTap: onClick,
          child: Container(
            height: height ?? 55,
            width: Get.width,
            padding: const EdgeInsets.only(left: 15),
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: height == null ? Alignment.center : null,
            decoration: BoxDecoration(
              color: AppColor.colorBorder.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
            ),
            child: TextFormField(
              controller: controller,
              maxLines: maxLines ?? 1,
              enabled: enabled,
              focusNode: focusNode,
              cursorColor: AppColor.colorTextGrey,
              style: AppFontStyle.styleW600(AppColor.black, 15),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: EnumLocal.txtEnterYourTextWithHashtag.name.tr,
                hintStyle: AppFontStyle.styleW400(AppColor.coloGreyText, 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// >>>>>>>>>>>>>>>>>>>>>>>> Old Hashtag Function <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// onTap: () {
//   final text = controller.captionController.text;
//   final position = controller.captionController.selection.baseOffset;
//   final textBeforeCursor = text.substring(0, position);
//
//   final hashtagRegex = RegExp(r'#\w+');
//   final matches = hashtagRegex.allMatches(textBeforeCursor);
//
//   String? lastHashtag;
//   int? hashtagStartIndex;
//
//   for (final match in matches) {
//     final start = match.start;
//     final end = match.end;
//
//     if (position >= start && position <= end) {
//       lastHashtag = text.substring(start, end);
//       hashtagStartIndex = start;
//     }
//   }
//
//   if (lastHashtag != null) {
//     print('Hashtag at cursor: $lastHashtag');
//     print('Hashtag start index: $hashtagStartIndex');
//   } else {
//     print('No hashtag at cursor position');
//   }
// },
//........................

// if (controller.captionController.text.trim().isNotEmpty) {
// Utils.showLog("****** ${controller.captionController.text}");
//
// if (controller.captionController.text.endsWith("#") || controller.captionController.text.endsWith("@")) {
// Utils.showLog("Hash Tag Adding...");
//
// controller.onToggleHashTag(true);
//
// lastSearchHashtagText = "";
// controller.searchHashtagText = "";
// } else {
// lastSearchText = controller.captionController.text;
// }
// if (controller.isShowHashTag.value && value[value.length - 1] != "#") {
// if (lastSearchHashtagText != "") {
// lastSearchHashtagText = lastSearchHashtagText + value[value.length - 1];
// } else {
// lastSearchHashtagText = value[value.length - 1];
// }
//
// controller.searchHashtagText = lastSearchHashtagText;
//
// controller.onGetHashTag();
// }
// }
//------------------------------------------------------------------------------------------
// void postHashTagBottomSheet() {
//   final controller = Get.find<UploadPostController>();
//   controller.onGetHashTag();
//
//   Get.bottomSheet(
//     Container(
//       height: Get.height / 2,
//       width: Get.width,
//       clipBehavior: Clip.antiAlias,
//       decoration: const BoxDecoration(
//         color: AppColor.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             height: 60,
//             color: AppColor.grey_100,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 0, right: 15),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: GestureDetector(
//                         onTap: () => Get.back(),
//                         child: Container(
//                           height: 60,
//                           width: 60,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColor.transparent,
//                           ),
//                           child: Center(
//                             child: Image.asset(
//                               AppAsset.icArrowLeft,
//                               color: AppColor.black,
//                               width: 22,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         EnumLocal.txtAddHashtag.name.tr,
//                         style: AppFontStyle.styleW700(AppColor.black, 17),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () => Get.back(),
//                     child: Container(
//                       height: 36,
//                       width: 82,
//                       decoration: BoxDecoration(
//                         gradient: AppColor.primaryLinearGradient,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Center(
//                         child: Text(
//                           EnumLocal.txtDone.name.tr,
//                           style: AppFontStyle.styleW600(AppColor.white, 15),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: GetBuilder<UploadPostController>(
//               id: "onGetHashTag",
//               builder: (controller) => controller.isLoadingHashTag
//                   ? HashTagBottomSheetShimmerUi()
//                   : controller.hastTagCollection.isEmpty
//                       ? const NoDataFoundUi(iconSize: 160, fontSize: 19)
//                       : ListView.builder(
//                           itemCount: controller.hastTagCollection.length,
//                           itemBuilder: (context, index) => GetBuilder<UploadPostController>(
//                             id: "onSelectHastTag",
//                             builder: (controller) => GestureDetector(
//                               onTap: () => controller.onSelectHastTag(index),
//                               child: Container(
//                                 height: 70,
//                                 width: Get.width,
//                                 padding: EdgeInsets.only(left: 20, right: 20),
//                                 decoration: BoxDecoration(
//                                   border: Border(top: BorderSide(color: AppColor.grey_100)),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       height: 20,
//                                       width: 20,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           width: 1.5,
//                                           color: controller.selectedHashTag.contains(controller.hastTagCollection[index]) ? AppColor.primary : AppColor.grey_300,
//                                         ),
//                                         borderRadius: BorderRadius.circular(3),
//                                       ),
//                                       child: controller.selectedHashTag.contains(controller.hastTagCollection[index])
//                                           ? const Center(
//                                               child: Icon(
//                                                 size: 15,
//                                                 Icons.done_rounded,
//                                                 color: AppColor.primary,
//                                               ),
//                                             )
//                                           : const Offstage(),
//                                     ),
//                                     15.width,
//                                     RichText(
//                                       text: TextSpan(
//                                         text: "# ",
//                                         style: AppFontStyle.styleW600(AppColor.primary, 20),
//                                         children: [
//                                           TextSpan(
//                                             text: controller.hastTagCollection[index].hashTag,
//                                             style: AppFontStyle.styleW700(AppColor.black, 15),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const Spacer(),
//                                     Row(
//                                       children: [
//                                         Image.asset(
//                                           AppAsset.icViewBorder,
//                                           color: AppColor.colorTextGrey,
//                                           width: 20,
//                                         ),
//                                         5.width,
//                                         Text(
//                                           CustomFormatNumber.convert(controller.hastTagCollection[index].totalHashTagUsedCount ?? 0),
//                                           style: AppFontStyle.styleW700(AppColor.colorTextGrey, 13),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

//
// class PreviewHashTagListUi extends StatefulWidget {
//   const PreviewHashTagListUi({super.key});
//
//   @override
//   State<PreviewHashTagListUi> createState() => _PreviewHashTagListUiState();
// }
//
// class _PreviewHashTagListUiState extends State<PreviewHashTagListUi> {
//   final controller = Get.find<UploadPostController>();
//   FocusNode focusNode = FocusNode();
//
//   @override
//   void initState() {
//     focusNode.requestFocus();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(MediaQuery.of(context).viewPadding.top + 50), // status bar + (50 - Search Height)
//         child: Container(
//           color: AppColor.white,
//           padding: const EdgeInsets.only(left: 5, right: 15, bottom: 10),
//           alignment: Alignment.bottomCenter,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () => controller.onCloseHashTagPage(),
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColor.transparent,
//                   ),
//                   child: Center(child: Image.asset(AppAsset.icBack, width: 25)),
//                 ),
//               ),
//               Expanded(
//                 child: GetBuilder<UploadPostController>(
//                   id: "onSearching",
//                   builder: (controller) => SearchHashTagFieldUi(
//                     focusNode: focusNode,
//                     controller: controller.hashTagController,
//                     onEditingComplete: () => controller.onSubmitHashTag(),
//                     onChanged: (value) => controller.onChangeHashTag(),
//                     onClickClear: () => controller.onCloseHashTagPage(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: GetBuilder<UploadPostController>(
//         id: "onGetHashTag",
//         builder: (controller) => controller.isLoadingHashTag
//             ? HashTagBottomSheetShimmerUi()
//             : controller.hastTagCollection.isEmpty
//                 ? NoDataFoundUi(iconSize: 160, fontSize: 19)
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: controller.hastTagCollection.length,
//                     itemBuilder: (context, index) => GetBuilder<UploadPostController>(
//                       id: "onSelectHastTag",
//                       builder: (controller) => GestureDetector(
//                         onTap: () => controller.onSelectHastTag(index),
//                         child: Container(
//                           height: 70,
//                           width: Get.width,
//                           padding: EdgeInsets.only(left: 20, right: 20),
//                           decoration: BoxDecoration(
//                             border: Border(top: BorderSide(color: AppColor.grey_100)),
//                           ),
//                           child: Row(
//                             children: [
//                               RichText(
//                                 text: TextSpan(
//                                   text: "# ",
//                                   style: AppFontStyle.styleW600(AppColor.primary, 20),
//                                   children: [
//                                     TextSpan(
//                                       text: controller.hastTagCollection[index].hashTag,
//                                       style: AppFontStyle.styleW700(AppColor.black, 15),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const Spacer(),
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     AppAsset.icViewBorder,
//                                     color: AppColor.colorTextGrey,
//                                     width: 20,
//                                   ),
//                                   5.width,
//                                   Text(
//                                     CustomFormatNumber.convert(controller.hastTagCollection[index].totalHashTagUsedCount ?? 0),
//                                     style: AppFontStyle.styleW700(AppColor.colorTextGrey, 13),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//       ),
//     );
//   }
// }
//
// class SearchHashTagFieldUi extends StatelessWidget {
//   const SearchHashTagFieldUi({
//     super.key,
//     required this.onClickClear,
//     required this.controller,
//     required this.onChanged,
//     required this.onEditingComplete,
//     required this.focusNode,
//   });
//
//   final Callback onClickClear;
//   final TextEditingController controller;
//   final Function(String value) onChanged;
//   final Callback onEditingComplete;
//   final FocusNode focusNode;
//
//   // final Function (String value) on
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       padding: const EdgeInsets.only(left: 15, right: 12),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: AppColor.colorUnselectedIcon.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(color: AppColor.colorBorder.withOpacity(0.8)),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(
//             height: 20,
//             width: 20,
//             AppAsset.icSearch,
//             color: AppColor.black,
//           ),
//           5.width,
//           VerticalDivider(
//             indent: 12,
//             endIndent: 12,
//             color: AppColor.coloGreyText.withOpacity(0.3),
//           ),
//           5.width,
//           Expanded(
//             child: TextFormField(
//               controller: controller,
//               focusNode: focusNode,
//               cursorColor: AppColor.colorTextGrey,
//               maxLines: 1,
//               onChanged: onChanged,
//               onEditingComplete: onEditingComplete,
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.only(top: 0),
//                 border: InputBorder.none,
//                 hintText: EnumLocal.txtTypeYourHashtag.name.tr,
//                 hintStyle: AppFontStyle.styleW400(AppColor.coloGreyText, 16),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: onClickClear,
//             child: Container(
//               height: 30,
//               width: 30,
//               color: AppColor.transparent,
//               child: Center(
//                 child: Image.asset(
//                   height: 20,
//                   width: 20,
//                   AppAsset.icClose,
//                   color: AppColor.black,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
