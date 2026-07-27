# README

## 基础操作

| 快捷键 | 命令 | 功能描述 |
|:---|:---|:---|
| `$mod+Return` | `exec alacritty` | 启动 Alacritty 终端 |
| `$mod+Shift+q` | `kill` | 关闭当前聚焦的窗口 |
| `$mod+Shift+c` | `reload` | 重新加载 i3 配置文件 |
| `$mod+Shift+r` | `restart` | 重启 i3 进程（保留布局） |
| `$mod+Shift+e` | `exec i3-nagbar ...` | 退出 i3（显示确认对话框） |

## 窗口焦点移动

| 快捷键 | 命令 | 功能描述 |
|:---|:---|:---|
| `$mod+Left` | `focus left` | 焦点向左移动 |
| `$mod+Down` | `focus down` | 焦点向下移动 |
| `$mod+Up` | `focus up` | 焦点向上移动 |
| `$mod+Right` | `focus right` | 焦点向右移动 |
| `$mod+a` | `focus parent` | 焦点移动到父容器 |

## 窗口移动（位置）

| 快捷键 | 命令 | 功能描述 |
|:---|:---|:---|
| `$mod+Shift+Left` | `move left` | 将当前窗口向左移动 |
| `$mod+Shift+Down` | `move down` | 将当前窗口向下移动 |
| `$mod+Shift+Up` | `move up` | 将当前窗口向上移动 |
| `$mod+Shift+Right` | `move right` | 将当前窗口向右移动 |

## 布局与模式

| 快捷键 | 命令 | 功能描述 |
|:---|:---|:---|
| `$mod+h` | `split h` | 在当前容器中创建水平分割 |
| `$mod+v` | `split v` | 在当前容器中创建垂直分割 |
| `$mod+f` | `fullscreen toggle` | 切换当前窗口的全屏模式 |
| `$mod+s` | `layout stacking` | 切换为堆叠布局 |
| `$mod+w` | `layout tabbed` | 切换为标签页布局 |
| `$mod+e` | `layout toggle split` | 在分裂、堆叠、标签页布局间循环切换 |
| `$mod+Shift+space` | `floating toggle` | 切换当前窗口的浮动/平铺状态 |
| `$mod+r` | `mode "resize"` | 进入窗口大小调整模式 |

## Resize 模式内部（Vim 风格）

| 快捷键 | 命令 | 功能描述 |
|:---|:---|:---|
| `h` | `resize shrink width 10 px or 10 ppt` | 缩小窗口宽度 |
| `j` | `resize grow height 10 px or 10 ppt` | 增加窗口高度 |
| `k` | `resize shrink height 10 px or 10 ppt` | 缩小窗口高度 |
| `l` | `resize grow width 10 px or 10 ppt` | 增加窗口宽度 |
| `Left` | `resize shrink width 10 px or 10 ppt` | 缩小窗口宽度（方向键） |
| `Down` | `resize grow height 10 px or 10 ppt` | 增加窗口高度（方向键） |
| `Up` | `resize shrink height 10 px or 10 ppt` | 缩小窗口高度（方向键） |
| `Right` | `resize grow width 10 px or 10 ppt` | 增加窗口宽度（方向键） |
| `Return` / `Escape` / `$mod+r` | `mode "default"` | 退出 resize 模式 |

## 工作区切换

| 快捷键 | 命令 | 功能描述 |
|:---|:---|:---|
| `$mod+1` | `workspace number 1` | 切换到工作区 1 |
| `$mod+2` | `workspace number 2` | 切换到工作区 2 |
| `$mod+3` | `workspace number 3` | 切换到工作区 3 |
| `$mod+4` | `workspace number 4` | 切换到工作区 4 |
| `$mod+5` | `workspace number 5` | 切换到工作区 5 |
| `$mod+Ctrl+Left` | `workspace prev` | 切换到上一个工作区 |
| `$mod+Ctrl+Right` | `workspace next` | 切换到下一个工作区 |

## 移动窗口到工作区

| 快捷键 | 命令 | 功能描述 |
|:---|:---|:---|
| `$mod+Shift+1` | `move container to workspace number 1` | 移动窗口到工作区 1 |
| `$mod+Shift+2` | `move container to workspace number 2` | 移动窗口到工作区 2 |
| `$mod+Shift+3` | `move container to workspace number 3` | 移动窗口到工作区 3 |
| `$mod+Shift+4` | `move container to workspace number 4` | 移动窗口到工作区 4 |
| `$mod+Shift+5` | `move container to workspace number 5` | 移动窗口到工作区 5 |
| `$mod+Ctrl+Shift+1` | `move container to workspace number 1; workspace number 1` | 移动窗口到工作区 1 并跟随 |
| `$mod+Ctrl+Shift+2` | `move container to workspace number 2; workspace number 2` | 移动窗口到工作区 2 并跟随 |
| `$mod+Ctrl+Shift+3` | `move container to workspace number 3; workspace number 3` | 移动窗口到工作区 3 并跟随 |
| `$mod+Ctrl+Shift+4` | `move container to workspace number 4; workspace number 4` | 移动窗口到工作区 4 并跟随 |
| `$mod+Ctrl+Shift+5` | `move container to workspace number 5; workspace number 5` | 移动窗口到工作区 5 并跟随 |

## 应用程序启动器（Rofi）

| 快捷键 | 命令 | 功能描述 |
|:---|:---|:---|
| `$mod+d` | `rofi -show drun -show-icons` | 应用启动器（显示已安装的应用程序） |
| `$mod+Tab` | `rofi -show window -show-icons` | 窗口切换器 |
| `$mod+Shift+d` | `rofi -show run` | 运行命令模式 |
| `$mod+space` | `rofi -show combi -combi-modi "window#drun#run" -show-icons` | 混合模式启动器 |
| `$mod+Shift+f` | `rofi -show file-browser` | 文件浏览器 |
| `$mod+Shift+s` | `rofi -show ssh` | SSH 连接管理 |

## 系统与多媒体

| 快捷键 | 命令 | 功能描述 |
|:---|:---|:---|
| `XF86AudioRaiseVolume` | `pactl set-sink-volume @DEFAULT_SINK@ +5%` | 提高音量 |
| `XF86AudioLowerVolume` | `pactl set-sink-volume @DEFAULT_SINK@ -5%` | 降低音量 |
| `XF86AudioMute` | `pactl set-sink-mute @DEFAULT_SINK@ toggle` | 静音/取消静音主音量 |
| `XF86AudioMicMute` | `pactl set-source-mute @DEFAULT_SOURCE@ toggle` | 静音/取消静音麦克风 |
| `XF86MonBrightnessUp` | `brightnessctl set +5%` | 提高屏幕亮度 |
| `XF86MonBrightnessDown` | `brightnessctl set 5%-` | 降低屏幕亮度 |
| `$mod+l` | `i3lock -i ...` | 锁定屏幕 |

## 其他功能

| 快捷键 | 命令 | 功能描述 |
|:---|:---|:---|
| `floating_modifier $mod` | - | 按住 `Mod4` 键可以拖动浮动窗口 |
| `tiling_drag modifier titlebar` | - | 可以从标题栏拖动平铺窗口 |

