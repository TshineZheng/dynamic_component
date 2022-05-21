// ignore_for_file: avoid_print, non_constant_identifier_names

void log(String msg) {
  if (log_debug == true) print('DynamicComponentCodegen : $msg');
}

bool log_debug = false;
