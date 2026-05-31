# .blog-agent 工作区

`.blog-agent/` 是本仓库中专门留给 Agent 生成 blog 时使用的内部工作区，用来保存中间产物，而不是最终发布内容。

这个目录已经在 Jekyll 的 `_config.yml` 中显式排除，因此：
- 不会出现在首页聚合中；
- 不会被构建到站点页面里；
- 不应该作为公开内容路径使用。

## 目录约定

- `workflow.md`：文章生成工作流与阶段产物约定
- `style.md`：文字风格、允许与禁止行为
- `outline-templates.md`：当用户只有主题时可提供的 3 种大纲模版
- `images.md`：配图、图片提示词、文件落地规则
- `runs/`：每篇文章一个工作目录，保存草稿、素材、计划、运行记录等

## run 目录建议结构

每篇文章建议创建一个目录：

```text
.blog-agent/runs/YYYY-MM-DD-<slug>/
```

建议文件：
- `intent.md`：主旨、目标读者、澄清结论
- `materials.md`：素材清单、事实、引用、检索摘要
- `outline.md`：确认后的结构与段落安排
- `draft-v1.md`：草稿版本 1
- `draft-v2.md`：草稿版本 2
- `draft-v3.md`：草稿版本 3
- `image-plan.md`：标题建议、配图方案、提示词
- `publish-checklist.md`：发布路径、front matter、图片落地、验证记录
- `assets/`：临时图片、截图、导入素材

## 发布边界

- 中间文件只留在 `.blog-agent/`。
- 定稿文章只发布到 `_article/`、`_tips/` 或 `_book_review/`。
- 最终采用的图片发布到 `images/`。
- 不要编辑 `_site/`。
