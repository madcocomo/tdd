# 本次对话导出（整理版）

- run: `.blog-agent/runs/2026-05-31-code-is-harness/`
- 整理时间：2026-05-31
- 说明：为便于阅读，长篇草稿正文不在这里重复全文展开，具体内容以对应文件为准；工具输出省略，只保留关键信息与决策。

---

## 1. 主题提出

**用户：**
生成一篇 blog，主题大致为“软件（或者说是代码）就是 harness”，并给出核心思路：
- AI 智能体发展聚焦到 Harness Engineer / Harness 的概念，需要补介绍与共性归纳；
- AI 辅助软件开发发展很快，甚至有人觉得软件时代会结束，或者被“即抛型软件”替代；
- 如果把视角从“AI 生成代码”放大到“AI 解决问题”，代码本身就是一种 harness；
- 用“先让 LLM 写 Python 再执行”与数学形式化（陶哲轩相关实践）作为例子；
- 核心判断是：软件行业 AI 应用快，不是因为软件更简单，而是因为它先天具备更成熟的 harness；
- 最后落到普通程序员如何理解机会。

**用户补充：**
已启用 superpowers；若某个 skill 可能适用，要先读取再决定是否使用。

**助手：**
读取相关 skill 与 blog 仓库文档，确认按照 `.blog-agent/` 工作流推进。

---

## 2. 意图确认与素材范围

**助手：**
总结主旨句，并列出待补充内容条目，包括：
- Harness / Harness Engineering 的定义与共性；
- “软件时代结束 / 即抛型软件”的背景论调；
- 先写代码再执行的例子；
- Tao / 形式化语言例子；
- 软件行业为什么会成为 AI 最快落地的地方；
- 对普通程序员的意义。

**用户：**
指出“为什么 AI coding 发展快”不需要单独成段，只要自然体现在文字里。

**助手：**
更新素材清单，删除该条的单独段落化处理。

**用户：**
确认素材补充范围可以开始。

---

## 3. 素材整理

**助手：**
完成资料检索与整理，写入：
- `intent.md`
- `materials.md`

整理出的关键点包括：
- Harness Engineering 常见定义及其稳定共性；
- 代码/程序为什么天然具备 harness 所需的特性；
- “先写程序再执行”在数值与推理任务上更稳，有研究支持；
- Tao 与数学形式化的例子更适合写成“先形式化，再让工具推进/校验”；
- “软件会被替代 / 即抛型软件”更适合作为背景噪音，不宜喧宾夺主。

**用户：**
确认素材方向没有问题，可以继续。

---

## 4. 大纲整理

**助手：**
给出一版文章大纲，包含：
- Harness 概念收束；
- “软件会被替代”的流行叙事；
- 代码本身就是 Harness；
- 数据/Python 例子；
- 数学/形式化例子；
- 对软件行业的反转判断；
- 对程序员的意义。

**用户：**
指出“软件会被替代 / 即抛型软件”的段落放得太早，会打断“什么是 harness -> 代码就是 harness”的反转，应挪到靠后位置。

**助手：**
更新大纲，把“流行叙事”挪到例子之后、核心判断之前。

**用户：**
确认新的结构顺序可以。

---

## 5. 草稿生成与多轮改写

### 第一轮：三个初稿

**助手：**
基于大纲生成三个版本：
- `draft-v1.md`（更锋利）
- `draft-v2.md`（更平实）
- `draft-v3.md`（更偏案例）

**用户：**
认为 V2 最接近，同时指出：
- 之前把 Harness Engineering 写成了 Harness Engineer，是笔误，需要统一更正；
- 希望以 V2 为底子再出 3 个版本，其中一个可借用 V3 的开头；
- V3 最大的问题是开头与后文重复。

### 第二轮：基于 V2 重写三个版本

**助手：**
重新生成三个版本，并统一改为 Harness Engineering。

**用户：**
继续指出问题：
- “它不是一个新岗位”这类表述是由前面笔误连带产生的，不需要；
- 文章中提到的 PAL / PoT 等术语没有解释，读者不一定懂，最好直接写意思；
- 数学段落太多了，只应该做旁证；
- 不再需要“更强判断”的方向；
- 再重新生成 3 个版本。

### 第三轮：去术语、压缩数学、去“新岗位”表述

**助手：**
重写三个版本：
- 删除“新岗位”方向；
- 删去 PAL / PoT 术语，改成直接解释“自然语言硬算” vs “先写程序再执行”；
- 缩短数学段；
- 重新收束为平实、凝练方向。

**用户：**
最终选择 `v1` 作为底稿。

**助手：**
将 `draft-v1.md` 复制为 `draft-current.md`，作为后续修改基底。

---

## 6. 针对当前稿的定向修改

**用户：**
提出三项具体修改：
1. 标题改为“代码就是一种Harness”；
2. 开头改成“AI 新概念新技术层出不穷，最近比较火的 Harness Engineering 到底是什么又有点说不清楚”的切入；
3. 结尾不要给太大结论，回到普通程序员如何在快速变化中寻找可投入的机会，不要直接下结论，只说自己的思路，并且更凝练。

**助手：**
据此修改 `draft-v1.md` 与 `draft-current.md`。

---

## 7. 润色修改

**用户：**
继续要求润色，并给出一些感性反馈：
- 最后一段不需要写“对普通程序员来说”；
- 文章中对 harness 核心特性的解释重复出现太多次；
- “顺着这个往下看”“从这个角度再回看”等连接句过于机械；
- “改进并不神秘”“很熟悉的错”等修饰语不自然。

**助手：**
再次润色，调整为：
- 开头更自然；
- 解释结构减少重复；
- 去掉机械连接句；
- 去掉不必要修饰；
- 结尾改成更贴近个人思路的写法。

当前定稿底文保存在：
- `draft-current.md`

---

## 8. 标题 / 配图方案讨论

**助手：**
给出标题建议与配图方案，写入 `image-plan.md`。

**用户：**
希望生成一张封面图。

**助手：**
先提供三种方向：
- A. 对比结构图
- B. 极简抽象图
- C. 海报字图

**用户：**
选择 B（极简抽象图）。

---

## 9. 封面图生成与文章发布

**助手：**
生成封面图文件：
- `.blog-agent/runs/2026-05-31-code-is-harness/assets/2026-05-31-code-is-harness-cover.svg`
- `.blog-agent/runs/2026-05-31-code-is-harness/assets/2026-05-31-code-is-harness-cover.png`

并将生成记录补到：
- `image-plan.md`

**用户：**
要求继续定稿。

**助手：**
完成正式发布：
- 文章发布到 `_article/代码就是一种Harness.md`
- 封面图发布到 `images/2026-05-31-code-is-harness-01.png`
- 生成 `publish-checklist.md`
- 运行 `./bin/check`，结果为 `site check passed`

---

## 10. 本地预览与 LiveReload 说明

**用户：**
要求启动预览。

**助手：**
复用已有 tmux 会话 `blog-preview`，确认预览运行中：
- 站点地址：`http://localhost:4000`
- LiveReload：`http://localhost:35729`

**用户：**
询问 LiveReload 地址的作用。

**助手：**
解释其用途：它不是给人浏览内容的地址，而是给浏览器自动刷新的辅助服务；通常只需打开 `http://localhost:4000`。

---

## 11. 导出对话、提交与推送

**用户：**
要求：
- 把本次对话导出到 runs 记录目录中；
- 提交工作区的所有变更，包括文档、智能体配置、运行记录；
- 并推送。

**助手：**
执行：
- 生成本文件 `conversation.md` 作为本次对话导出；
- 准备提交 `.blog-agent/` 文档、运行记录、`AGENTS.md`、`_config.yml`、`.gitignore`、文章与图片等全部相关修改；
- 随后进行 git commit 与 git push。

---

## 12. 本次运行生成/修改的关键文件

### 发布内容
- `_article/代码就是一种Harness.md`
- `images/2026-05-31-code-is-harness-01.png`

### 工作流与运行记录
- `.blog-agent/README.md`
- `.blog-agent/workflow.md`
- `.blog-agent/style.md`
- `.blog-agent/outline-templates.md`
- `.blog-agent/images.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/intent.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/materials.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/outline.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/draft-v1.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/draft-v2.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/draft-v3.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/draft-current.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/image-plan.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/publish-checklist.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/conversation.md`
- `.blog-agent/runs/2026-05-31-code-is-harness/assets/2026-05-31-code-is-harness-cover.svg`
- `.blog-agent/runs/2026-05-31-code-is-harness/assets/2026-05-31-code-is-harness-cover.png`

### 配置/边界文件
- `AGENTS.md`
- `_config.yml`
- `.gitignore`
