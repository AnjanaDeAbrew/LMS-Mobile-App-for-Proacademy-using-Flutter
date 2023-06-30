import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:proacademy_lms/providers/chat/chat_provider.dart';
import 'package:proacademy_lms/utils/asset_constants.dart';
import 'package:proacademy_lms/utils/util_functions.dart';
import 'package:provider/provider.dart';

class CustomMessageBar extends StatefulWidget {
  final bool replying;
  final String replyingTo;
  final List<Widget> actions;
  final Color replyWidgetColor;
  final Color replyIconColor;
  final Color replyCloseColor;
  final Color messageBarColor;
  final Color sendButtonColor;
  final void Function(String)? onTextChanged;
  final void Function(String)? onSend;
  final void Function()? onTapCloseReply;

  /// [CustomMessageBar] constructor
  ///
  ///
  const CustomMessageBar({
    super.key,
    this.replying = false,
    this.replyingTo = "",
    this.actions = const [],
    this.replyWidgetColor = const Color(0xffF4F4F5),
    this.replyIconColor = Colors.blue,
    this.replyCloseColor = Colors.black12,
    this.messageBarColor = const Color(0xffF4F4F5),
    this.sendButtonColor = Colors.black,
    this.onTextChanged,
    this.onSend,
    this.onTapCloseReply,
  });

  @override
  State<CustomMessageBar> createState() => _CustomMessageBarState();
}

class _CustomMessageBarState extends State<CustomMessageBar> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;
  File image = File("");
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          widget.replying
              ? Container(
                  color: widget.replyWidgetColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.reply,
                        color: widget.replyIconColor,
                        size: 24,
                      ),
                      Expanded(
                        child: Text(
                          'Re : ${widget.replyingTo}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                        onTap: widget.onTapCloseReply,
                        child: Icon(
                          Icons.close,
                          color: widget.replyCloseColor,
                          size: 24,
                        ),
                      ),
                    ],
                  ))
              : Container(),
          widget.replying
              ? Container(
                  height: 1,
                  color: Colors.grey.shade300,
                )
              : Container(),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 20),
                  focusNode: focusNode,
                  onChanged: widget.onTextChanged,
                  decoration: InputDecoration(
                    hintText: "Message",
                    border: InputBorder.none,
                    hintMaxLines: 1,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    prefixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                focusNode.unfocus();
                                focusNode.canRequestFocus = false;
                                emojiShowing = !emojiShowing;
                              });
                            },
                            child: Image.asset(
                              AssetConstants.emoji,
                              width: 20,
                              color: const Color.fromARGB(255, 38, 38, 38),
                            )),
                      ],
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // added line
                        mainAxisSize: MainAxisSize.min,
                        // added line
                        children: [
                          InkWell(
                              onTap: () {
                                Provider.of<ChatProvider>(context,
                                        listen: false)
                                    .getImageFromCamera(context);
                              },
                              child: Image.asset(
                                AssetConstants.camera,
                                width: 23,
                                color: const Color.fromARGB(255, 38, 38, 38),
                              )),
                          const SizedBox(width: 12),
                          InkWell(
                              onTap: () {
                                Provider.of<ChatProvider>(context,
                                        listen: false)
                                    .getImageFromGallery(context);
                              },
                              child: Image.asset(
                                AssetConstants.gallery,
                                width: 22,
                                color: const Color.fromARGB(255, 38, 38, 38),
                              )),
                        ],
                      ),
                    ),
                    iconColor: Colors.grey,
                    hintStyle: const TextStyle(
                      fontSize: 17,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 241, 241, 241),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                          width: 0.2, color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
              ...widget.actions,
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: InkWell(
                  onTap: () {
                    if (_controller.text.trim() != '') {
                      if (widget.onSend != null) {
                        widget.onSend!(_controller.text.trim());
                      }
                      _controller.clear();
                    }
                  },
                  child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: Image.asset(
                        AssetConstants.send,
                        width: 22,
                      )),
                ),
              ),
            ],
          ),
          Offstage(
            offstage: !emojiShowing,
            child: SizedBox(
                height: 250,
                child: EmojiPicker(
                  textEditingController: _controller,
                  config: Config(
                    columns: 7,
                    emojiSizeMax: 32 *
                        (foundation.defaultTargetPlatform == TargetPlatform.iOS
                            ? 1.30
                            : 0.8),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    gridPadding: EdgeInsets.zero,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    backspaceColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    recentsLimit: 28,
                    replaceEmojiOnLimitExceed: false,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                    loadingIndicator: const SizedBox.shrink(),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL,
                    checkPlatformCompatibility: true,
                  ),
                )),
          ),
        ],
      ),
      onWillPop: () {
        if (emojiShowing) {
          setState(() {
            emojiShowing = false;
          });
        } else {
          UtilFunctions.goBack(context);
        }
        return Future.value(false);
      },
    );
  }
}
