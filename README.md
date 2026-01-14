# N8N on Render - Secure Deployment

## 🚨 CRITICAL SECURITY ALERT

**CVE-2025-68668**: Update to N8N 1.111.0+ immediately!  
See [CRITICAL_SECURITY_ALERT.md](CRITICAL_SECURITY_ALERT.md) for details.

---

This repository contains the configuration for deploying N8N on Render.com using Docker.

Based on:
- [n8n-io/self-hosted-ai-starter-kit](https://github.com/n8n-io/self-hosted-ai-starter-kit) (Official)
- [CitrineAutomations/n8n-render](https://github.com/CitrineAutomations/n8n-render)
- Enhanced security practices

## 🚀 Quick Start

### You Have Two Options

**Option A: Update Your Existing Render Instance (Recommended)**
- You already have N8N running on Render
- See [QUICK_UPDATE.md](QUICK_UPDATE.md) for immediate update instructions
- **Action Required**: Update to version 1.111.0+ for security

**Option B: Add Local AI Development Environment (Optional)**
- Run the [official AI starter kit](https://github.com/n8n-io/self-hosted-ai-starter-kit) locally
- Free local AI with Ollama, Qdrant, and more
- See [LOCAL_AI_SETUP.md](LOCAL_AI_SETUP.md) for installation
- See [DEPLOYMENT_OPTIONS.md](DEPLOYMENT_OPTIONS.md) for comparison

### Your Current Setup

**Render Production Instance**:
- URL: https://n8n-render-e8rh.onrender.com
- Database: PostgreSQL on Render
- Status: Needs security update to 1.111.0+

### Quick Update (5 minutes)

1. Go to https://dashboard.render.com
2. Select your N8N service
3. Click "Manual Deploy" → "Deploy latest commit"
4. Wait 2-5 minutes
5. Verify version at Settings → About

See [QUICK_UPDATE.md](QUICK_UPDATE.md) for detailed instructions.

## 🔒 Security

**IMPORTANT**: This repository follows security best practices:

- ✅ No credentials in Git
- ✅ `.gitignore` configured for sensitive files
- ✅ Environment variables stored in Render
- ✅ Secure key generation documented

See [SECURITY_SETUP.md](SECURITY_SETUP.md) for detailed security instructions.

## 📦 What's Included

- `Dockerfile` - N8N Docker configuration
- `render.yaml` - Render Blueprint configuration
- `.gitignore` - Prevents committing sensitive files
- `SECURITY_SETUP.md` - Security best practices
- `UPDATE_GUIDE.md` - How to update N8N

## 🔄 Updating N8N

See [UPDATE_GUIDE.md](UPDATE_GUIDE.md) for detailed update instructions.

**Quick update**:
1. Go to Render Dashboard
2. Select your N8N service
3. Click "Manual Deploy" → "Deploy latest commit"

## 📁 File Structure

```
.
├── Dockerfile              # Docker configuration
├── render.yaml            # Render Blueprint
├── .gitignore             # Git ignore rules
├── README.md              # This file
├── SECURITY_SETUP.md      # Security guide
├── UPDATE_GUIDE.md        # Update instructions
└── n8n-render.env         # Local env template (NOT committed)
```

## ⚙️ Configuration

### Environment Variables

All configuration is done via Render's Environment Variables:

**Database** (auto-configured by Render):
- `DATABASE_TYPE=postgresdb`
- `DB_POSTGRESDB_*` - Auto-populated from database

**N8N Configuration**:
- `N8N_HOST=0.0.0.0`
- `N8N_PORT=5678`
- `N8N_PROTOCOL=https`
- `WEBHOOK_URL` - **Set to your domain**

**Security** (generate and set in Render):
- `N8N_ENCRYPTION_KEY` - 32-character random string
- `N8N_USER_MANAGEMENT_JWT_SECRET` - 64-character random string
- `N8N_BASIC_AUTH_USER` - Your admin email
- `N8N_BASIC_AUTH_PASSWORD` - Strong password

### Storage

- Persistent disk mounted at `/home/node/.n8n`
- 1GB storage (expandable)
- **Do not change mount path** - hardcoded in N8N

## 🐛 Troubleshooting

### Webhooks not working
- Ensure `WEBHOOK_URL` is set to your actual domain
- Check it ends with `/` (e.g., `https://your-app.onrender.com/`)

### Service won't start
- Check Render logs for errors
- Verify all required environment variables are set
- Ensure database is running

### Data persistence issues
- Verify disk is mounted at `/home/node/.n8n`
- Check disk size in Render Dashboard

## 📚 Resources

- [N8N Documentation](https://docs.n8n.io/)
- [Render Documentation](https://render.com/docs)
- [CitrineAutomations/n8n-render](https://github.com/CitrineAutomations/n8n-render)
- [N8N Community](https://community.n8n.io/)

## 📝 License

This configuration is based on the CitrineAutomations/n8n-render project.

## 🆘 Support

- Check [UPDATE_GUIDE.md](UPDATE_GUIDE.md) for update issues
- Check [SECURITY_SETUP.md](SECURITY_SETUP.md) for security concerns
- Visit [N8N Community](https://community.n8n.io/) for N8N-specific questions
- Check [Render Status](https://status.render.com/) for platform issues

## ⚠️ Important Notes

1. **Never commit `.env` files** with credentials
2. **Always backup** before major updates
3. **Rotate credentials** if exposed
4. **Keep N8N updated** for security patches
5. **Monitor Render logs** regularly

