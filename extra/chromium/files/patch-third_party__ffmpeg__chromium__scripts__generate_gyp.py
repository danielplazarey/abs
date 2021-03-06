--- third_party/ffmpeg/chromium/scripts/generate_gyp.py.orig	2015-12-06 15:33:39.820492707 +0100
+++ third_party/ffmpeg/chromium/scripts/generate_gyp.py	2015-12-06 18:01:30.369881976 +0100
@@ -43,6 +43,8 @@
 COPYRIGHT = """# Copyright %d The Chromium Authors. All rights reserved.
 # Use of this source code is governed by a BSD-style license that can be
 # found in the LICENSE file.
+#
+# modified: cmt@burggraben.net
 
 # NOTE: this file is autogenerated by ffmpeg/chromium/scripts/generate_gyp.py
 
@@ -372,6 +374,8 @@
 
       if condition.PLATFORM == '*':
         platform_condition = None
+      elif condition.PLATFORM == 'linux':
+        platform_condition = '(OS == "%s" or os_bsd == 1)' % condition.PLATFORM
       else:
         platform_condition = 'OS == "%s"' % condition.PLATFORM
 
