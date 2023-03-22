# 基于`Flex`生成的C语言词法分析器

## 编译

```bash
make
```

上面的指令会在当前文件下生成`lex`可执行文件.

## 删除临时文件

```bash
make clean
```

## 使用词法分析器(`lex`)

```bash
./lex [c_sourc_file]
```

上面的指令会在当前目录下生成一个`res.tokens`文件, 即是词法分析结果.