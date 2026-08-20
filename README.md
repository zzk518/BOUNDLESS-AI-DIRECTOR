# BOUNDLESS AI DIRECTOR

面向影视创作的纯文字 AI Skill 套装，包含编剧与导演两个协作模块。它把创意、真实素材或已有剧本发展为可审计的文字剧本、导演方案、分镜表、视觉资产设定和图像/视频提示词。

## 包含内容

- `boundless-ai-director-writer`：创意方向、Treatment、完整锁定剧本、事实来源与导演交接事实包、宏观情绪曲线、剧本诊断、首刷体验、商业广告、短剧、网大、长片与系列剧开发。
- `boundless-ai-director`：项目事实圣经、四轴导演定调、关系压力与视线流、真实机位和物理色源、节奏与走位、电影分镜、连续性圣经、视觉资产立项与依赖图、角色/道具母板文字方案、可选三帧视觉证明及 4–15 秒同场景多镜视频提示词。

## 能力边界

- 全部交付为文字、表格和提示词。
- 不操作任何网页、画布或生成平台。
- 不创建图片、视频或音频，也不把提示词声称为媒体成品。
- “直接做”只表示跳过内部创作确认，不代表外部平台操作授权。

## 安装

### 自动安装（Windows）

在解压后的项目目录运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

如果已经安装过旧版本，并希望先备份再覆盖：

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Force
```

### 手动安装

将以下两个文件夹复制到 `%USERPROFILE%\.codex\skills\`：

- `skills\boundless-ai-director-writer`
- `skills\boundless-ai-director`

随后新建一个 Codex 任务，使 Skill 列表重新加载。

## 使用示例

```text
使用 $boundless-ai-director-writer，把这个真实素材发展成一个 8 分钟黑色幽默短片。
```

```text
使用 $boundless-ai-director，把这份剧本转成四轴导演方案、完整分镜和同场景多镜视频提示词。
```

编剧模块完成后，可直接要求“现在分镜”，并把锁定后的剧本、人物、世界规则、时长和禁改项交给导演模块。

默认在对话中以 Markdown 交付。要求“文档”“最终母版”或分享包时，固定输出两个独立主文档：`01-锁定剧本.docx` 与 `02-导演视觉方案.docx`，不得合并；两份 DOCX 的标题、正文、对白、表格、页眉页脚和中英文字符统一使用微软雅黑。另保留 Markdown 可版本控制文本，CSV/XLSX 可作为分镜、场景或资产附表。

## 自检

Windows PowerShell：

```powershell
powershell -ExecutionPolicy Bypass -File .\tests\skill-contract-tests.ps1
```

测试会检查商业路线、长片/剧集能力、事实来源、宏观情绪曲线、三轨节奏、锁定剧本、四轴导演方法、资产依赖图、角色/道具母板路由、关系压力、视线流、真实机位、物理色源、反模板镜组、4–15 秒同场景多镜规则、纯文字边界以及引用文件完整性。

## 版本

`2.1.0` — 新增事实来源与项目事实圣经、宏观情绪曲线、资产生产清单与依赖图、角色身份包、关键道具母板路由、捕获系统与音乐一致性闸门。
