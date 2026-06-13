.\" Process this file with
.\" groff -man -Tutf8 helper.1
.\"

.TH MAN-HELPER 1 "MAY 2026" General "User Manuals"
.SH NAME
MAN-HELPER \- man-pages 帮助文档

编写 `man` 手册页通常使用 **troff** 格式，配合专门的宏包（`-man` 或更现代的 `-mdoc`）。推荐新手从 `mdoc` 宏包开始，它语法更清晰、语义化。

## 1. 基本结构（mdoc 示例）

```troff
.Dd 2025-01-15        \" 文档日期
.Dt 命令名 1          \" 1=用户命令, 2=系统调用...
.Os 操作系统           \" 如 "Linux" 或 "通用"
.Sh NAME              \" 节：名称
.Nm 命令名
.Nd 简短描述
.Sh SYNOPSIS          \" 节：语法
.Nm
.Op 选项
.Ar 参数
.Sh DESCRIPTION       \" 节：详细描述
.Nm
工具的作用...
.Sh OPTIONS           \" 节：选项
.Bl -tag -width Ds    \" 开始列表，-tag 标签宽度自动
.It Fl h              \" -h 选项
显示帮助。
.It Fl v , Fl -version
显示版本。
.El                   \" 结束列表
.Sh SEE ALSO          \" 节：参见
.Xr othercmd 1
.Sh AUTHORS           \" 节：作者
.An 你的名字
```

## 2. 常用宏速查

| 宏 | 作用 | 示例 |
|----|------|------|
| `.Sh` | 节标题（大写） | `.Sh DESCRIPTION` |
| `.Ss` | 子节标题 | `.Ss Subsection` |
| `.Nm` | 命令名 | `.Nm ls` |
| `.Op` | 可选参数 | `.Op Fl l` |
| `.Ar` | 参数占位符 | `.Ar file ...` |
| `.Fl` | 选项（短横线） | `.Fl h` |
| `.Cm` | 命令/关键字 | `.Cm set` |
| `.Xr` | 交叉引用 | `.Xr man 1` |
| `.Bl -tag -width` | 带标签的列表 | 用于选项说明 |

> **列表控制**：
> - `.Bl -bullet` (圆点列表)
> - `.Bl -enum` (编号列表)
> - `.El` 结束列表，每个列表项用 `.It` 开头

## 3. 编译与查看

```bash
# 生成纯文本（预览）
mandoc -Tascii mypage.1 | less

# 生成 PDF
mandoc -Tpdf mypage.1 > mypage.pdf

# 或使用 groff
groff -mandoc -Tpdf mypage.1 > mypage.pdf

# 临时安装到系统查看（无需root，需设置 MANPATH）
mkdir -p ~/man/man1
cp mypage.1 ~/man/man1/
man -M ~/man mypage
```

## 4. 编写规范

- **节顺序**：应遵循传统顺序：NAME → SYNOPSIS → DESCRIPTION → OPTIONS → EXIT STATUS → ENVIRONMENT → FILES → SEE ALSO → HISTORY → AUTHORS
- **NAME**：必须包含 `命令名 \-\- 简短描述`，`apropos` 靠它索引。
- **缩进**：用 `.Pp` 表示段落分隔，列表内缩进自动处理。
- **转义**：反斜杠 `\` 转义特殊字符，如 `\&` 表示转义空格，`\(en` 输出短横（–）。

## 5. 完整小例子（`hello.1`）

```troff
.Dd 2025-01-15
.Dt HELLO 1
.Os Linux
.Sh NAME
.Nm hello
.Nd print a friendly greeting
.Sh SYNOPSIS
.Nm
.Op Fl h
.Op Fl n Ar name
.Sh DESCRIPTION
.Nm
prints "Hello, World!".
.Bl -tag -width Ds
.It Fl h
Show help.
.It Fl n Ar name
Greet the specified
.Ar name .
.El
.Sh SEE ALSO
.Xr echo 1
```

## 6. 进阶工具

- **`help2man`**：从 `--help` 输出自动生成粗糙的 man 页。
- **`txt2man`**：将纯文本转成 troff 格式。
- **`ronn-ng`**：用 Markdown 写 man 页（转换为 roff）。

## 7. 调试技巧

```bash
# 检查语法错误
mandoc -Tlint mypage.1

# 查看宏展开后的中间结果
groff -mandoc -Z mypage.1
```

建议先用 **`mandoc`**（BSD 系自带）测试，它的错误信息比 `groff` 友好很多。完整宏参考可查：`man mdoc` 或在线手册。

