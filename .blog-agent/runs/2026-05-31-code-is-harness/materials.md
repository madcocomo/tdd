# 素材整理：代码就是 Harness

- run: `.blog-agent/runs/2026-05-31-code-is-harness/`
- 检索/整理时间：2026-05-31
- 用途：支撑后续大纲与草稿，不是最终正文

---

## 一、原始素材 / 事实

### 1. 关于 Harness / Harness Engineering 的常见定义

#### Martin Fowler, 2026-04-02
文章：`https://martinfowler.com/articles/harness-engineering.html`

可直接用到的点：
- “The term harness has emerged as a shorthand to mean everything in an AI agent except the model itself — Agent = Model + Harness.”
- 但这一定义很宽，需要按具体场景收窄。
- 在 coding agent 场景里，Fowler 更强调两类东西：
  - **Guides / feedforward**：提前约束 agent，减少一开始就走偏
  - **Sensors / feedback**：在 agent 行动后产生可用信号，帮助它自我修正
- 他把 harness 说成一种“steering loop”：不是只给 prompt，而是持续引导 + 持续校正。

可提炼含义：
- harness 不只是“提示词工程”；
- 更像围绕模型建立的一套约束、观测、纠偏机制。

#### LangChain, 2026-03-10
文章：`https://www.langchain.com/blog/the-anatomy-of-an-agent-harness`

可直接用到的点：
- “TLDR: Agent = Model + Harness.”
- “A raw model is not an agent. But it becomes one when a harness gives it things like state, tool execution, feedback loops, and enforceable constraints.”
- 它列出的 harness 组成包括：
  - system prompts
  - tools / skills / MCPs
  - filesystem / sandbox / browser 等基础设施
  - orchestration logic（如 subagent、handoff、model routing）
  - hooks / middleware
  - memory / search

可提炼含义：
- 模型负责“智能”；
- harness 负责把这种智能变成“能干活”的东西。

#### OpenHarness README, 2026
仓库：`https://raw.githubusercontent.com/HKUDS/OpenHarness/main/README.md`

可直接用到的点：
- “OpenHarness delivers core lightweight agent infrastructure: tool-use, skills, memory, and multi-agent coordination.”
- 它把 harness 特征拆成：
  - agent loop
  - toolkit
  - context & memory
  - governance
  - swarm coordination

可提炼含义：
- 在工程实践里，harness 常常已经被默认理解成“模型之外那一整套运行层”。

#### Survey README, 2026
仓库：`https://raw.githubusercontent.com/Gloriaameng/Awesome-Agent-Harness/main/README.md`

可直接用到的点：
- “The agent execution harness — not the model — is the primary determinant of agent reliability at scale.”
- 把 harness 形式化成六元组：
  - **E** Execution Loop
  - **T** Tool Registry
  - **C** Context Manager
  - **S** State Store
  - **L** Lifecycle Hooks
  - **V** Evaluation Interface

可提炼含义：
- 越往工程里走，harness 越不是一个模糊比喻，而是在被当成独立架构对象讨论。

---

### 2. 从不同说法里可以归纳出的共性

综合上面几类定义，可以归纳出几个稳定共性：

1. **它在模型外部**
   - 不是参数，不是训练权重；
   - 是围绕模型搭出来的系统层。

2. **它把开放式生成压进可执行流程**
   - 通过工具、状态、循环、编排，把“随便说点什么”变成“按步骤做事”。

3. **它提供约束与反馈**
   - 前面有 guide / schema / policy；
   - 后面有 test / verifier / linter / judge / runtime error / downstream failure。

4. **它暴露中间状态，允许反复迭代**
   - 能看 plan、看工具调用、看代码、看日志、看 diff；
   - 所以 agent 不是一次性黑箱输出，而是可观测过程。

5. **它让结果可以被验证、复现、回滚**
   - 这点对“让 AI 真干活”特别关键。

一句话压缩：

> Harness 的共同点，不是“模型外的一切”这么空，而是：**把模型输出嵌进一个有约束、有反馈、可执行、可验证的闭环。**

---

### 3. “让模型直接算” vs “让模型先写代码再执行” 的明确证据

#### PAL: Program-aided Language Models
论文：`https://arxiv.org/abs/2211.10435`（2022-11-18）

摘要中的关键信息：
- LLM 在分解问题时可能没问题，但在“求解那一步”常犯逻辑和算术错误。
- PAL 的方法是：
  - 让 LLM 读取自然语言问题；
  - 生成程序作为中间推理步骤；
  - 把真正求解交给 Python interpreter 之类的 runtime。
- 论文明确写到：
  - “generating code using an LLM and reasoning using a Python interpreter leads to more accurate results than much larger models”
  - 在 GSM8K 上，PAL using Codex 超过了使用 chain-of-thought 的 PaLM-540B，**absolute 15% top-1**。

可提炼含义：
- 不是模型“突然更会算了”；
- 而是把计算交给了一个更适合计算的受约束执行环境。

#### Program of Thoughts Prompting (PoT)
论文：`https://arxiv.org/abs/2211.12588`（2022-11-22）

摘要中的关键信息：
- CoT 把 reasoning 和 computation 都放在自然语言 thought 里。
- PoT 把 reasoning 表达成 program，把 computation “relegated to an external computer”。
- 在数学题和 financial-QA 数据集上，few-shot / zero-shot 下平均都能比 CoT 高大约 **12%**。

可提炼含义：
- “让模型先产出程序，再由外部系统执行”，不是个零散技巧，而是一类已经被论文系统验证过的结构。

对文章的帮助：
- 你原来举的“统计报表”例子是成立的；
- 如果想更稳一点，可以写成：
  - 早期很多研究就发现，LLM 自己做数值推理和多步计算容易漂；
  - 但如果让它先把解法写成 Python，再执行、检查，正确率会显著提升。

---

### 4. Tao / 数学 formalization 的更准确说法

#### Tao 的 2026 文章
文章：`https://terrytao.wordpress.com/2026/03/29/mathematical-methods-and-human-thought-in-the-age-of-ai/`

正文可直接用到的背景句：
- Tao 在导语里就把主题概括成：AI 与 **formalization for mathematics** 正在迫使人重新思考数学实践。

更重要的是评论区里他给出的一个非常具体的实践判断：
- “The emerging best practice in the formalization and autoformalization communities is to have the statements of formalized theorems to be generated (or at least carefully reviewed) by humans, whilst the proofs of those theorems can be more safely delegated to more automated tools.”

他还补充：
- 自己也用过 AI 帮忙 formalize theorem statements；
- 会碰到两类问题：
  - 漏掉退化情形（degenerate case）
  - 把 existential / universal quantifier 写反
- 这些错误之所以能被发现，是因为：
  - 该命题会被人或 AI formalizer 检查；
  - 以及它处在更大的结果链条里，会被 downstream verification 暴露出来。

可提炼含义：
- 更准确的说法不是“陶哲轩把数学定律直接交给 AI 推出来了”；
- 而是：在他参与和讨论的这波 AI + formalization 实践里，**命题先被形式化，证明过程再更多地交给自动化工具，最终还要受形式系统和下游依赖的约束**。

这和“先写代码，再执行，再验证”的结构是同构的：
- 都不是让 LLM 直接吐最终答案；
- 而是先把问题压进一种更收敛、更可检查的中间表示。

#### Tao 的 Lean 相关实践背景
Tao 搜索页：`https://terrytao.wordpress.com/?s=Lean`

可以看到近两年他有多篇 Lean / formalization 相关文章，例如：
- `A slightly longer Lean 4 proof tour`（2023-12-05）
- `Formalizing the proof of PFR in Lean4 using Blueprint: a short tour`（2023-11-18）
- `A Lean companion to "Analysis I"`（2025-05-31）

可提炼含义：
- Tao 的例子要落在“形式化数学 + 自动化辅助”上，而不是写成“AI 自己像数学家一样独立完成证明”。

---

### 5. 关于“软件时代结束 / 即抛型软件”的背景材料

#### Karpathy 的 Software 2.0 背景
Karpathy 主页：`https://karpathy.ai/`

主页能直接看到：
- 他长期把 `Software 2.0` 当作核心议题之一；
- 页面挂着 `Software 2.0` 文章和 talk。

可提炼含义：
- “程序不再只由传统代码构成，而会越来越多地由自然语言、训练数据、模型行为来定义”这条线，已经讨论很多年了。

#### 可用于正文的更稳妥写法
这里不建议写得过实：
- 不必硬说“软件时代结束”是明确共识；
- 更稳妥的是写成：
  - 从 Software 2.0、自然语言编程，到今天的 vibe coding / agent 生成小工具，外界确实越来越倾向于把软件看成一种可以按需生成、甚至一次性消费的产物。

这样既能保留时代背景，又不会让全文跑偏成“趋势报道”。

---

## 二、为文章服务的归纳整理

### 1. 可以直接放进正文的 Harness 简述

可选写法 A：

> 所谓 harness，粗略说就是模型之外那一整套让它真正能干活的东西：工具、上下文、记忆、执行环境、验证器、反馈回路。

可选写法 B：

> 有人把 harness 定义得很宽，几乎等于“除了大模型本身之外的一切”。但无论定义多宽，几个共性很稳定：它负责约束、执行、验证和反馈，让模型输出不只是看起来像答案，而是能进入一个可反复校正的闭环。

### 2. 这篇文章真正要抓住的论证跳板

最关键的不是“AI 会不会写代码”，而是这条链条：

`AI 生成代码 -> 代码执行/约束 -> 结果被验证 -> 问题被更可靠地解决`

因此：
- 如果我们把目标放大到“AI 解决问题”；
- 那么代码并不只是被 AI 取代的对象；
- 它本身就是 AI 解决问题时的一种 harness。

### 3. 代码为什么像 Harness

代码天然带有这些性质：
- 语法约束
- 显式步骤
- 可执行
- 可重复运行
- 可调试
- 可测试
- 可 diff
- 可 review
- 可回滚

这正是 harness 最需要的特性。

所以你后面那句判断可以更锋利地写成：

> 软件行业 AI 应用进展快，不是因为软件更容易被取代，而是因为软件行业早就把最强的一套 harness 基础设施修好了。

### 4. 对“统计报表/Python中间层”例子的加强方式

你原来的例子可以升级成两层：

- 日常直觉层：
  - 直接让 LLM 从数据里总结，常会写出像样但不可靠的数字结论；
  - 让它先写 Python 去读数据、聚合、出报表，错误率会明显下降。

- 研究证据层：
  - PAL / PoT 这类工作已经系统展示了：
  - 当模型把中间过程写成程序，再交给解释器执行时，数值与多步推理任务的正确率会明显提升。

这样正文就不会只像个人经验，而更像“个人经验 + 研究共识”叠在一起。

### 5. Tao 例子的准确落点

建议正文写法不要说：
- “陶哲轩让 AI 自己推出了数学定律”

建议改成：
- “在陶哲轩参与讨论的 AI + 数学 formalization 实践里，更可靠的路径不是让 LLM 直接给出自然语言证明，而是先把命题写进 Lean 这类形式化语言，再让自动化工具在形式系统约束下推进证明。连命题的形式化本身也要人工复核，因为量词写错、漏掉退化情形这种问题并不少见。”

这样更准确，也更能服务你的论点。

### 6. 文章里可以打得更清楚的反转点

常见叙事：
- 软件是最先被 AI 吃掉的行业

你这篇文章要提出的反叙事：
- 软件是最先让 AI 爆发的行业，恰恰因为它最早拥有成熟 harness。

也就是：
- **不是“软件最该死”**
- 而是**“软件最适合当 AI 的支架”**

### 7. 对普通程序员的两点意义

可以继续保留你原来的两点，只稍微 sharpen：

1. **未来软件怎么被 AI 使用，会越来越重要。**
   - 不只是给人点按钮；
   - 还包括如何让 agent 读懂、调用、试错、验证、恢复。

2. **很多原本不值得软件化的小场景，会因为 AI 出现而重新变得值得。**
   - 以前不值得写系统，因为开发和维护太贵；
   - 现在如果一层很薄的软件化外壳，就能把问题变成 AI 可执行、可验证的闭环，那就会长出新的应用场景。

---

## 三、建议避免的表述

1. 避免写成：
   - “Harness 就是除了模型以外的一切。”
   - 这句话可以提，但最好马上补一句“真正有意义的共性是约束 + 执行 + 验证 + 反馈”。

2. 避免写成：
   - “陶哲轩已经用 AI 自动证明了数学定律。”
   - 会显得夸大，也容易被懂行读者挑错。

3. 避免把“软件时代结束”写成你的主张。
   - 更适合写成背景噪音或流行论调，供你反驳/偏转。

---

## 四、目前最适合进入正文的三个核心句子

1. **代码不是 AI 的竞争对手，而是它最强的 Harness 之一。**
2. **软件行业最先爆发 AI，不是因为它最容易被替代，而是因为它最早拥有可执行、可验证、可回滚的结构。**
3. **从“让模型直接回答”到“让模型先写代码再执行”，变化的不只是提示词，而是问题第一次被放进了一个 Harness。**
