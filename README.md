# Suzu · AI Agent for Android

一个界面风格参考 Shizuku、可自定义 OpenAI 格式 API 的轻量 Android AI Agent 客户端。
所有图标均为矢量图形（VectorDrawable / SVG path），**不含任何 emoji**。

## 特性

- **Shizuku 风格界面**：顶部大标题 + 状态大卡（28dp 圆角、secondaryContainer 背景）+ 圆形图标卡片列表
- **任意 OpenAI 兼容接口**：自定义 Base URL / API Key / 模型，支持一键拉取 `/v1/models` 列表
- **流式输出**：SSE 逐字返回，可随时中断
- **Agent 模式**：内置 `current_time` / `web_search` / `fetch_url` 三个本地工具，OpenAI function calling 格式，最多 6 轮工具调用
- **外观**：浅色 / 深色 / 跟随系统、纯黑（OLED）、Android 12+ 动态取色
- **零第三方网络依赖**：仅使用 `HttpURLConnection` + `org.json`，依赖只有 AndroidX 与 Material Components
- 会话本地保存（`chat.json`），长按消息可复制，聊天内容支持代码块 / 粗体 / 列表的轻量渲染

## 构建 APK

### 方式一：Android Studio（推荐）

1. 用 Android Studio（Koala 及以上）**Open** 本目录
2. 等待 Gradle 同步完成（需要 JDK 17，首次会自动下载 Gradle 与依赖）
3. `Build → Build Bundle(s) / APK(s) → Build APK(s)`
4. 产物：`app/build/outputs/apk/debug/app-debug.apk`

### 方式二：GitHub Actions（云端构建，无需本地环境）

1. 把本目录推到 GitHub 仓库
2. `Actions → Build APK → Run workflow`
3. 运行结束后在 Artifacts 里下载 `suzu-apk`（含 debug 与 release 两个包）

> release 包使用本地已有签名；如无签名配置，Gradle 会输出未签名的 release APK，安装前需自行签名。

### 方式三：命令行

```bash
export JAVA_HOME=/path/to/jdk17
./generate-wrapper.sh          # 生成 gradle-wrapper.jar（需本机已有 gradle）
./gradlew :app:assembleDebug
```

> 仓库内已包含 `gradle/wrapper/gradle-wrapper.properties`，但不含二进制的 `gradle-wrapper.jar`，
> 所以要先执行一次 `./generate-wrapper.sh`（或直接让 Android Studio 打开项目自动同步）。

## 配置说明

| 项目 | 说明 | 默认值 |
| --- | --- | --- |
| Base URL | 形如 `https://api.openai.com/v1`，也支持 `http://` 明文（如局域网 Ollama） | `https://api.openai.com/v1` |
| API Key | 以 `Authorization: Bearer <key>` 发送，可留空 | 空 |
| 模型 | 任意字符串，可用“获取模型列表”选择 | `gpt-4o-mini` |
| 温度 / 最大长度 | 透传给接口 | 0.7 / 2048 |
| 流式输出 | 开启后逐字输出 | 开 |

已验证可用于 OpenAI、DeepSeek、Moonshot、Groq、OpenRouter、vLLM、Ollama（`http://host:11434/v1`）、One API / New API 等兼容端点。

## Agent 与工具

在首页“工具”页可以开关：

- `current_time`：读取设备当前日期、时间、时区
- `web_search`：经 DuckDuckGo HTML 端点检索，返回标题与摘要
- `fetch_url`：抓取指定 URL 正文并去除标签

打开 **Agent 模式** 后，模型可多轮调用这些工具（此时自动切换为非流式请求）。若接口不支持 `tools` 参数，请关闭 Agent 模式。

## 项目结构

```
app/src/main/java/app/suzu/agent/
├── MainActivity.kt      首页（Shizuku 风格卡片）
├── ChatActivity.kt      聊天页 + 消息适配器
├── SettingsActivity.kt  偏好设置（PreferenceFragmentCompat）
├── ToolsActivity.kt     工具开关
├── OpenAIClient.kt      /chat/completions 与 /models（含 SSE 解析）
├── Tools.kt             本地工具定义与执行
├── Markdown.kt          轻量 Markdown 渲染
├── Prefs.kt / ThemeUtil.kt
```

## 图标

全部位于 `app/src/main/res/drawable/`，为手写 path 的 VectorDrawable（24dp 网格，纯几何形状：圆、圆角矩形、六边形、圆环），无 emoji、无位图资源；启动图标为 `mipmap-anydpi-v26` 的 adaptive icon。

## 说明

本项目仅 UI 风格参考 Shizuku（RikkaApps/Shizuku，Apache 2.0），不包含其任何代码、图标或资源。
