# Wiki Entry Review Repository

This repository is used to review wiki entry submissions from [Monkey Knows Wiki](https://monkeyknows.wiki).

## 🎯 Purpose

This repository automatically receives wiki entry creation requests from users. All edits from non-admin users are submitted here as Pull Requests for review.

## 📋 Workflow

### For Regular Users

1. Create a new wiki entry on the website
2. System automatically creates a Pull Request to this repository
3. Wait for administrator review
4. After PR is merged, GitHub Action automatically updates the data store

### For Administrators

1. Review content changes in the PR
2. Check data format and content quality
3. Merge approved PRs
4. System automatically handles subsequent data updates

## 🏷️ PR Labels

This repository uses the following label system to identify PR types:

- `type:new-entry` - New wiki entry creation
- `status:pending` - Awaiting review
- `status:approved` - Approved
- `status:rejected` - Rejected

## 📁 Directory Structure

```
entries/
└── [slug].json          # Wiki entry JSON data file
```

## 🤖 Automation Workflow

### Creating New Entry

1. User submits → Creates PR (label: `type:new-entry`)
2. Administrator reviews and merges
3. GitHub Action triggers
4. Automatically updates Cloudflare KV data store
5. Entry becomes available on the website

## 🔒 Security

- All sensitive information (API keys, credentials) stored in GitHub Secrets
- PR data is strictly validated
- Only authorized administrators can merge PRs

## 📖 Data Format

Please refer to [CONTRIBUTING.md](./CONTRIBUTING.md) for the complete wiki entry data structure.

## ⚙️ GitHub Actions

This repository is configured with the following workflow:

- `.github/workflows/merge-entry.yml` - Automatically updates data store after PR merge

## 🔗 Related Links

- [Main Website](https://monkeyknows.wiki)
- [API Documentation](https://github.com/your-org/dev-wiki-website/blob/main/api.md)
- [Contributing Guide](./CONTRIBUTING.md)

## 📝 Important Notes

- **Do NOT** manually edit files in this repository
- **Do NOT** commit directly to the main branch
- All changes must be submitted through the website interface
- PRs are automatically created by the system and reviewed by humans

## 🚀 Setup for Administrators

### Required GitHub Secrets

Configure the following secrets in repository settings:

- `BACKEND_API_URL` - Your Cloudflare Pages URL (e.g., `https://your-site.pages.dev`)
- `GITHUB_WEBHOOK_SECRET` - Random secret string for webhook authentication
- `CF_ACCOUNT_ID` - Cloudflare account ID
- `CF_API_TOKEN` - Cloudflare API token with KV write permissions
- `CF_KV_NAMESPACE_ID` - KV namespace ID

### Cloudflare API Token Permissions

The API token must have the following permissions:

- Account → Workers KV Storage → Edit

---

**Maintainers**: Monkey Knows Wiki Team  
**Last Updated**: 2025-11-28
