# paper-skill-workflow

`paper-skill-workflow` 是一套可迁移的论文工作流 Agent Skills 整合包，覆盖论文写作、AIGC 表达优化、Word 论文套格式、文献引用、论文阅读、科研图表、论文转 PPT 和多角色审查。它面向 Codex、Claude Code、Claude Skills 以及其他支持 `SKILL.md` / Agent Skills 的工具，也可以作为普通 AI Agent 的项目知识库使用。

## 适合做什么

- 根据 AIGC、PaperPass 或 AI 写作检测报告定位高风险段落，并做合规的学术表达优化。
- 对中文毕业论文、课程论文、科研论文进行章节写作、表达润色和逻辑重构。
- 按学校模板或格式要求处理 Word 论文格式。
- 支持文献检索、引用匹配、论文 PDF 阅读和中英文对照材料。
- 辅助科研图表、数据可用性声明、论文汇报 PPT 和审稿意见回复。
- 通过多 Agent 分工完成逻辑、数据、格式、引用等多角度审查。

## 工作流原则

- 不覆盖原始论文文件，正式修改应创建新版本。
- 不编造实验、数据、图表、参考文献、检测结果或结论。
- AIGC 表达优化只做学术表达自然化、证据绑定和边界修正，不承诺具体检测分数。
- Word 格式任务默认只改格式，不改正文语义。
- 对 `.docx`、`.pptx`、`.xlsx` 等二进制文件，主 Agent 负责最终编辑和集成；审查型 Agent 默认只给建议。

## 目录结构

```text
paper-skill-workflow/
├── 01-core-aigc-format/
│   ├── aigc-academic-expression-optimizer/
│   ├── aigc-academic-expression-optimization/
│   └── thesis-format-module-editor/
├── 02-writing-polishing/
│   ├── nature-writing/
│   ├── nature-polishing/
│   └── nature-response/
├── 03-literature-citation-reading/
│   ├── nature-academic-search/
│   ├── nature-citation/
│   └── nature-reader/
├── 04-research-outputs/
│   ├── nature-data/
│   ├── nature-figure/
│   └── nature-paper2ppt/
├── 05-coordination-review/
│   └── multi-agent-workflow/
├── 99-plugin-and-system-dependencies/
├── AGENT_PORTABILITY_GUIDE.md
├── workflow_manifest.json
└── install_workflow_skills.ps1
```

## Skill 分类

| 分类 | Skill | 用途 |
| --- | --- | --- |
| AIGC 与格式核心 | `aigc-academic-expression-optimizer` | 根据检测报告组织整篇论文表达优化流程 |
| AIGC 与格式核心 | `aigc-academic-expression-optimization` | 段落级学术表达优化和模板化表达修正 |
| AIGC 与格式核心 | `thesis-format-module-editor` | Word 论文格式识别与分模块修改 |
| 写作与润色 | `nature-writing` | 摘要、引言、结果、讨论、结论等论文写作 |
| 写作与润色 | `nature-polishing` | 学术英文润色、中英翻译和表达打磨 |
| 写作与润色 | `nature-response` | 审稿意见回复和修回信 |
| 文献与阅读 | `nature-academic-search` | 文献检索、DOI/PMID、BibTeX/RIS/nbib 工作流 |
| 文献与阅读 | `nature-citation` | 正文补引用、支撑文献匹配和引用导出 |
| 文献与阅读 | `nature-reader` | 论文阅读、翻译和中英文对照材料 |
| 科研输出 | `nature-data` | 数据可用性、数据仓库和 FAIR 元数据 |
| 科研输出 | `nature-figure` | 科研图件制作、审查和导出 |
| 科研输出 | `nature-paper2ppt` | 从论文生成组会、汇报或答辩 PPT |
| 协同审查 | `multi-agent-workflow` | 多角色论文审查与主线程集成 |

## 安装到 Codex

在本仓库根目录运行：

```powershell
powershell -ExecutionPolicy Bypass -File ".\install_workflow_skills.ps1"
```

脚本会把可安装 skill 复制到：

```text
%USERPROFILE%\.codex\skills
```

如果目标 skill 已存在，脚本默认先备份到：

```text
%USERPROFILE%\.codex\skills\.trash\yyyyMMdd-HHmmss-skill-name
```

安装完成后重启 Codex。

## 给 Claude 或其他 Agent 使用

如果目标 Agent 支持 `SKILL.md` / Agent Skills，请把每个 skill 文件夹复制到它的 skills 根目录。例如 Claude Code 通常使用：

```text
~/.claude/skills/<skill-name>/SKILL.md
```

如果目标 Agent 不支持自动 skill 发现，可以把本仓库作为项目知识库或提示词库使用，并让 Agent 先阅读：

- `AGENT_PORTABILITY_GUIDE.md`
- `workflow_manifest.json`
- 具体任务对应的 `SKILL.md`

更详细的迁移说明见：

[AGENT_PORTABILITY_GUIDE.md](AGENT_PORTABILITY_GUIDE.md)

## 外部依赖说明

本仓库包含可迁移的 skill 指令、脚本、引用资料和资源文件，但不包含任何平台专属运行能力。

以下能力需要目标 Agent 自身支持：

- Word / DOCX 读写和渲染检查。
- PDF 解析。
- Excel / CSV 数据处理。
- PowerPoint / PPTX 创建。
- 联网检索、CrossRef、PubMed、arXiv 或其他文献数据库访问。

在 Codex 中，这些通常由 `documents:documents`、`spreadsheets:Spreadsheets`、`presentations:Presentations` 等插件提供。

## 开源说明

本仓库以 MIT License 开源。部分 Nature 系列 skill 来源于或改编自 `Yuan1z0825/nature-skills`，相关来源说明见 [NOTICE.md](NOTICE.md)。

## 免责声明

本项目用于论文写作辅助、格式处理和学术表达改进，不应用于学术不端、伪造数据、伪造引用、规避诚信审查或虚构研究结果。使用者应对论文内容、引用、数据和最终提交版本负责。

