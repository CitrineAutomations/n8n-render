# N8N Render Deployment Guide

This repository contains an optimized N8N setup specifically designed for Render deployment with memory optimizations to prevent heap out of memory errors.

## Key Optimizations Made

### 1. Memory Configuration
- Added `NODE_OPTIONS="--max-old-space-size=2048"` to increase heap size to 2GB
- Set `N8N_METRICS=false` to reduce memory usage
- Changed log level to `error` to minimize logging overhead

### 2. Resource Allocation
- Upgraded to `standard-2x` plan for more memory
- Increased database to `basic-2gb` plan
- Optimized Dockerfile by removing unnecessary build dependencies

### 3. Performance Settings
- Disabled metrics collection
- Optimized execution data pruning settings
- Reduced log verbosity

## Deployment Steps

### 1. Fork/Clone Repository
```bash
git clone https://github.com/CitrineAutomations/n8n-render.git
cd n8n-render
```

### 2. Update Environment Variables
Before deploying, update these values in `render.yaml`:

- `WEBHOOK_URL`: Set to your actual domain (e.g., `https://your-app.onrender.com/`)
- `N8N_ENCRYPTION_KEY`: Generate a secure random string
- `GENERIC_TIMEZONE` and `TZ`: Set to your timezone

### 3. Deploy on Render

#### Option A: Using Render Blueprint
1. Go to your Render Dashboard
2. Click "New" → "Blueprint"
3. Connect your GitHub repository
4. Render will automatically detect the `render.yaml` file
5. Update the environment variables as needed
6. Deploy

#### Option B: Manual Deployment
1. Create a new Web Service on Render
2. Connect your GitHub repository
3. Set the following environment variables manually:
   - `DB_TYPE=postgresdb`
   - `WEBHOOK_URL=https://your-app.onrender.com/`
   - `N8N_ENCRYPTION_KEY=your-secure-key`
   - `NODE_OPTIONS=--max-old-space-size=2048`
   - `N8N_METRICS=false`
   - `N8N_LOG_LEVEL=error`

### 4. Database Setup
- Render will automatically create a PostgreSQL database
- The connection details will be automatically configured

## Memory Issue Resolution

This setup specifically addresses the "JavaScript heap out of memory" error by:

1. **Increasing Heap Size**: `NODE_OPTIONS="--max-old-space-size=2048"`
2. **Reducing Memory Usage**: Disabled metrics and optimized logging
3. **Better Resource Allocation**: Upgraded to higher-tier plans
4. **Optimized Dependencies**: Removed unnecessary build tools

## Monitoring

After deployment:
1. Check Render logs for any startup issues
2. Monitor memory usage in Render dashboard
3. Verify N8N is accessible at your domain
4. Test webhook functionality

## Troubleshooting

### If you still experience memory issues:
1. Increase `NODE_OPTIONS` to `--max-old-space-size=4096`
2. Upgrade to a higher Render plan
3. Check for memory leaks in your workflows
4. Review execution data pruning settings

### Common Issues:
- **Webhooks not working**: Ensure `WEBHOOK_URL` is set correctly
- **Database connection errors**: Verify database credentials in Render
- **Permission issues**: Check file permissions in the container

## Support

For issues specific to this deployment:
- Check Render logs for detailed error messages
- Verify all environment variables are set correctly
- Ensure your Render plan has sufficient resources
