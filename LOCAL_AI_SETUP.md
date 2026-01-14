# Setting Up Local AI Starter Kit (Optional)

This guide helps you set up the official [n8n-io/self-hosted-ai-starter-kit](https://github.com/n8n-io/self-hosted-ai-starter-kit) for local development alongside your Render production instance.

## Why Run Locally?

- 🆓 **Free local AI** with Ollama (Llama, Mistral, etc.)
- 🔒 **Complete privacy** - data never leaves your machine
- 🚀 **Fast development** - no deployment delays
- 💰 **No API costs** - unlimited AI requests
- 🧪 **Safe testing** - experiment without affecting production

## Prerequisites

### Required
- ✅ **Docker Desktop** - [Download here](https://docs.docker.com/get-docker/)
- ✅ **8GB+ RAM** - 16GB recommended for AI models
- ✅ **10GB+ free disk space** - for Docker images and models
- ✅ **Git** - for cloning the repository

### Optional (for better performance)
- 🎮 **Nvidia GPU** - for faster AI inference
- 🎮 **AMD GPU** (Linux only) - for faster AI inference
- 💻 **Apple Silicon Mac** - can run Ollama natively

## Installation Steps

### Step 1: Install Docker Desktop

**Windows:**
1. Download from https://docs.docker.com/desktop/install/windows-install/
2. Run installer
3. Restart computer
4. Open Docker Desktop
5. Verify: `docker --version` in PowerShell

**Mac:**
1. Download from https://docs.docker.com/desktop/install/mac-install/
2. Drag to Applications
3. Open Docker Desktop
4. Verify: `docker --version` in Terminal

### Step 2: Clone the Repository

```bash
# Navigate to your development folder
cd C:\Users\nuhbu\Documents\Development

# Clone the official AI starter kit
git clone https://github.com/n8n-io/self-hosted-ai-starter-kit.git

# Enter the directory
cd self-hosted-ai-starter-kit
```

### Step 3: Configure Environment

```bash
# Copy the example environment file
cp .env.example .env

# Edit .env file (optional - defaults work fine)
notepad .env
```

**Recommended .env settings:**
```env
# PostgreSQL
POSTGRES_USER=postgres
POSTGRES_PASSWORD=your_secure_password_here
POSTGRES_DB=n8n

# n8n
N8N_ENCRYPTION_KEY=your_32_character_encryption_key
N8N_USER_MANAGEMENT_JWT_SECRET=your_64_character_jwt_secret

# Ollama (leave as default)
OLLAMA_HOST=ollama:11434
```

### Step 4: Start the Stack

**For CPU-only (most users):**
```bash
docker compose --profile cpu up
```

**For Nvidia GPU users:**
```bash
docker compose --profile gpu-nvidia up
```

**For AMD GPU users (Linux only):**
```bash
docker compose --profile gpu-amd up
```

**For Mac users running Ollama natively:**
```bash
# Install Ollama on Mac first: https://ollama.ai
# Then run:
docker compose up
```

### Step 5: Access n8n

1. Wait for all services to start (2-5 minutes)
2. Open browser to **http://localhost:5678**
3. Create your local n8n account
4. Explore the included AI workflows!

## What's Included

### Services Running

| Service | URL | Purpose |
|---------|-----|---------|
| **n8n** | http://localhost:5678 | Workflow automation |
| **Ollama** | http://localhost:11434 | Local LLM server |
| **Qdrant** | http://localhost:6333 | Vector database |
| **PostgreSQL** | localhost:5432 | Data storage |

### Pre-configured AI Workflows

The starter kit includes example workflows:
1. **AI Chat** - Chat with local LLMs
2. **Document Q&A** - Ask questions about PDFs
3. **AI Agent** - Autonomous AI assistant
4. **Vector Search** - Semantic search with Qdrant

## Using Local AI Models

### Download Models with Ollama

```bash
# List available models
docker exec -it ollama ollama list

# Download Llama 3.2 (recommended, ~2GB)
docker exec -it ollama ollama pull llama3.2

# Download Mistral (alternative, ~4GB)
docker exec -it ollama ollama pull mistral

# Download smaller model for testing (~1GB)
docker exec -it ollama ollama pull phi3
```

### Using Models in n8n

1. Open workflow in n8n
2. Add "Ollama" node
3. Select model (e.g., "llama3.2")
4. Configure prompt
5. Execute!

## Connecting to Your Render Instance

### Export Workflows from Local

1. In local n8n (http://localhost:5678)
2. Go to **Settings** → **Workflows**
3. Click **Export All**
4. Save JSON file

### Import to Render

1. Log into Render n8n (https://n8n-render-e8rh.onrender.com)
2. Go to **Settings** → **Workflows**
3. Click **Import**
4. Upload JSON file
5. **Update credentials**:
   - Replace Ollama with OpenAI/Anthropic
   - Update localhost URLs to production URLs
   - Configure webhooks with Render URL

## Troubleshooting

### Docker Desktop Not Starting
- Ensure virtualization is enabled in BIOS
- Check Windows features: Hyper-V, WSL2
- Restart computer
- Check Docker Desktop logs

### Services Won't Start
```bash
# Check logs
docker compose logs

# Restart services
docker compose down
docker compose --profile cpu up

# Clean restart (removes data!)
docker compose down -v
docker compose --profile cpu up
```

### Ollama Model Download Slow
- Models are large (1-7GB)
- First download takes time
- Check internet connection
- Use smaller models for testing (phi3)

### n8n Can't Connect to Ollama
1. Check Ollama is running: `docker ps`
2. Verify OLLAMA_HOST in .env
3. For Mac with native Ollama:
   - Set `OLLAMA_HOST=host.docker.internal:11434`
   - Update Ollama credential in n8n to `http://host.docker.internal:11434/`

### Out of Memory Errors
- Close other applications
- Use smaller AI models
- Increase Docker memory limit (Docker Desktop → Settings → Resources)
- Upgrade RAM if possible

## Managing the Stack

### Start Services
```bash
docker compose --profile cpu up
```

### Start in Background
```bash
docker compose --profile cpu up -d
```

### Stop Services
```bash
docker compose down
```

### View Logs
```bash
# All services
docker compose logs

# Specific service
docker compose logs n8n
docker compose logs ollama

# Follow logs
docker compose logs -f
```

### Update Services
```bash
# Pull latest images
docker compose pull

# Recreate containers
docker compose down
docker compose --profile cpu up
```

### Clean Up (removes all data!)
```bash
docker compose down -v
```

## Performance Tips

### For Better AI Performance

1. **Use GPU** if available (Nvidia/AMD)
2. **Increase Docker memory** (Docker Desktop → Settings → Resources)
3. **Use smaller models** for testing (phi3, tinyllama)
4. **Close other applications** when running AI
5. **Use SSD** for Docker storage

### For Better n8n Performance

1. **Disable unnecessary nodes** in Settings
2. **Use execution data settings** to limit history
3. **Run in background** (`-d` flag)
4. **Monitor resources** with `docker stats`

## Security Notes

### Local Setup is Private

- ✅ All data stays on your machine
- ✅ No external API calls (unless you add them)
- ✅ Models run locally
- ✅ Perfect for sensitive data

### But Still Secure It

- 🔒 Don't expose ports publicly
- 🔒 Use strong passwords in .env
- 🔒 Keep Docker updated
- 🔒 Don't commit .env to Git
- 🔒 Use firewall rules

## Comparison: Local vs Render

| Feature | Local AI Kit | Render (Your Production) |
|---------|--------------|--------------------------|
| **Cost** | Free | ~$14/month |
| **AI Models** | Local (Ollama) | Cloud APIs (OpenAI) |
| **Privacy** | Complete | Depends on APIs used |
| **Availability** | When PC is on | 24/7 |
| **Performance** | Your hardware | Cloud servers |
| **Internet** | Optional | Required |
| **Webhooks** | Local only | Public URLs |
| **Best For** | Development | Production |

## Next Steps

### Learn More
- 📚 [N8N AI Documentation](https://docs.n8n.io/integrations/builtin/cluster-nodes/root-nodes/n8n-nodes-langchain/)
- 🎥 [N8N AI Video Tutorials](https://www.youtube.com/c/n8n-io)
- 💬 [N8N Community Forum](https://community.n8n.io)
- 🤖 [Ollama Models](https://ollama.ai/library)

### Try These Workflows
1. **Chat with PDFs** - Upload documents, ask questions
2. **AI Agent** - Build autonomous assistants
3. **Sentiment Analysis** - Analyze text sentiment
4. **Text Summarization** - Summarize long documents
5. **Vector Search** - Semantic search with Qdrant

### Integrate with Render
1. Develop workflows locally
2. Test with local AI
3. Export and import to Render
4. Switch to cloud AI APIs
5. Deploy to production!

## Resources

- **Official Repo**: https://github.com/n8n-io/self-hosted-ai-starter-kit
- **Docker Desktop**: https://docs.docker.com/get-docker/
- **Ollama**: https://ollama.ai
- **N8N Docs**: https://docs.n8n.io
- **Qdrant Docs**: https://qdrant.tech/documentation/

## Support

Having issues? Check:
1. Docker Desktop is running
2. Ports 5678, 11434, 6333, 5432 are available
3. Enough disk space (10GB+)
4. Enough RAM (8GB+)
5. Docker logs for errors

Still stuck? Visit the [N8N Community Forum](https://community.n8n.io) for help!

