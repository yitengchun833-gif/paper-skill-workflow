# 论文工作流 Skill 整合包说明书

## 1. 整合包介绍

`论文工作流skill` 是一套围绕论文写作、论文格式处理、AIGC 表达优化、文献引用、科研图表、论文汇报和多角色审查建立的 Agent Skill 集合。

它的目标不是替代某一个大模型，而是把一套可重复执行的论文工作流程打包成可迁移的 `SKILL.md` 目录结构，让支持 Agent Skills 或类似机制的 AI Agent 能够更快理解你的论文工作习惯。

这个整合包适合以下场景：

- 中文本科、硕士论文的表达优化和格式整理。
- 根据 AIGC/PaperPass/AI 写作检测报告定位高风险段落，并做合规的学术表达优化。
- 论文 Word 文档套格式、章节标题、图表题注、公式说明、参考文献等模块化处理。
- 摘要、引言、结果、讨论、结论等论文段落写作和润色。
- 文献检索、引用匹配、论文阅读翻译和 PPT 汇报。
- 多 Agent 分工审查论文逻辑、数据证据、格式引用和最终交付。

## 2. 核心原则

本整合包默认遵循以下原则：

- 不覆盖原始论文文件，所有 Word 输出应创建新版本。
- 不编造实验、数据、图表、参考文献、检测结果或结论。
- AIGC 优化只做合规的学术表达优化，不承诺任何检测平台的具体分数。
- 论文格式任务先审查，再按模块修改；对已经正确的封面、承诺书等前置页优先保留，只检查字体、字号、对齐等明确项目。
- 对 Word、PPT、Excel 这类二进制文件，主 Agent 负责最终编辑和集成，其他 Agent 默认只做审查和提出替换建议。
- 多技能同时适用时，选择覆盖任务所需的最小 skill 组合，避免无关 skill 干扰上下文。

## 3. 目录结构

```text
论文工作流skill/
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
├── README.md
├── workflow_manifest.json
├── install_workflow_skills.ps1
└── AGENT_PORTABILITY_GUIDE.md
```

每个可安装 skill 目录中至少包含一个 `SKILL.md`。如果某个 skill 附带 `scripts/`、`references/`、`assets/` 等目录，应与 `SKILL.md` 一起保留。

## 4. Skill 分类说明

### 4.1 核心论文处理

- `aigc-academic-expression-optimizer`
  - 用于处理 AIGC、AI 写作检测、PaperPass 等报告。
  - 负责先分析报告，再定位高风险段落，最后组织整篇论文表达优化流程。
- `aigc-academic-expression-optimization`
  - 用于段落级表达优化。
  - 重点是减少模板化、空泛化、机械化表达，增强作者分析痕迹和证据绑定。
- `thesis-format-module-editor`
  - 用于论文 Word 格式识别和分模块修改。
  - 适合处理学校模板、标题层级、页眉页脚、图表题注、公式、参考文献等格式问题。

### 4.2 写作与润色

- `nature-writing`
  - 用于论文摘要、引言、结果、讨论、结论、标题等内容写作和结构重构。
- `nature-polishing`
  - 用于学术表达润色、中英互译、英文论文表达优化。
- `nature-response`
  - 用于审稿意见回复、逐点回复、修改说明和 rebuttal 类文本。

### 4.3 文献、引用与阅读

- `nature-academic-search`
  - 用于文献检索、DOI/PMID、BibTeX/RIS/nbib、MeSH 等文献工作流。
- `nature-citation`
  - 用于给论文正文补引用、建立句段和参考文献之间的对应关系。
- `nature-reader`
  - 用于论文阅读、PDF 解读、中英文对照翻译和图表位置保留。

### 4.4 科研输出

- `nature-data`
  - 用于数据可用性声明、数据仓库、FAIR 元数据、数据集引用。
- `nature-figure`
  - 用于科研图件制作、审查、导出和 Nature 风格图表。
- `nature-paper2ppt`
  - 用于从论文生成组会、汇报、答辩或 journal club PPT。

### 4.5 协同审查

- `multi-agent-workflow`
  - 用于多 Agent 分工。
  - 论文任务默认可分为逻辑审查、数据证据审查、格式引用审查，主线程负责最终整合。

## 5. 迁移给其他 Agent 的兼容性

### 5.1 完全兼容

如果目标 Agent 支持 Agent Skills 标准或类似的 `SKILL.md` 机制，它通常可以直接使用本整合包中的 skill。

最低要求：

- 能识别每个 skill 目录下的 `SKILL.md`。
- 能读取 YAML frontmatter 中的 `name` 和 `description`。
- 能在任务匹配时加载完整 `SKILL.md`。
- 能按需读取同目录下的 `references/`、`scripts/`、`assets/`。

### 5.2 部分兼容

如果目标 Agent 不支持自动 skill 发现，但支持项目知识库、长上下文、文件上传或系统提示，可以把本整合包作为“工作流说明库”使用。

推荐方式：

1. 上传 `README.md`、`workflow_manifest.json` 和本说明书。
2. 根据任务上传对应 skill 的 `SKILL.md`。
3. 在提示词中明确要求 Agent 先阅读相关 `SKILL.md`，再执行论文任务。

### 5.3 不兼容或需要改造

以下能力不能仅靠复制本整合包自动获得：

- Codex 的 `documents:documents` 插件能力。
- Codex 的 `spreadsheets:Spreadsheets` 插件能力。
- Codex 的 `presentations:Presentations` 插件能力。
- 某些 Agent 专属的文件编辑、渲染、浏览器、联网检索或 MCP 工具。

如果目标 Agent 没有 Word/PDF 编辑能力，它仍然可以给出修改建议，但不能可靠地产出最终 `.docx` 文件。

## 6. 安装方式

### 6.1 Codex

在本机 Codex 环境中，可直接运行：

```powershell
powershell -ExecutionPolicy Bypass -File ".\install_workflow_skills.ps1"
```

脚本会把可安装 skill 复制到：

```text
%USERPROFILE%\.codex\skills
```

安装完成后重启 Codex。

### 6.2 Claude Code

Claude Code 通常使用以下目录：

```text
~/.claude/skills/<skill-name>/SKILL.md
```

或项目级目录：

```text
.claude/skills/<skill-name>/SKILL.md
```

迁移时建议把分类目录中的 skill 平铺复制到 `.claude/skills/`：

```text
.claude/
└── skills/
    ├── aigc-academic-expression-optimizer/
    ├── aigc-academic-expression-optimization/
    ├── thesis-format-module-editor/
    ├── nature-writing/
    └── ...
```

不要只复制外层 `论文工作流skill` 文件夹，因为部分 Agent 不会递归识别分类目录中的 skill。

### 6.3 Claude 网页版或桌面版

如果 Claude 支持自定义 Skills 上传，通常做法是：

1. 每个 skill 单独保留一个文件夹。
2. 确认文件夹根部有 `SKILL.md`。
3. 将单个 skill 文件夹压缩为 ZIP。
4. 在 Claude 的 Skills 页面上传 ZIP。
5. 启用对应 skill。

需要 Word/PDF/PPT/XLSX 文件处理时，还要确认 Claude 账号已启用文件创建、代码执行或相关内置能力。

### 6.4 其他支持 Agent Skills 的 Agent

优先查看目标 Agent 的官方说明，找到它的 skills 根目录。然后把每个 skill 文件夹复制进去。

通用目标结构：

```text
<agent-skills-root>/
├── aigc-academic-expression-optimizer/
│   └── SKILL.md
├── thesis-format-module-editor/
│   └── SKILL.md
└── nature-writing/
    └── SKILL.md
```

如果目标 Agent 要求不同 frontmatter 字段，可以只做兼容性补充，不要删除现有 `name` 和 `description`。

### 6.5 不支持 Skills 的 Agent

如果目标 Agent 没有 skill 机制，可以把本包当作“提示词和流程库”。

推荐提示：

```text
请把我上传的“论文工作流skill”当作论文工作流说明库。
当我提出论文任务时，请先根据 workflow_manifest.json 判断应使用哪些 SKILL.md，
再读取对应 SKILL.md 的规则执行。
如果任务涉及 Word/PDF/PPT/XLSX，请先说明你当前环境是否能直接编辑文件；
不能直接编辑时，只输出可应用的修改建议和定位说明。
```

## 7. 典型任务路由

| 用户任务 | 推荐 skill 组合 |
| --- | --- |
| 根据 AIGC 报告继续降低 AI 率 | `aigc-academic-expression-optimizer` + `aigc-academic-expression-optimization` + 文件编辑能力 |
| 论文套学校格式 | `thesis-format-module-editor` + Word 文件编辑能力 |
| 同时降低 AI 风格并套格式 | 两个 AIGC skill + `thesis-format-module-editor`，先表达优化，后格式处理 |
| 写摘要、引言、结论 | `nature-writing` |
| 学术英文润色或中英翻译 | `nature-polishing` |
| 补参考文献、找支撑文献 | `nature-academic-search` + `nature-citation` |
| 论文 PDF 阅读、全文翻译 | `nature-reader` |
| 生成论文汇报 PPT | `nature-paper2ppt` + PPT 文件能力 |
| 多角色论文审查 | `multi-agent-workflow` |

## 8. 给其他 Agent 的执行规则

其他 Agent 接入本整合包后，建议遵守以下执行规则：

1. 先确认任务类型，再选择 skill，不要一次性加载全部 skill。
2. 对 Word/PDF/PPT/XLSX 文件，先确认当前环境是否能读取和写入这些文件。
3. 对论文格式任务，先做完整审查，再分模块修改。
4. 对论文内容任务，除非用户要求直接改文档，否则先给出修改范围和关键风险。
5. 对 AIGC 优化任务，只做表达层面的学术优化，不做规避检测、伪造原创性或承诺分数。
6. 对引用任务，只引用可核验文献，不生成不存在的 DOI、期刊、作者或年份。
7. 对数据和图表任务，不改变原始数据含义，不把估计值写成实测值。
8. 对多 Agent 工作流，子 Agent 只返回发现、风险和替换建议；最终编辑由主 Agent 完成。

## 9. 需要用户提供的材料

不同任务通常需要以下材料：

- AIGC 优化：最新论文 `.docx`、最新检测报告 PDF、学校或导师对修改边界的要求。
- 套格式：论文 `.docx`、学校格式模板或格式要求文件。
- 文献引用：论文段落、研究主题、检索范围、引用格式要求。
- 论文写作：研究问题、已有结果、图表、实验数据、章节目标。
- 论文转 PPT：论文 PDF 或 DOCX、汇报时长、听众类型、学校或课题组模板。

缺少关键材料时，Agent 应先说明缺口，而不是凭空补全。

## 10. 质量检查清单

交付前建议检查：

- 是否创建了新文件，而不是覆盖用户原始文件。
- 是否保留了论文原有章节结构、图表编号和参考文献边界。
- 是否明确标注了修改范围、输出路径和未完成项。
- 是否避免编造数据、引用、结果和检测分数。
- Word 文档是否能打开；如果 Agent 支持渲染，应检查页面预览。
- 格式任务是否按模块说明了修改位置。
- 多 Agent 任务是否由主 Agent 统一集成，避免并行写同一个二进制文件。

## 11. 导出建议

导出给其他 Agent 前，建议保留以下文件：

- `README.md`
- `AGENT_PORTABILITY_GUIDE.md`
- `workflow_manifest.json`
- 所有分类目录下的 skill 文件夹
- `99-plugin-and-system-dependencies/README.md`

如果目标 Agent 只接受单个 skill 文件夹或单个 ZIP，不要压缩整个分类仓库；应按 skill 单独打包。

如果目标 Agent 支持项目级知识库，可以上传整个文件夹，并在第一次对话中说明：

```text
这是我的论文工作流 Skill 整合包。请根据 AGENT_PORTABILITY_GUIDE.md 和 workflow_manifest.json 使用它。
后续凡是论文写作、论文格式、AIGC 报告优化、文献引用、论文转 PPT 或多角色审查任务，
请自动匹配相应 SKILL.md，不需要我每次手动指定。
```

## 12. 风险与边界

- 不同 Agent 对 `SKILL.md` 的支持程度不同，自动调用效果取决于目标 Agent 的实现。
- 部分 Agent 只能读取说明，不能执行脚本或编辑本地文件。
- 插件能力不能随 skill 自动迁移；尤其是 Word、Excel、PPT、PDF 的可靠编辑能力需要目标 Agent 自身支持。
- 文献检索和引用质量取决于目标 Agent 是否有联网、数据库、CrossRef、PubMed、arXiv 或学校数据库访问能力。
- AIGC 检测平台规则不透明且会变化，表达优化不能保证具体检测分数。

## 13. 推荐交付话术

把本整合包交给其他 Agent 时，可以直接使用下面这段说明：

```text
这是一个论文工作流 Skill 整合包，里面包含多个 SKILL.md。
请先阅读 AGENT_PORTABILITY_GUIDE.md 和 workflow_manifest.json。
如果你的环境支持 Agent Skills，请把每个 skill 文件夹安装到你的 skills 根目录；
如果不支持，请把这些文件当作论文工作流说明库使用。

后续处理我的论文任务时，请自动选择相关 skill：
- AIGC 检测报告优化：使用两个 AIGC skill。
- 论文套格式：使用 thesis-format-module-editor。
- 写作和润色：使用 nature-writing 或 nature-polishing。
- 文献和引用：使用 nature-academic-search 与 nature-citation。
- 论文阅读或转 PPT：使用 nature-reader 或 nature-paper2ppt。
- 多角色审查：使用 multi-agent-workflow。

请遵守边界：不覆盖原文件，不编造数据或引用，不承诺检测分数，Word/PDF/PPT/XLSX 文件必须先确认能否可靠编辑。
```

