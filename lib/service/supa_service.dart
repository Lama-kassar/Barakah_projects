import 'package:hw_riverpod_chatting/model/chatModel.dart';

import 'package:riverpod/riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProvider = Provider((ref) => Supabase.instance.client);

abstract class Service {
  late SupabaseClient supabase;
  Future sendMsg(ChatModel cm);
}

class SupaServiceImp extends Service {
  Ref ref;

  SupaServiceImp(this.ref) {
    supabase = ref.watch(supabaseProvider);
  }

  @override
  Future sendMsg(ChatModel cm) async {
    final response = await supabase
        .from('chat')
        .insert({"text_msg": cm.text_msg, "is_me": cm.is_me})
        .select()
        .single();

    return response;
  }
}

final msgProvider = Provider<SupaServiceImp>((ref) {
  return SupaServiceImp(ref);
});

final chatProvider = StreamProvider((ref) {
  final supabase = ref.watch(supabaseProvider);
  return supabase.from('chat').stream(primaryKey: ['*']).map(
      (data) => (data).map((map) => ChatModel.fromMap(map)).toList());
});
