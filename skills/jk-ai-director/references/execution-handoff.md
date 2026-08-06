# 文字化制作交接清单

本文件只生成平台中性的文字任务卡，供用户或制作人员手工录入目标工具。Skill 不操作任何画布或生成平台，不创建节点，不提交生图/视频任务，也不自动回写平台状态。

## 项目清单

```yaml
project:
  id: PROJ
  title: ""
  aspect: "16:9"
  duration_s: 0
  target_tool: unknown
  capability_surface: []
locks:
  script_version: v01
  director_plan_version: v01
  asset_bible_version: v01
```

## 文字任务卡

每个节点记录：

- `task_id`、类型（asset/keyframe/video/audio/edit）；
- 覆盖的场景/镜头 ID；
- 输入资产及版本；
- 输出文件角色；
- 提示词版本、时长、画幅和工具能力要求；
- 上游依赖与下游消费者；
- 计划状态：planned / ready / generated / approved / failed / retired；其中 generated 以后只能由用户提供结果或人工检查后填写；
- 失败代码、只改的一个变量、重试次数。

## 版本与命名

建议：`PROJ_SCnn_SHnn_vNN_role.ext`。版本单调递增，不覆盖；失败文件保留并标注主要失败轴。角色可用：`ref-face`、`ref-fit`、`plate`、`kf-first`、`kf-last`、`clip`、`amb`、`sfx`、`vo`、`cut`。

## 八道文字交接闸门

1. **计划**：每镜有故事功能、时长、走位和连续性锚点。
2. **资产**：身份、造型、场景、道具锁已批准。
3. **关键帧**：最终画幅正确，地理/光向/终态可执行。
4. **视频任务**：工具能力匹配，单段 4–15 秒且无跨场景合并。
5. **回片 QC 规格**：预先写出身份、物理、终态、连续性和画面错误的人工检查标准。
6. **声音**：环境底、对白、拟音和重点音效有来源/占位。
7. **组装**：镜头、入出点和时长完整，无未标记占位。
8. **交付**：版本、法务、字幕/文字合成和导出规格齐全。

## 最小修复梯子

按成本从低到高：提示词单变量修改 → 参数修改 → 重生成 → 重做关键帧 → 重做走位/镜头 → 剪辑规避 → 删除镜头。相同根因失败三次后必须换策略，不能继续叠加形容词。

## 最终母版交付清单

纯文字全流程至少交付以下逻辑文件；在对话中可合并为一份有清晰标题的 Markdown，用户要求打包时再拆分：

1. `00-project-receipt.md`：输入、假设、锁定项、格式和版本；
2. `01-locked-screenplay.md` 或 `01-locked-screenplay.docx`：可独立阅读的最终锁定剧本；
3. `02-screenplay-change-log.md`：导演阶段所有微调、理由和传播范围；
4. `03-director-plan.md`：四轴、首刷体验、方法权重、关系压力和画面语法；
5. `04-storyboard.md`，可另附 `04-storyboard.csv/xlsx`：连续镜号、时码、走位、机位与声音；
6. `05-continuity-bible.md`：人物、服装、道具、空间、光向与状态；
7. `06-visual-assets.md`：人物/场景/道具文字设定与锁；
8. `07-keyframe-prompts.md`：关键帧及可选三帧视觉证明提示词；
9. `08-video-prompts.md`：4–15 秒同场景多镜提示词；
10. `09-sound-edit.md`：声音层、剪辑、字幕/准确文字合成；
11. `10-execution-manifest.md`：任务、依赖、版本、人工状态与验收标准。

默认对话交付格式为 Markdown。用户要求“文档”“最终母版”或分享包时，以 DOCX 为人读主文档、Markdown 为可版本控制文本，CSV/XLSX 只承担表格互操作；无论采用何种容器，完整锁定剧本都不得省略。

## 纯文字边界

无论平台是否提供接口，都只生成可复制、可导入或供人工执行的文字清单和文件：不点击网页、不创建画布节点、不消费算力、不轮询生成结果、不声称任务已提交或媒体已生成。平台名称变化不影响本合同。
