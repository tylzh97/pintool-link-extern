# Intel Pin 链接外部库
---

### PIN版本
使用`pin-3.20`版本, 可以使用以下命令下载:
```shell
wget https://software.intel.com/sites/landingpage/pintool/downloads/pin-3.20-98437-gf02b61307-gcc-linux.tar.gz
```

### 编译与测试
编译PINTOOL依赖环境变量`PIN_ROOT`, 首先执行以下命令:
```shell
export PIN_ROOT=<PATH-TO-PIN>
# 如 export PIN_ROOT=${HOME}/Tools/pin
```
使用以下命令编译, 清除, 测试项目
```shell
make clean
make all
make test
```


### 目录结构
```
├── extfunc_src     # 外部库
│   ├── extfunc.c
│   ├── include
│   │   └── rhruntime.h
│   ├── main.c
│   └── Makefile
├── Makefile        # 主 Makefile, 会调用子目录的 Makefile
├── README.md
└── rhtool_src      # 目标 PINTOOL
    ├── makefile
    ├── makefile.rules
    └── MyPinTool.cpp
```

### 一些注意事项
1. 外部库如果使用C语言编写, 在头文件中需要定义`extern "C"`, 详情如下:
```C
#ifdef __cplusplus
extern "C" {
#endif

void func();

#ifdef __cplusplus
}
#endif

```

2. 编译外部库时, 需要添加 `-fPIC` 选项, 生成位置无关代码, 才能用于外部链接
3. PINTOOL的链接过程使用了`-nostdlib`选项, 因此外部库中不允许使用`stdio`的相关库
4. 编译外部库时, 使用`-I<PATH-TO-INCLUDE>`指定头文件目录
5. 链接外部库时, 使用`-L<PATH-TO-LIBRARY>`指定外部库目录, 使用`-l<libname>`指定库名称`lib<libname>.a`

### 对 PINTOOL 中的 makefile.rules 进行修改
```makefile
# 最终生成一个 TOOL, 这个工具的名称
TOOL_ROOTS := MyPinTool

# TOOL_CXXFLAGS += -Wno-deprecated-declarations -Wl,-whole-archive -Wl,--rpath=$(LIBCAP_PATH)
LIBEXT_INCLUDE_PATH	= $(realpath ../extfunc_src/include)
LIBEXT_PATH	= $(realpath ../extfunc_src)

TOOL_CXXFLAGS += -I$(LIBEXT_INCLUDE_PATH) -L$(LIBEXT_PATH)
TOOL_LIBS += -L$(LIBEXT_PATH) -lextfunc

```

