# GitHub Setup Instructions

## Step 1: Create a New Repository on GitHub

1. Go to https://github.com/new
2. **Repository name**: `n8n-render-deployment` (or your preferred name)
3. **Description**: "Secure N8N deployment configuration for Render.com"
4. **Visibility**: 
   - ⚠️ **IMPORTANT**: Choose **Private** (recommended for security)
   - Or **Public** if you want to share (ensure no secrets are committed)
5. **DO NOT** initialize with README, .gitignore, or license (we already have these)
6. Click **"Create repository"**

## Step 2: Connect Your Local Repository

After creating the repository, GitHub will show you commands. Use these:

### If you chose a different repository name, replace `n8n-render-deployment` with your repo name:

```bash
# Add the remote (replace YOUR_USERNAME and REPO_NAME)
git remote add origin https://github.com/YOUR_USERNAME/n8n-render-deployment.git

# Rename branch to main (GitHub's default)
git branch -M main

# Push to GitHub
git push -u origin main
```

## Step 3: Verify Upload

1. Refresh your GitHub repository page
2. You should see all 13 files
3. **Verify** that `n8n-render.env` is **NOT** in the repository (it should be ignored)

## Step 4: Connect to Render

### Option A: Use Render Blueprint (Recommended)

1. Go to https://dashboard.render.com
2. Click **"New"** → **"Blueprint"**
3. Connect your GitHub account (if not already connected)
4. Select your `n8n-render-deployment` repository
5. Render will read the `render.yaml` file
6. Set the required environment variables (see below)
7. Click **"Apply"**

### Option B: Manual Deployment

1. Go to https://dashboard.render.com
2. Click **"New"** → **"Web Service"**
3. Connect your GitHub repository
4. Configure:
   - **Environment**: Docker
   - **Dockerfile Path**: `./Dockerfile`
   - **Region**: Choose closest to you
5. Add environment variables (see below)
6. Click **"Create Web Service"**

## Required Environment Variables in Render

⚠️ **CRITICAL**: Set these in Render Dashboard → Your Service → Environment

### Required Variables:
```
WEBHOOK_URL=https://your-app-name.onrender.com/
N8N_ENCRYPTION_KEY=<generate 32-character random string>
N8N_USER_MANAGEMENT_JWT_SECRET=<generate 64-character random string>
N8N_BASIC_AUTH_USER=admin@clearcouncil.com
N8N_BASIC_AUTH_PASSWORD=<your secure password>
```

### Generate Secure Keys (PowerShell):
```powershell
# 32-character encryption key
-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | ForEach-Object {[char]$_})

# 64-character JWT secret
-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 64 | ForEach-Object {[char]$_})
```

## Security Checklist

- [ ] Repository is set to **Private** (or you've verified no secrets are committed)
- [ ] `n8n-render.env` is **NOT** in GitHub (check the file list)
- [ ] Environment variables are set in **Render Dashboard** (not in code)
- [ ] Strong passwords generated for all credentials
- [ ] 2FA enabled on GitHub account
- [ ] 2FA enabled on Render account

## Troubleshooting

### "Permission denied" when pushing
**Solution**: Set up GitHub authentication:

**Option A: Personal Access Token (Recommended)**
1. Go to https://github.com/settings/tokens
2. Click **"Generate new token (classic)"**
3. Select scopes: `repo` (full control)
4. Copy the token
5. When pushing, use token as password

**Option B: SSH Key**
1. Generate SSH key: `ssh-keygen -t ed25519 -C "your_email@example.com"`
2. Add to GitHub: https://github.com/settings/keys
3. Change remote URL: `git remote set-url origin git@github.com:YOUR_USERNAME/n8n-render-deployment.git`

### "n8n-render.env" appears in GitHub
**Solution**: 
1. Remove from Git: `git rm --cached n8n-render.env`
2. Commit: `git commit -m "Remove sensitive env file"`
3. Push: `git push`

### Can't find repository on Render
**Solution**:
1. Ensure repository is connected to Render
2. Go to Render Dashboard → Account Settings → GitHub
3. Click "Configure" and grant access to your repository

## Next Steps

After pushing to GitHub:

1. ✅ Verify `n8n-render.env` is NOT in the repository
2. ✅ Connect repository to Render
3. ✅ Set environment variables in Render
4. ✅ Deploy to Render
5. ✅ Update to N8N 1.111.0+ (see QUICK_UPDATE.md)
6. ✅ Test your N8N instance

## Resources

- **GitHub Docs**: https://docs.github.com
- **Render Docs**: https://render.com/docs
- **Render Blueprint Guide**: https://render.com/docs/infrastructure-as-code
- **Security Guide**: See SECURITY_SETUP.md

---

**Ready to push?** Follow the commands in Step 2 above!

