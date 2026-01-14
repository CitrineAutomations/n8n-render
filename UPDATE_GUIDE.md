# N8N Update Guide for Render

## 🚨 CRITICAL SECURITY UPDATE REQUIRED

**CVE-2025-68668**: A critical vulnerability exists in N8N versions before 1.111.0. 
**Update immediately** to version 1.111.0 or later.

See [CRITICAL_SECURITY_ALERT.md](CRITICAL_SECURITY_ALERT.md) for details.

---

# N8N Update Guide for Render

## Quick Update (Recommended)

### Method 1: Automatic Updates via Render Dashboard

1. **Login to Render**: https://dashboard.render.com
2. **Select your N8N service** (n8n-render)
3. **Manual Deploy**:
   - Click "Manual Deploy" → "Deploy latest commit"
   - This will pull the latest `n8nio/n8n:latest` image

### Method 2: Update to Specific Version

If you want to pin to a specific n8n version:

1. **Edit `Dockerfile`**:
   ```dockerfile
   FROM n8nio/n8n:1.70.0  # Change to desired version
   ```

2. **Commit and push**:
   ```bash
   git add Dockerfile
   git commit -m "Update n8n to version 1.70.0"
   git push origin main
   ```

3. **Render will auto-deploy** (if auto-deploy is enabled)
   - Or manually deploy from dashboard

## Before Updating

### 1. Backup Your Data

**CRITICAL**: Always backup before major updates!

```bash
# Export workflows (if you have the export script)
bash export_workflows.sh

# Or manually export from N8N UI:
# Settings → Workflows → Export All
```

### 2. Check Breaking Changes

- Visit [N8N Changelog](https://github.com/n8n-io/n8n/releases)
- Review breaking changes for your version
- Read migration guides if upgrading major versions

### 3. Review n8n 2.0 Changes

If updating from pre-2.0 to 2.0+, review:
- [N8N 2.0 Migration Guide](https://github.com/CitrineAutomations/n8n-render/blob/main/MIGRATION_2.0.md)
- OAuth callbacks now require authentication
- Binary data mode changes

## Update Process

### Step-by-Step Update

1. **Backup** (see above)

2. **Check current version**:
   - Log into your N8N instance
   - Go to Settings → About
   - Note your current version

3. **Update Dockerfile** (optional - for specific version):
   ```dockerfile
   # For latest stable
   FROM n8nio/n8n:latest
   
   # Or for specific version
   FROM n8nio/n8n:1.70.0
   ```

4. **Commit changes** (if you modified Dockerfile):
   ```bash
   git add Dockerfile
   git commit -m "Update n8n to latest version"
   git push origin main
   ```

5. **Deploy on Render**:
   - Go to Render Dashboard
   - Select your n8n-render service
   - Click "Manual Deploy" → "Deploy latest commit"
   - Wait for deployment to complete (2-5 minutes)

6. **Verify update**:
   - Visit your N8N instance
   - Check Settings → About for new version
   - Test critical workflows
   - Check logs for errors

## Troubleshooting Updates

### Issue: Service won't start after update

1. **Check Render logs**:
   - Dashboard → Your Service → Logs
   - Look for error messages

2. **Common issues**:
   - Database migration failures
   - Missing environment variables
   - Breaking changes in n8n

3. **Rollback if needed**:
   ```bash
   # Revert to previous Dockerfile
   git revert HEAD
   git push origin main
   ```

### Issue: Workflows not working after update

1. **Check workflow compatibility**:
   - Review n8n changelog for node changes
   - Test workflows individually
   - Update node configurations if needed

2. **Check environment variables**:
   - Ensure `WEBHOOK_URL` is correct
   - Verify all required variables are set

### Issue: Database migration errors

1. **Check database connection**:
   - Verify database is running
   - Check connection variables

2. **Manual migration** (if needed):
   - SSH into Render service (if available)
   - Run migration commands manually

## Update Schedule

### Recommended Update Frequency

- **Security patches**: Immediately
- **Minor versions**: Monthly
- **Major versions**: Quarterly (after testing)

### Stay Informed

- Watch [n8n GitHub releases](https://github.com/n8n-io/n8n/releases)
- Join [n8n Community](https://community.n8n.io/)
- Enable Render email notifications

## Version Pinning Strategy

### Option 1: Always Latest (Default)
```dockerfile
FROM n8nio/n8n:latest
```
**Pros**: Always up-to-date, automatic security patches
**Cons**: Potential breaking changes

### Option 2: Pin to Major Version
```dockerfile
FROM n8nio/n8n:1
```
**Pros**: Automatic minor/patch updates, no breaking changes
**Cons**: Manual major version upgrades needed

### Option 3: Pin to Specific Version
```dockerfile
FROM n8nio/n8n:1.70.0
```
**Pros**: Complete control, predictable behavior
**Cons**: Manual updates for everything, including security patches

## Post-Update Checklist

- [ ] N8N instance is accessible
- [ ] Version number updated in About page
- [ ] Critical workflows tested
- [ ] Webhooks working correctly
- [ ] No errors in Render logs
- [ ] Database connection healthy
- [ ] Backup created and verified

## Emergency Rollback

If something goes wrong:

1. **Quick rollback**:
   ```bash
   git revert HEAD
   git push origin main
   ```

2. **Or redeploy previous commit**:
   - Render Dashboard → Deploys
   - Find previous successful deploy
   - Click "Redeploy"

3. **Restore from backup** (if needed):
   - Import workflows from backup
   - Restore database if necessary

## Resources

- [N8N Official Docs](https://docs.n8n.io/)
- [N8N Docker Hub](https://hub.docker.com/r/n8nio/n8n)
- [CitrineAutomations n8n-render](https://github.com/CitrineAutomations/n8n-render)
- [Render Documentation](https://render.com/docs)

