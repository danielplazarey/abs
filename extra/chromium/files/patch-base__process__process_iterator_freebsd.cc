--- base/process/process_iterator_freebsd.cc.orig	2014-10-10 08:54:09 UTC
+++ base/process/process_iterator_freebsd.cc
@@ -8,6 +8,10 @@
 #include <sys/sysctl.h>
 #include <unistd.h>
 
+/* getuid() */
+#include <unistd.h>
+#include <sys/types.h>
+
 #include "base/logging.h"
 #include "base/strings/string_util.h"
 
