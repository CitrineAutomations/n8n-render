# n8n 2.0 Migration Guide

This document outlines the changes made to this repository to ensure compatibility with n8n 2.0.

## Changes Applied

### 1. ✅ OAuth Callback Authentication (Medium Priority)
**Breaking Change**: OAuth callbacks now require authentication by default.

**Action Taken**:
- Added `N8N_SKIP_AUTH_ON_OAUTH_CALLBACK=false` to `render.yaml`
- This is now the default behavior in n8n 2.0, but we've made it explicit for clarity

**What to Test**:
- Test all OAuth integrations (Google, GitHub, etc.) to ensure they still work
- OAuth flows should now require users to be authenticated in n8n

**Reference**: [n8n 2.0 Breaking Changes - OAuth Callbacks](https://docs.n8n.io/2-0-breaking-changes/#require-authentication-on-oauth-callback-urls-by-default)

---

### 2. ✅ Binary Data Storage Mode (Low Priority)
**Breaking Change**: In-memory binary data mode has been removed.

**Action Taken**:
- Added `N8N_DEFAULT_BINARY_DATA_MODE=filesystem` to `render.yaml`
- Binary data will now be stored on the filesystem (default for regular mode)
- With PostgreSQL and disk mount configured, this ensures proper data persistence

**What to Monitor**:
- Monitor disk usage to ensure sufficient space for binary data
- Binary data is stored in the mounted disk at `/home/node/.n8n`

**Reference**: [n8n 2.0 Breaking Changes - Binary Data Mode](https://docs.n8n.io/2-0-breaking-changes/#remove-in-memory-binary-data-mode)

---

### 3. ✅ Docker Image Version (Medium Priority)
**Breaking Change**: Task runners removed from `n8nio/n8n` Docker image.

**Action Taken**:
- Updated Dockerfile to use `n8nio/n8n:stable` instead of `:latest`
- Added comments about task runner requirements

**Important Notes**:
- **If you use Python Code nodes**: You'll need to set up external task runners using the `n8nio/runners` Docker image
- **If you don't use Python Code nodes**: You can optionally remove Python3 from the Dockerfile to reduce image size
- The current Dockerfile includes Python3, suggesting Python Code nodes may be in use

**Next Steps** (if using Python Code nodes):
1. Deploy a separate service using `n8nio/runners` image
2. Configure `N8N_RUNNERS_ENABLED=true` in your environment
3. Set up external mode configuration
4. See [n8n Task Runners Documentation](https://docs.n8n.io/hosting/configuration/task-runners/)

**Reference**: [n8n 2.0 Breaking Changes - Task Runners](https://docs.n8n.io/2-0-breaking-changes/#remove-task-runner-from-n8nion8n-docker-image)

---

### 4. ✅ CLI Commands (Low Priority)
**Breaking Change**: `update:workflow` CLI command replaced with `publish:workflow` and `unpublish:workflow`.

**Action Taken**:
- No changes needed - the `export_workflows.sh` script uses `export:workflow` which is still valid
- No usage of `update:workflow` found in the codebase

**If You Use CLI Commands**:
- Replace `n8n update:workflow --id <id>` with `n8n publish:workflow --id <id>`
- Use `n8n unpublish:workflow --id <id>` to unpublish workflows

**Reference**: [n8n 2.0 Breaking Changes - CLI Commands](https://docs.n8n.io/2-0-breaking-changes/#replace-cli-command-updateworkflow)

---

### 5. ✅ Workflow Hooks (Low Priority)
**Breaking Change**: `workflow.activeChange` and `workflow.activeChangeCurrent` hooks deprecated.

**Action Taken**:
- No custom workflow hooks found in the codebase
- No changes needed

**If You Use Custom Hooks**:
- Replace `workflow.activeChange` with `workflow.published`
- Replace `workflow.activeChangeCurrent` with `workflow.published`

**Reference**: [n8n 2.0 Breaking Changes - Workflow Hooks](https://docs.n8n.io/2-0-breaking-changes/#deprecated-frontend-workflow-hooks)

---

### 6. ✅ Tunnel Option (Low Priority)
**Breaking Change**: `n8n --tunnel` CLI option removed.

**Action Taken**:
- No usage of `--tunnel` option found in the codebase
- No changes needed

**If You Use Tunneling**:
- Use alternatives like ngrok, localtunnel, or Cloudflare Tunnel

**Reference**: [n8n 2.0 Breaking Changes - Tunnel Option](https://docs.n8n.io/2-0-breaking-changes/#remove-n8n-tunnel-option)

---

## Testing Checklist

Before deploying to production, test the following:

- [ ] OAuth integrations (Google, GitHub, etc.) work correctly
- [ ] Webhooks receive and process data correctly
- [ ] Binary data (file uploads/downloads) work correctly
- [ ] Python Code nodes (if used) - verify they work or set up task runners
- [ ] Workflow executions complete successfully
- [ ] Database connections are stable
- [ ] Disk space is sufficient for binary data storage

## Deployment Steps

1. **Review Changes**: Review all changes in this migration guide
2. **Test Locally** (if possible): Test the updated configuration locally
3. **Update Environment Variables**: Ensure all new environment variables are set in Render dashboard
4. **Deploy**: Deploy the updated configuration to Render
5. **Monitor**: Monitor logs and execution data after deployment
6. **Verify**: Verify all workflows and integrations work as expected

## Rollback Plan

If issues occur after deployment:

1. Revert to previous Docker image tag (if needed)
2. Remove new environment variables if they cause issues
3. Check n8n logs for specific error messages
4. Consult [n8n 2.0 Migration Tool](https://docs.n8n.io/2-0-migration-tool/) if available

## Additional Resources

- [n8n 2.0 Breaking Changes Documentation](https://docs.n8n.io/2-0-breaking-changes/)
- [n8n 2.0 Migration Tool](https://docs.n8n.io/2-0-migration-tool/)
- [n8n Task Runners Documentation](https://docs.n8n.io/hosting/configuration/task-runners/)
- [n8n Community Forum](https://community.n8n.io/)

## Questions or Issues?

If you encounter any issues during migration:
1. Check the n8n logs in Render dashboard
2. Review the [n8n 2.0 Breaking Changes](https://docs.n8n.io/2-0-breaking-changes/) documentation
3. Visit the [n8n Community Forum](https://community.n8n.io/) for support

