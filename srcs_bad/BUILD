load("//:rule.bzl", "wrapped_py_binary")

py_library(
    name = "lib2",
    srcs_version = "PY2",
    srcs = ["lib2.py"],
)

py_library(
    name = "lib3",
    srcs_version = "PY3",
    srcs = ["lib3.py"],
)

wrapped_py_binary(
    name = "py2",
    srcs = ["py2.py"],
    deps = ["lib2"],
    srcs_version = "PY2",
    python_version = "PY2",
)

wrapped_py_binary(
    name = "py3",
    srcs = ["py3.py"],
    deps = ["lib3"],
    srcs_version = "PY3",
    python_version = "PY3",
)
