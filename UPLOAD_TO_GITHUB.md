# GitHub 网页上传说明

本机当前没有安装 GitHub CLI，因此推荐使用 GitHub 网页上传。

## 1. 创建空仓库

1. 打开 GitHub 新建仓库页面：https://github.com/new
2. Repository name 填写：

```text
paper-skill-workflow
```

3. Description 填写：

```text
一套可迁移的论文工作流 Agent Skills 整合包，覆盖论文写作、AIGC 表达优化、Word 论文套格式、文献引用、科研图表、论文转 PPT 和多角色审查。
```

4. 选择 `Public`。
5. 不要勾选自动生成：
   - Add a README file
   - Add .gitignore
   - Choose a license
6. 点击 `Create repository`。

## 2. 上传文件

1. 进入新仓库页面。
2. 点击 `uploading an existing file` 或 `Add file` -> `Upload files`。
3. 打开本地目录：

```text
paper-skill-workflow
```

4. 选中该目录下的全部内容并拖入 GitHub 上传区域。
5. Commit message 填写：

```text
Initial release of paper skill workflow
```

6. 点击 `Commit changes`。

## 3. 上传后检查

上传完成后确认：

- README 能正常显示中文介绍。
- GitHub 识别到 MIT License。
- 目录中包含 5 个分类文件夹和 13 个 skill。
- 没有上传 `.docx`、`.pdf`、检测报告、论文原文、`.env` 或账号凭证。
- `workflow_manifest.json` 和 `AGENT_PORTABILITY_GUIDE.md` 存在。

## 4. 可选：添加 Topic

建议在仓库右侧添加 topics：

```text
agent-skills
academic-writing
thesis
paper-writing
codex
claude
aigc
workflow
```

