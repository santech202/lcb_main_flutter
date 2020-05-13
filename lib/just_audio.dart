import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:liceucubrio/main.dart';
import 'package:liceucubrio/util/ui_components.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  String albumName = 'Lectii Audio - Limba Romana';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer _player;

  /// playlist with all audios
  ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: [
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/aci_sosi.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Aci sosi pe vremuri",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/baltagul.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Baltagul",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/cel_mai_iubit.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Cel mai iubit dintre pamanteni",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/din_ceas.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Din ceas dedus",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/enigma.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Enigma Otiliei",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/eu_nu.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Eu nu strivesc",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/fantana.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Fantana dintre plopi",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/flori.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Flori de mucigai",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/harap.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Harap Alb",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/in_vreme.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "In vreme de razboi",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/ion.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Ion",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/iona.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Iona",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/la_tiganci.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "La tiganci",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/lapusneanul.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Alexandru Lapusneanul",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/leoaica.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Leoaica tanara, iubirea",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/luceafarul.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Luceafarul",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/maitreyi.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Maitreyi",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/luceafarul.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Luceafarul",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/mara.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Mara",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/morometii.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Morometii",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/o_noapte.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "O noapte furtunoasa",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/o_scrisoare.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "O scrisoare pierduta",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/patul.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Patul lui Procust",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/moara.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Moara cu Noroc",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/testament.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Testament",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/riga.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Riga Crypto",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/plumb.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Plumb",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/patul.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Patul lui Procust",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          "https://raw.githubusercontent.com/smobx1/smobx1.github.io/master/liceu_cu_brio/ultima_noapte.m4a"),
      tag: AudioMetadata(
        album: 'Lectii Audio - Limba Romana',
        title: "Ultima Noapte de Dragoste",
        artwork:
            "https://github.com/smobx1/smobx1.github.io/blob/master/liceu_cu_brio/_logo1024.png?raw=true",
      ),
    ),
  ]);

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      await _player.load(_playlist);
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print("An error occured $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: basicAppBar(context, 'Lectii Audio', '/home'),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder<SequenceState>(
                  stream: _player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence?.isEmpty ?? true) return SizedBox();
                    final metadata = state.currentSource.tag as AudioMetadata;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Center(child: Image.network(metadata.artwork)),
                          ),
                        ),
                        Text(metadata.album ?? '',
                            style: Theme.of(context).textTheme.headline6),
                        Text(metadata.title ?? ''),
                      ],
                    );
                  },
                ),
              ),
              ControlButtons(_player),
              StreamBuilder<Duration>(
                stream: _player.durationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  return StreamBuilder<Duration>(
                    stream: _player.positionStream,
                    builder: (context, snapshot) {
                      var position = snapshot.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }
                      return SeekBar(
                        duration: duration,
                        position: position,
                        onChangeEnd: (newPosition) {
                          _player.seek(newPosition);
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  StreamBuilder<LoopMode>(
                    stream: _player.loopModeStream,
                    builder: (context, snapshot) {
                      final loopMode = snapshot.data ?? LoopMode.off;
                      const icons = [
                        Icon(Icons.repeat, color: Colors.grey),
                        Icon(Icons.repeat, color: Colors.orange),
                        Icon(Icons.repeat_one, color: Colors.orange),
                      ];
                      const cycleModes = [
                        LoopMode.off,
                        LoopMode.all,
                        LoopMode.one,
                      ];
                      final index = cycleModes.indexOf(loopMode);
                      return IconButton(
                        icon: icons[index],
                        onPressed: () {
                          _player.setLoopMode(cycleModes[
                              (cycleModes.indexOf(loopMode) + 1) %
                                  cycleModes.length]);
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Playlist",
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: _player.shuffleModeEnabledStream,
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: shuffleModeEnabled
                            ? Icon(Icons.shuffle, color: Colors.orange)
                            : Icon(Icons.shuffle, color: Colors.grey),
                        onPressed: () {
                          _player.setShuffleModeEnabled(!shuffleModeEnabled);
                        },
                      );
                    },
                  ),
                ],
              ),
              Container(
                height: 240.0,
                child: StreamBuilder<SequenceState>(
                  stream: _player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    final sequence = state?.sequence ?? [];
                    return ListView.builder(
                      itemCount: sequence.length,
                      itemBuilder: (context, index) => Material(
                        color: index == state.currentIndex
                            ? Colors.grey.shade300
                            : null,
                        child: ListTile(
                          title: Text(sequence[index].tag.title),
                          onTap: () {
                            _player.seek(Duration.zero, index: index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            _showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        StreamBuilder<SequenceState>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: player.hasPrevious ? player.seekToPrevious : null,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero, index: 0),
              );
            }
          },
        ),
        StreamBuilder<SequenceState>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: player.hasNext ? player.seekToNext : null,
          ),
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              _showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Slider(
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
              widget.duration.inMilliseconds.toDouble()),
          onChanged: (value) {
            setState(() {
              _dragValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged(Duration(milliseconds: value.round()));
            }
          },
          onChangeEnd: (value) {
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd(Duration(milliseconds: value.round()));
            }
            _dragValue = null;
          },
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("$_remaining")
                      ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

_showSliderDialog({
  BuildContext context,
  String title,
  int divisions,
  double min,
  double max,
  String valueSuffix = '',
  Stream<double> stream,
  ValueChanged<double> onChanged,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;

  AudioMetadata({this.album, this.title, this.artwork});
}
