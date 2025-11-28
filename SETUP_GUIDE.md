# GitHub Repository Setup Guide

## 当前状态说明

### ✅ 已完成的开发工作

1. **Workflow文件已创建**: `.github/workflows/merge-entry.yml` 在本地repo目录中
2. **文档已翻译**: README.md 和 CONTRIBUTING.md 都已翻译成英文
3. **后端API已实现**:
   - `/api/entries` POST endpoint 支持角色检查
   - 管理员用户：直接插入KV
   - 普通用户：调用 GitHubService 创建PR
4. **GitHub Service**: `server/utils/github.ts` 已有 `createEntryPR()` 方法
5. **配置文件**: 环境变量和运行时配置已更新

### ⚠️ 需要完成的关键步骤

**问题**: repo目录中的workflow文件还在本地，GitHub无法识别

**解决方案**: 需要把repo目录作为独立仓库推送到GitHub

---

## 推送Repo到GitHub的步骤

### 方式一：使用现有仓库的子目录（推荐简单场景）

如果你已经创建了空仓库 `yyh0808/monkeyknows`，可以这样操作：

```bash
# 进入repo目录
cd /Volumes/13EjectionPlug/code/dev-wiki-website/repo

# 初始化新的git仓库（独立于主项目）
rm -rf .git  # 删除主项目的git引用
git init

# 添加所有文件
git add .

# 创建初始提交
git commit -m "Initial setup: Wiki PR review workflow

- GitHub Actions workflow for automated PR processing
- Direct Cloudflare KV integration
- English documentation
- Ready for production use"

# 设置main分支
git branch -M main

# 添加远程仓库
git remote add origin git@github-yyh0808:yyh0808/monkeyknows.git

# 推送到GitHub
git push -u origin main
```

### 方式二：使用脚本自动化（已创建）

```bash
cd /Volumes/13EjectionPlug/code/dev-wiki-website/repo
./init-repo.sh
```

---

## 验证Workflow是否上传成功

推送后，访问：

```
https://github.com/yyh0808/monkeyknows/tree/main/.github/workflows
```

你应该能看到 `merge-entry.yml` 文件。

---

## 配置GitHub Secrets

推送workflow后，配置以下Secrets：

1. 访问: `https://github.com/yyh0808/monkeyknows/settings/secrets/actions`

2. 点击 "New repository secret" 添加：

   | Secret Name | Value | 说明 |
   |------------|-------|------|
   | `CF_ACCOUNT_ID` | 你的Cloudflare账号ID | 在Cloudflare Dashboard右侧可以找到 |
   | `CF_API_TOKEN` | Cloudflare API Token | 需要 Workers KV Storage → Edit 权限 |
   | `CF_KV_NAMESPACE_ID` | KV Namespace ID | 从 wrangler.toml 复制 |

3. 保存所有Secrets

---

## 测试完整流程

### 前提条件

1. ✅ GitHub repo已推送（包含workflow文件）
2. ✅ GitHub Secrets已配置
3. ✅ 本地.env文件已配置GitHub相关变量：

   ```
   GITHUB_PAT=ghp_xxx
   GITHUB_REPO_OWNER=yyh0808
   GITHUB_REPO_NAME=monkeyknows
   ```

4. ✅ 测试账号已创建（一个admin，一个user）

### 测试步骤

#### Test 1: 普通用户创建Entry → 生成PR

```bash
# 启动本地开发服务器
npm run dev
```

1. 在浏览器打开 `http://localhost:3000`
2. 以普通用户登录
3. 导航到创建Entry页面（如果有的话）
4. 填写Entry信息并提交

**预期结果**:

- ✅ 前端收到响应，包含 `prUrl`
- ✅ GitHub上出现新PR，包含Entry的JSON文件
- ✅ PR有 `type:new-entry` 和 `status:pending` 标签

#### Test 2: 合并PR → 自动更新KV

1. 在GitHub上review刚创建的PR
2. 点击"Merge pull request"
3. 观察Actions标签页

**预期结果**:

- ✅ GitHub Actions workflow自动运行
- ✅ Workflow成功完成（绿色✓）
- ✅ PR下出现成功评论
- ✅ Cloudflare KV中有新Entry数据
- ✅ 网站上可以看到新Entry

#### Test 3: 管理员用户直接创建Entry

1. 以admin用户登录
2. 创建Entry并提交

**预期结果**:

- ✅ Entry立即出现在网站上
- ✅ 不会创建GitHub PR
- ✅ KV中直接有数据

---

## 当前代码工作原理

### 本地开发环境流程

```
用户填写Entry表单
       ↓
POST /api/entries
       ↓
检查用户角色 (server/api/entries/index.post.ts)
       ↓
   ┌───┴───┐
   ↓       ↓
Admin    User
   ↓       ↓
直接     调用GitHubService.createEntryPR()
插入     (server/utils/github.ts)
KV       ↓
   ↓    在GitHub创建PR
   ↓    (使用GITHUB_PAT)
   ↓       ↓
   └───────┘
```

### GitHub PR合并流程

```
PR被合并
   ↓
触发 .github/workflows/merge-entry.yml
   ↓
读取Entry JSON文件
   ↓
调用Cloudflare KV API
   ↓
获取当前KV数据
   ↓
添加新Entry (用jq处理)
   ↓
更新KV数据
   ↓
在PR上发评论（成功/失败）
```

---

## 故障排查

### 问题1: PR创建失败

**可能原因**:

- GITHUB_PAT权限不足
- GITHUB_REPO_OWNER/NAME配置错误
- GitHub API rate limit

**解决方案**:

```bash
# 检查环境变量
cat .env | grep GITHUB

# 测试GitHub token
curl -H "Authorization: Bearer $GITHUB_PAT" https://api.github.com/user
```

### 问题2: Workflow不运行

**可能原因**:

- Workflow文件未推送到GitHub
- Secrets未配置

**解决方案**:

```bash
# 检查workflow是否存在
curl https://api.github.com/repos/yyh0808/monkeyknows/contents/.github/workflows
```

### 问题3: KV更新失败

**可能原因**:

- CF_API_TOKEN权限不足
- KV Namespace ID错误

**解决方案**:
检查GitHub Actions日志，查看具体错误信息

---

## 下一步行动清单

- [ ] 1. 进入repo目录，初始化独立git仓库
- [ ] 2. 推送到GitHub: `git push -u origin main`
- [ ] 3. 在GitHub配置三个Secrets
- [ ] 4. 创建测试账号（admin和user）
- [ ] 5. 本地测试用户PR创建
- [ ] 6. GitHub上合并PR测试
- [ ] 7. 验证KV数据更新
- [ ] 8. 验证网站显示新Entry

---

## 重要提醒

1. **安全**: repo目录会被推送到公开仓库，确保没有敏感信息
2. **Secrets**: 所有敏感信息都在GitHub Secrets中，不在代码里
3. **测试**: 先在本地测试PR创建，确认GitHub token有效
4. **KV结构**: 确保KV中的数据结构是 `{ entries: [...], versions: [...] }`
