load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

def wrapped_py_binary(name, srcs, data = [], **kwargs):
    tar_name = "%s.tar" % name
    pkg_tar(
        name = tar_name,
        srcs = [],
    )

    native.py_binary(
        name = name,
        srcs = srcs,
        data = data + [tar_name],
        **kwargs
    )

