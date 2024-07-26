import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hw_riverpod_chatting/model/chatModel.dart';
import 'package:hw_riverpod_chatting/service/supa_service.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

// List<ChatModel> mm = [
//   ChatModel(id: 1, created_at: "created_at", is_me: true, text_msg: "hello"),
//   ChatModel(id: 2, created_at: "created_at", is_me: false, text_msg: "welcome"),
//   ChatModel(id: 3, created_at: "created_at", is_me: true, text_msg: "my name")
// ];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://bdrtjkokciajmtlymrgd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJkcnRqa29rY2lham10bHltcmdkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE5MTc5MDEsImV4cCI6MjAzNzQ5MzkwMX0.SRoTdMrEH2Z5PZWnB0_sxAow_neyXFgzPLT4RPr4lbs',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key});

  //TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(debugShowCheckedModeBanner: false, home: ChatPage()),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController message;

  @override
  void initState() {
    message = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        return ref.watch(chatProvider).when(data: (data) {
          return Scaffold(
              backgroundColor: const Color.fromARGB(240, 207, 226, 172),
              appBar: AppBar(
                elevation: 10,
                backgroundColor: const Color.fromARGB(255, 6, 99, 68),
                title: const Text(
                  "Chat Riverpod",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 238, 232, 232)),
                ),
              ),
              body: Center(
                  child:
                      // StreamBuilder(
                      //  77   stream: supabase.from('Chat').select('*').asStream(),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasData) {
                      //         print(snapshot.data);
                      Padding(
                padding: const EdgeInsets.only(top: 25, right: 5, left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return data[index]
                                    .is_me //snapshot.data![index].values.elementAt(3)
                                //as bool
                                ? SizedBox(
                                    width: 100,
                                    height: 60,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Card(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 78, 219, 142),
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          width: 300,
                                          height: 100,
                                          child: Center(
                                            child: Text(data[index].text_msg
                                                // snapshot.data![index].values .elementAt(2).toString()
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 100,
                                    height: 60,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Card(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 179, 170, 170),
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          width: 300,
                                          height: 100,
                                          child: Center(
                                            child: Text(data[index].text_msg
                                                //snapshot.data![index].values.elementAt(2).toString()
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                          }),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              child: TextField(
                                controller: message,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                              )),
                        ),
                        IconButton(
                            onPressed: () async {
                              var masseg = ref.watch(msgProvider);
                              await masseg.sendMsg(ChatModel(
                                  id: 0,
                                  created_at: '26/7/2024',
                                  text_msg: message.text,
                                  is_me: true));
                              setState(() {
                                message.clear();
                              });

                              // final sn = await supabase.from('chat').insert({
                              //   "message": message.text,
                              //   "is_me": false
                              // }).select();
                              // setState(() {});
                              // message.clear();
                            },
                            icon: const Icon(Icons.send))
                      ],
                    )
                  ],
                ),
              )
                  //       } else {
                  //         return const CircularProgressIndicator();
                  //       }
                  //     },
                  //   ),
                  // ),
                  ));
        }, error: (error, stackTrace) {
          return Center(child: Text("Error msg: $error"));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        });
      },
    );
  }
}
