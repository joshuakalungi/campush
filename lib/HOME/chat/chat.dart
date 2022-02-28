// ignore_for_file: prefer_equal_for_default_values

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelListPage extends StatelessWidget {
  const ChannelListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChannelsBloc(
        child: ChannelListView(
          filter: Filter.in_(
            'members',
            [StreamChat.of(context).currentUser!.id],
          ),
          sort: const [SortOption('last_message_at')],
          limit: 20,
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  ChannelPage({
    Key? key,
  }) : super(key: key);

  GlobalKey<MessageInputState> _messageInputKey = GlobalKey();

  String _buildMapAttachment(String lat, String long) {
    var baseURL = 'https://maps.googleapis.com/maps/api/staticmap?';
    var url = Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        port: 443,
        path: '/maps/api/staticmap',
        queryParameters: {
          'center': '${lat},${long}',
          'zoom': '18',
          'size': '700x500',
          'maptype': 'roadmap',
          'key': 'AIzaSyCX7vI-UAjpQsj4o2cjlm4VHKlwntoFXRs',
          'markers': 'color:red|${lat},${long}'
        });

    return url.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(
              messageBuilder: (context, details, messages, defaultMessage) {
                return defaultMessage.copyWith(
                  customAttachmentBuilders: {
                    'location': (context, message, attachments) {
                      final attachmentWidget = Image.network(
                        _buildMapAttachment(
                          attachments[0].extraData['latitude'].toString(),
                          attachments[0].extraData['longitude'].toString(),
                        ),
                      );
                      return wrapAttachmentWidget(
                        context,
                        attachmentWidget,
                        RoundedRectangleBorder(),
                        true,
                      );
                    }
                  },
                );
              },
            ),
          ),
          MessageInput(
            key: _messageInputKey,
            actions: [
              InkWell(
                child: Icon(
                  Icons.location_history,
                  size: 20.0,
                  //color: StreamChatTheme.of(context).colorTheme.grey,
                ),
                onTap: () {
                  _determinePosition().then((value) {
                    _messageInputKey.currentState!.addAttachment(
                      Attachment(
                        uploadState: UploadState.success(),
                        type: 'location',
                        extraData: {
                          'latitude': value.latitude.toString(),
                          'longitude': value.longitude.toString(),
                        },
                      ),
                    );
                  }).catchError((err) {
                    print('Error getting location!');
                  });
                },
              ),
            ],
            attachmentThumbnailBuilders: {
              'location': (context, attachment) {
                return Image.network(
                  _buildMapAttachment(
                    attachment.extraData['latitude'].toString(),
                    attachment.extraData['longitude'].toString(),
                  ),
                );
              },
            },
          ),
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
