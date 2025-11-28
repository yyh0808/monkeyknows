# Contributing Guide

Thank you for contributing to "Monkey Knows Wiki"!

## ⚠️ Important Notice

**Please DO NOT submit PRs directly to this repository!**

This is an automated review repository. All PRs are automatically created by the system. If you want to contribute content, please:

1. Visit the website [monkeyknows.wiki](https://monkeyknows.wiki)
2. Register/Login to your account
3. Use the website's editor to create or edit wiki entries
4. The system will automatically create a PR to this repository

## 📊 Wiki Entry Data Structure

Each wiki entry is a JSON file containing the following fields:

### Required Fields

```json
{
  "slug": "entry-slug",
  "title": "Entry Title",
  "category": "General",
  "tags": ["tag1", "tag2"],
  "language": "en",
  "authorId": "user-uuid",
  "sections": [
    {
      "id": "uuid",
      "type": "introduction",
      "title": "Introduction",
      "content": "# Markdown content here",
      "order": 0,
      "required": true
    }
  ]
}
```

### Section Types

Available section types:

- `introduction` - Introduction
- `features` - Features
- `installation` - Installation
- `usage` - Usage
- `api` - API Reference
- `examples` - Examples
- `troubleshooting` - Troubleshooting
- `faq` - FAQ
- `custom` - Custom

### Optional Fields

```json
{
  "type": "Library",
  "license": "MIT",
  "version": "1.0.0",
  "stars": 1000,
  "author": "Author Name",
  "documentationUrl": "https://...",
  "officialWebsiteUrl": "https://...",
  "forumUrl": "https://...",
  "tutorialVideoUrl": "https://...",
  "reliabilityIndex": 8,
  "securityRisk": "Low",
  "applicableScenarios": ["Web", "Mobile"],
  "comparison": ["similar-tool-1", "similar-tool-2"],
  "dependencyTopology": ["dependency-1"],
  "userProjectReviews": [
    {
      "user": "username",
      "comment": "Great tool!",
      "rating": 5
    }
  ]
}
```

## 🔍 Review Criteria

Administrators will check the following when reviewing PRs:

### Content Quality

- [ ] Clear and accurate title
- [ ] Contains at least one section
- [ ] Content uses Markdown format
- [ ] No spelling errors
- [ ] Technical information is accurate

### Data Format

- [ ] Valid JSON format
- [ ] All required fields are present
- [ ] Sections array is not empty
- [ ] Section order fields are correct

### Originality

- [ ] Content is not plagiarized
- [ ] Fits the website's focus (technical development)
- [ ] No advertising or promotional content

## 🚫 Rejection Criteria

PRs will be rejected in the following cases:

- ❌ Poor content quality
- ❌ Contains advertising/marketing content
- ❌ Plagiarized content
- ❌ Incorrect data format
- ❌ Contains malicious code
- ❌ Violates laws and regulations

## 📝 Markdown Guidelines

The content field supports standard Markdown syntax:

```markdown
# Heading 1
## Heading 2
### Heading 3

**Bold** *Italic*

- List item 1
- List item 2

1. Numbered item
2. Another item

[Link](https://example.com)

`inline code`

\`\`\`javascript
// Code block
console.log('Hello');
\`\`\`

> Blockquote

| Table | Header |
|-------|--------|
| Cell  | Cell   |
```

## 🔄 Editing Workflow

**Note**: Entry editing is currently not supported. Only new entry creation is available.

When creating a new entry:

1. Fill in all required information on the website
2. System creates a PR with your entry data
3. Administrator reviews the PR
4. After approval, PR is merged
5. Entry data is automatically added to the data store
6. Entry becomes publicly available on the website

## 👥 Role Description

### Regular User (User)

- Can create new wiki entries
- Submissions create PRs awaiting review
- Can view PR status in personal profile

### Administrator (Admin)

- Create/edit entries take effect immediately without PR
- Can review and merge other users' PRs
- Can manage repository labels

## 📮 Contact Us

If you have questions, please contact us via:

- Website feedback form
- GitHub Issues (main repository)
- Email: <support@monkeyknows.wiki>

---

Thank you again for your contribution! 🎉
