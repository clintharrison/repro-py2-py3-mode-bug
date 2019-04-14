# py2/py3 mode bug reproduction

This uses bazelisk to pin to Bazel 0.24.1, `.bazelrc` to show the incompatible flags in use, and two scripts to reproduce the difference when `PY2` or `PY2ONLY` is used:

```
$ ./bad.sh
INFO: Analysed 13 targets (18 packages loaded, 208 targets configured).
INFO: Found 13 targets...
ERROR: /Users/clint/tmp/repro-py2-py3-mode-bug/srcs_bad/BUILD:3:1: Converting to Python 3: srcs_bad/lib2.py failed (Exit 1) 2to3 failed: error executing command bazel-out/host/bin/external/bazel_tools/tools/python/2to3 --no-diffs --nobackups --write --output-dir bazel-out/darwin-fastbuild/genfiles/srcs_bad --write-unchanged-files srcs_bad/lib2.py

Use --sandbox_debug to see verbose messages from the sandbox
INFO: Elapsed time: 0.661s, Critical Path: 0.16s
INFO: 0 processes.
FAILED: Build did NOT complete successfully
```

```
$ ./good.sh
INFO: Analysed 13 targets (1 packages loaded, 17 targets configured).
INFO: Found 13 targets...
INFO: Elapsed time: 0.685s, Critical Path: 0.50s
INFO: 2 processes: 2 darwin-sandbox.
INFO: Build completed successfully, 11 total actions
```

There should not be any dependency in PY3 mode on lib2.py, but there is still a 2to3 action generated which causes a build failure.

Switching from PY2 to PY2ONLY fixes this:

```
diff -u srcs_bad/BUILD srcs_good/BUILD
--- srcs_bad/BUILD	2019-04-13 20:28:52.000000000 -0400
+++ srcs_good/BUILD	2019-04-13 20:33:47.000000000 -0400
@@ -2,7 +2,7 @@

 py_library(
     name = "lib2",
-    srcs_version = "PY2",
+    srcs_version = "PY2ONLY",
     srcs = ["lib2.py"],
 )

@@ -16,7 +16,7 @@
     name = "py2",
     srcs = ["py2.py"],
     deps = ["lib2"],
-    srcs_version = "PY2",
+    srcs_version = "PY2ONLY",
     python_version = "PY2",
 )
```
