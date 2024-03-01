import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibc_telecom/widget/my_button.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class SpeedTestScreen extends StatefulWidget {
  const SpeedTestScreen({Key? key}) : super(key: key);

  @override
  State<SpeedTestScreen> createState() => _SpeedTestScreenState();
}

class _SpeedTestScreenState extends State<SpeedTestScreen> {
  final internetSpeedTest = FlutterInternetSpeedTest()..enableLog();

  bool _testInProgress = false;
  double _downloadRate = 0;
  double _uploadRate = 0;
  String _downloadProgress = '0';
  String _uploadProgress = '0';
  int _downloadCompletionTime = 0;
  int _uploadCompletionTime = 0;
  bool _isServerSelectionInProgress = false;

  String? _ip;
  String? _asn;
  String? _isp;

  String _unitText = 'Mbps';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testi i shpejtësisë'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: height * .010,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Testi i shpejtësisë",
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 1,
                  ),
                  //
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'ping',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).highlightColor),
                      ),
                      // Text('Progress: $_downloadProgress%'),
                      Text(
                        _asn?.toUpperCase() ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).errorColor),
                      ),
                      // if (_downloadCompletionTime > 0)
                      //   Text(
                      //       'Time taken: ${(_downloadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Serveri',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).highlightColor),
                      ),
                      // Text('Progress: $_downloadProgress%'),
                      Text(
                        _isp?.toUpperCase() ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).errorColor),
                      ),
                      // if (_downloadCompletionTime > 0)
                      //   Text(
                      //       'Time taken: ${(_downloadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * .010,
              ),
              SizedBox(
                height: height * .010,
              ),
              Container(
                  child: SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                    minimum: 0,
                    maximum: 1024,
                    ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0,
                          endValue: _downloadRate,
                          color: Theme.of(context).errorColor,
                          startWidth: 20,
                          endWidth: 20),
                      GaugeRange(
                          startValue: _downloadRate,
                          endValue: 1024,
                          color: Color(0xfff1c4c6),
                          startWidth: 20,
                          endWidth: 20,
                          sizeUnit: GaugeSizeUnit.logicalPixel),
                      // GaugeRange(startValue: 100,endValue: 150,color: Colors.red)
                    ],
                    showAxisLine: true,
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: _downloadRate,
                        needleColor: Theme.of(context).highlightColor,
                        needleEndWidth: 15,
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Container(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Shpejtësia e shkarkimit",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).errorColor)),
                              Text("$_downloadRate $_unitText",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).highlightColor)),
                            ],
                          )),
                          angle: 90,
                          positionFactor: 0.5)
                    ])
              ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          size: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Shkarko',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).errorColor),
                            ),
                            // Text('Progress: $_downloadProgress%'),
                            Text(
                                '${_downloadRate.toStringAsFixed(2)} $_unitText',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).highlightColor)),
                            // if (_downloadCompletionTime > 0)
                            //   Text(
                            //       'Time taken: ${(_downloadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          size: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Ngarkoni',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).errorColor),
                            ),
                            // Text('Progress: $_uploadProgress%'),
                            Text('${_uploadRate.toStringAsFixed(2)} $_unitText',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).highlightColor)),
                            // if (_uploadCompletionTime > 0)
                            //   Text(
                            //       'Time taken: ${(_uploadCompletionTime / 1000).toStringAsFixed(2)} sec(s)'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .020,
              ),
              !_testInProgress ?
                Center(
                  child: MyButton(
                    width: MediaQuery.of(context).size.width * .6,
                    title: "KONTROLLO SHPEJTËSINË",
                    onTap: () async {
                      reset();
                      await internetSpeedTest.startTesting(
                          // useFastApi: true,
                          // downloadTestServer: "http://speedtest.ftp.otenet.gr/",
                          // downloadTestServer: "https://fast.com/",
                          //   downloadTestServer: "https://www.speedtest.net/",
                          //   uploadTestServer: "https://www.speedtest.net/",


                          onStarted: () {
                            setState(() => _testInProgress = true);
                          },
                          onCompleted:
                              (TestResult download, TestResult upload) {
                            if (kDebugMode) {
                              print(
                                  'the transfer rate ${download.transferRate}, ${upload.transferRate}');
                            }
                            setState(() {
                              _downloadRate = download.transferRate;
                              _unitText = download.unit == SpeedUnit.kbps
                                  ? 'Kbps'
                                  : 'Mbps';
                              _downloadProgress = '100';
                              _downloadCompletionTime =
                                  download.durationInMillis;
                            });
                            setState(() {
                              _uploadRate = upload.transferRate;
                              _unitText = upload.unit == SpeedUnit.kbps
                                  ? 'Kbps'
                                  : 'Mbps';
                              _uploadProgress = '100';
                              _uploadCompletionTime = upload.durationInMillis;

                            });
                            setState(() => _testInProgress = false);
                          },
                          onProgress: (double percent, TestResult data) {
                            if (kDebugMode) {
                              print(
                                  'the transfer rate $data.transferRate, the percent $percent');
                            }
                            setState(() {
                              _unitText =
                                  data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                              if (data.type == TestType.download) {
                                _downloadRate = data.transferRate;
                                _downloadProgress = percent.toStringAsFixed(2);
                              } else {
                                _uploadRate = data.transferRate;
                                _uploadProgress = percent.toStringAsFixed(2);
                              }
                            });
                          },
                          onError:
                              (String errorMessage, String speedTestError) {
                            if (kDebugMode) {
                              print(
                                  'the errorMessage $errorMessage, the speedTestError $speedTestError');
                            }
                            reset();

                          },
                          onDefaultServerSelectionInProgress: () {
                            setState(() {
                              _isServerSelectionInProgress = true;
                            });
                          },
                          onDefaultServerSelectionDone: (Client? client) {
                            setState(() {
                              _isServerSelectionInProgress = false;
                              _ip = client?.ip;
                              _asn = client?.asn;
                              _isp = client?.isp;
                            });
                          },
                          onDownloadComplete: (TestResult data) {
                            setState(() {
                              _downloadRate = data.transferRate;
                              _unitText =
                                  data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                              _downloadCompletionTime = data.durationInMillis;
                            });

                          },
                          onUploadComplete: (TestResult data) {
                            setState(() {
                              _uploadRate = data.transferRate;
                              _unitText =
                                  data.unit == SpeedUnit.kbps ? 'Kbps' : 'Mbps';
                              _uploadCompletionTime = data.durationInMillis;
                              setState(() => _testInProgress = false);
                            });

                          },
                          onCancel: () {
                            // internetSpeedTest.cancelTest();
                            // setState(() => _testInProgress = true);
                            reset();
                          });
                    },
                  ),
                ) :

                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                SizedBox(height: 10,),

                if(_testInProgress)
                Center(
                  child: MyButton(
                    width: MediaQuery.of(context).size.width * .6,
                    title: "Cancel",
                    onTap: () async {
                      _testInProgress= false;
                      reset();
                      await internetSpeedTest.cancelTest();


                    },
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }

  void reset() {
    setState(() {
      {
        _testInProgress = false;
        _downloadRate = 0;
        _uploadRate = 0;
        _downloadProgress = '0';
        _uploadProgress = '0';
        _unitText = 'Mbps';
        _downloadCompletionTime = 0;
        _uploadCompletionTime = 0;

        _ip = null;
        _asn = null;
        _isp = null;
      }
    });
  }
}






/*import 'package:flutter/material.dart';
import 'package:konnect_speed_test/speed_test_lib.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class SpeedTestScreen extends StatefulWidget {
  const SpeedTestScreen({super.key});

  @override
  State<SpeedTestScreen> createState() => _SpeedTestScreenState();
}

class _SpeedTestScreenState extends State<SpeedTestScreen> with SpeedtestHandler {
  num upload = 0;
  double download = 0;
  num jitter = 0;
  num ping = 0;
  Map server = {};
  late SpeedTest speedTest;
  @override
  void initState() {
    speedTest = SpeedTest(speedtestHandler: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Jitter ${jitter}"),
              Text("download ${download}"),
              Text("upload ${upload}"),
              Text("ping ${ping}"),
              Text("server ${server}"),
              SizedBox(
                height: 10,
              ),

              Container(
                  child: SfRadialGauge(axes: <RadialAxis>[
                    RadialAxis(
                        minimum: 0,
                        maximum: 1024,
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: download,
                              color: Theme.of(context).errorColor,
                              startWidth: 20,
                              endWidth: 20),
                          GaugeRange(
                              startValue: download,
                              endValue: 1024,
                              color: Color(0xfff1c4c6),
                              startWidth: 20,
                              endWidth: 20,
                              sizeUnit: GaugeSizeUnit.logicalPixel),
                          // GaugeRange(startValue: 100,endValue: 150,color: Colors.red)
                        ],
                        showAxisLine: true,
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            value: download,
                            needleColor: Theme.of(context).highlightColor,
                            needleEndWidth: 15,
                          )
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              widget: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Shpejtësia e shkarkimit",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).errorColor)),
                                      Text("$download ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).highlightColor)),
                                    ],
                                  )),
                              angle: 90,
                              positionFactor: 0.5)
                        ])
                  ])),

              SizedBox(
                height: 10,
              ),




              TextButton(
                  onPressed: () {
                    speedTest.start();
                  },
                  child: Text("start"))
            ],
          ),
        ),
      ),
    );
  }

  @override
  onCriticalFailure(criticalFailure) {
    // TODO: implement onCriticalFailure
    throw UnimplementedError();
  }

  @override
  onDownloadUpdate(downlodData) {
    if (downlodData is Map) {
      download = downlodData["download"];
      // {download: 3.4561273631840796; progress: 0.014066666666666667;}
    }
    setState(() {});
    print(downlodData.runtimeType);
    // TODO: implement onDownloadUpdate
    //throw UnimplementedError();
  }

  @override
  onEnd() {
    // TODO: implement onEnd
    //throw UnimplementedError();
  }

  @override
  onIPInfoUpdate(ipInfo) {
    // TODO: implement onIPInfoUpdate
    //throw UnimplementedError();
  }

  @override
  onPingJitterUpdate(pingJitterUpdate) {
    // TODO: implement onPingJitterUpdate
    //throw UnimplementedError();
  }

  @override
  onTestIDReceived(testIdReceived) {
    if (testIdReceived is Map) {
      download = testIdReceived["upload"];
      //{download: 3.4561273631840796, progress: 0.014066666666666667}
    }
  }

  @override
  onUploadUpdate(uploadData) {
    if (uploadData is Map) {
      upload = uploadData["upload"];
      //{download: 3.4561273631840796, progress: 0.014066666666666667}
    }
    setState(() {});
    // TODO: implement onUploadUpdate
    //throw UnimplementedError();
  }

  @override
  serverSelected(data) {
    //print("server selected ${data.}");

    if (data is Map) {
      server = data;
      //{download: 3.4561273631840796, progress: 0.014066666666666667}
    }
    setState(() {});

    print("server selected ${data}");
    // TODO: implement serverSelected
  }
} */