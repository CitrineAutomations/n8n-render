# Security Setup Guide for N8N on Render

## ⚠️ CRITICAL SECURITY STEPS

### 1. Secure Your Environment Variables

**NEVER** commit sensitive credentials to Git. All secrets should be stored in Render's Environment Variables.

### 2. Rotate Compromised Credentials

If your `.env` file was ever committed to a repository, **immediately rotate**:

1. **Database Password**: 
   - Go to Render Dashboard → Your Database → Settings
   - Rotate the database password
   - Update in your Web Service environment variables

2. **N8N Admin Password**:
   - Log into your N8N instance
   - Change your admin password
   - Update `N8N_BASIC_AUTH_PASSWORD` in Render

3. **Encryption Keys**:
   - Generate new keys (see below)
   - Update in Render environment variables
   - **WARNING**: Changing encryption keys may require data migration

### 3. Generate Secure Keys

Use these commands to generate secure random keys:

#### For N8N_ENCRYPTION_KEY (32 characters):
```bash
# PowerShell
-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | ForEach-Object {[char]$_})

# Or use online tool (from trusted source):
# https://www.random.org/strings/?num=1&len=32&digits=on&upperalpha=on&loweralpha=on&unique=on&format=html&rnd=new
```

#### For N8N_USER_MANAGEMENT_JWT_SECRET (64 characters):
```bash
# PowerShell
-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 64 | ForEach-Object {[char]$_})
```

### 4. Set Environment Variables in Render

1. Go to Render Dashboard: https://dashboard.render.com
2. Select your N8N web service
3. Go to **Environment** tab
4. Add/Update these variables:

#### Required Secrets (DO NOT use the values from your .env file if exposed):
- `N8N_ENCRYPTION_KEY` - Generate new 32-character key
- `N8N_USER_MANAGEMENT_JWT_SECRET` - Generate new 64-character key
- `N8N_BASIC_AUTH_PASSWORD` - Set a strong password
- `N8N_BASIC_AUTH_USER` - Your admin email
- `WEBHOOK_URL` - Your actual domain (e.g., `https://your-app.onrender.com`)

### 5. Secure Your Repository

Add to `.gitignore`:
```
*.env
.env
.env.local
.env.*.local
n8n-render.env
.n8n/
```

### 6. Check Git History

If you've already committed sensitive files:

```bash
# Check if .env was committed
git log --all --full-history -- "*.env"

# If found, you need to remove it from history:
# WARNING: This rewrites history, coordinate with your team
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch n8n-render.env" \
  --prune-empty --tag-name-filter cat -- --all

# Then force push (be careful!)
git push origin --force --all
```

### 7. Additional Security Measures

1. **Enable 2FA** on your Render account
2. **Use strong passwords** for N8N admin account
3. **Regularly update** N8N to get security patches
4. **Monitor logs** for suspicious activity
5. **Limit access** to your Render dashboard
6. **Use IP restrictions** if possible (Render Pro plan)

### 8. Verify Security

- [ ] `.env` files are in `.gitignore`
- [ ] No sensitive data in Git history
- [ ] All secrets stored in Render Environment Variables
- [ ] Strong passwords set for all accounts
- [ ] Encryption keys rotated if previously exposed
- [ ] 2FA enabled on Render account
- [ ] Regular security updates scheduled

## Resources

- [Render Environment Variables](https://render.com/docs/environment-variables)
- [N8N Security Best Practices](https://docs.n8n.io/hosting/security/)
- [OWASP Secrets Management](https://owasp.org/www-community/vulnerabilities/Use_of_hard-coded_password)

