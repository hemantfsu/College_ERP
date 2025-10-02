# Deployment Guide - College ERP System

## 🌐 Deployment Options

### Option 1: Vercel (Recommended - Free Tier)

#### Prerequisites
- GitHub account
- Vercel account (sign up at https://vercel.com)

#### Steps
1. **Push code to GitHub**
   ```bash
   cd /Users/hemantbaghel/Desktop/college-erp
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/yourusername/college-erp.git
   git push -u origin main
   ```

2. **Deploy to Vercel**
   - Go to https://vercel.com/new
   - Import your GitHub repository
   - Vercel auto-detects Vite configuration
   - Click "Deploy"
   - Your app will be live at `https://your-project.vercel.app`

3. **Configure Environment Variables** (if needed)
   - Go to Project Settings → Environment Variables
   - Add variables like:
     ```
     VITE_API_URL=https://your-api.com
     ```

#### Auto-Deploy
- Every push to main branch automatically deploys
- Preview deployments for pull requests
- Rollback to previous deployments with one click

---

### Option 2: Netlify (Free Tier)

#### Steps
1. **Build the project**
   ```bash
   npm run build
   ```

2. **Deploy via Netlify CLI**
   ```bash
   # Install Netlify CLI
   npm install -g netlify-cli
   
   # Login to Netlify
   netlify login
   
   # Deploy
   netlify deploy --prod
   ```

3. **Or use drag-and-drop**
   - Go to https://app.netlify.com/drop
   - Drag the `dist` folder
   - Site is live instantly

#### Custom Domain
- Go to Site Settings → Domain Management
- Add custom domain
- Configure DNS records

---

### Option 3: GitHub Pages (Free)

#### Steps
1. **Install gh-pages**
   ```bash
   npm install --save-dev gh-pages
   ```

2. **Update package.json**
   ```json
   {
     "homepage": "https://yourusername.github.io/college-erp",
     "scripts": {
       "predeploy": "npm run build",
       "deploy": "gh-pages -d dist"
     }
   }
   ```

3. **Update vite.config.ts**
   ```typescript
   export default defineConfig({
     base: '/college-erp/',
     plugins: [react()],
   })
   ```

4. **Deploy**
   ```bash
   npm run deploy
   ```

5. **Configure GitHub Pages**
   - Go to repository Settings → Pages
   - Source: gh-pages branch
   - Save

---

### Option 4: Docker Container

#### Dockerfile
Create `Dockerfile` in project root:
```dockerfile
# Build stage
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

#### nginx.conf
Create `nginx.conf`:
```nginx
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

#### Build and Run
```bash
# Build image
docker build -t college-erp .

# Run container
docker run -p 80:80 college-erp

# Access at http://localhost
```

---

### Option 5: AWS S3 + CloudFront

#### Steps
1. **Build project**
   ```bash
   npm run build
   ```

2. **Create S3 bucket**
   - Go to AWS S3 Console
   - Create bucket (e.g., `college-erp-prod`)
   - Enable static website hosting
   - Upload `dist` folder contents

3. **Set up CloudFront**
   - Create CloudFront distribution
   - Origin: Your S3 bucket
   - Configure caching
   - Set up SSL certificate

4. **Configure Route 53** (optional)
   - Point custom domain to CloudFront

#### Automated Deploy Script
```bash
#!/bin/bash
npm run build
aws s3 sync dist/ s3://college-erp-prod --delete
aws cloudfront create-invalidation --distribution-id YOUR_ID --paths "/*"
```

---

## 🔧 Environment Configuration

### Production Environment Variables

Create `.env.production`:
```env
VITE_API_URL=https://api.collegeerp.com
VITE_GOOGLE_SHEETS_API_KEY=your_production_key
VITE_GOOGLE_DRIVE_API_KEY=your_production_key
VITE_PAYMENT_GATEWAY_KEY=your_production_key
VITE_ENABLE_ANALYTICS=true
VITE_ENABLE_ERROR_TRACKING=true
```

### Build Configuration

Update `vite.config.ts` for production:
```typescript
export default defineConfig({
  plugins: [react()],
  build: {
    outDir: 'dist',
    sourcemap: false,
    minify: 'terser',
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom', 'react-router-dom'],
          charts: ['recharts'],
          pdf: ['jspdf'],
        }
      }
    }
  },
  server: {
    port: 3000,
  },
  preview: {
    port: 4173,
  }
})
```

---

## 🔒 Security Checklist

### Pre-Deployment
- [ ] Remove console.log statements
- [ ] Remove mock/test data
- [ ] Set up environment variables
- [ ] Enable HTTPS
- [ ] Configure CORS properly
- [ ] Add rate limiting
- [ ] Implement authentication
- [ ] Set up error tracking (Sentry)
- [ ] Configure CSP headers
- [ ] Enable security headers

### Security Headers (nginx example)
```nginx
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "no-referrer-when-downgrade" always;
add_header Content-Security-Policy "default-src 'self' https:; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline';" always;
```

---

## 📊 Performance Optimization

### Build Optimization
```bash
# Analyze bundle size
npm run build -- --mode production
npx vite-bundle-visualizer
```

### Code Splitting
```typescript
// Lazy load routes
const Dashboard = lazy(() => import('./pages/Dashboard'));
const Admissions = lazy(() => import('./pages/Admissions'));

// Use Suspense
<Suspense fallback={<Loading />}>
  <Routes>
    <Route path="/" element={<Dashboard />} />
  </Routes>
</Suspense>
```

### Image Optimization
- Use WebP format
- Compress images
- Implement lazy loading
- Use CDN for static assets

### Caching Strategy
```typescript
// Service Worker for PWA
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/sw.js');
}
```

---

## 🧪 Pre-Deployment Testing

### Checklist
- [ ] Run production build locally
  ```bash
  npm run build
  npm run preview
  ```
- [ ] Test all routes
- [ ] Verify API endpoints
- [ ] Check responsive design
- [ ] Test form submissions
- [ ] Verify PDF generation
- [ ] Check localStorage persistence
- [ ] Test role switching
- [ ] Verify search functionality
- [ ] Test CSV export
- [ ] Check error handling

### Performance Testing
```bash
# Use Lighthouse
npx lighthouse http://localhost:4173 --view

# Expected scores:
# Performance: 90+
# Accessibility: 95+
# Best Practices: 90+
# SEO: 90+
```

---

## 🚀 Continuous Deployment (CI/CD)

### GitHub Actions Workflow

Create `.github/workflows/deploy.yml`:
```yaml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        
    - name: Install dependencies
      run: npm ci
      
    - name: Build
      run: npm run build
      
    - name: Run tests
      run: npm test
      
    - name: Deploy to Vercel
      uses: amondnet/vercel-action@v20
      with:
        vercel-token: ${{ secrets.VERCEL_TOKEN }}
        vercel-org-id: ${{ secrets.ORG_ID }}
        vercel-project-id: ${{ secrets.PROJECT_ID }}
        vercel-args: '--prod'
```

---

## 🔧 Monitoring & Analytics

### Error Tracking (Sentry)
```bash
npm install @sentry/react @sentry/tracing
```

```typescript
import * as Sentry from "@sentry/react";

Sentry.init({
  dsn: "your-sentry-dsn",
  integrations: [new Sentry.BrowserTracing()],
  tracesSampleRate: 1.0,
});
```

### Google Analytics
```typescript
// Add to index.html
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_ID"></script>
```

### Uptime Monitoring
- UptimeRobot (free)
- Pingdom
- StatusCake

---

## 💾 Database & Backend (Future)

### Recommended Stack
- **Backend**: Node.js + Express or Next.js API routes
- **Database**: PostgreSQL or MongoDB
- **ORM**: Prisma or Mongoose
- **API**: REST or GraphQL
- **Authentication**: NextAuth.js or Auth0

### Migration from localStorage
```typescript
// API integration example
const syncToBackend = async (students) => {
  await fetch('/api/students', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(students)
  });
};
```

---

## 📱 Mobile App Deployment (Future)

### React Native
- Convert to React Native
- Deploy to App Store & Play Store
- Use shared business logic

### Progressive Web App (PWA)
```javascript
// manifest.json
{
  "name": "College ERP",
  "short_name": "ERP",
  "icons": [
    {
      "src": "/icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    }
  ],
  "start_url": "/",
  "display": "standalone",
  "theme_color": "#0B5FFF"
}
```

---

## 🆘 Rollback Plan

### Quick Rollback (Vercel)
1. Go to Deployments
2. Find previous working deployment
3. Click "Promote to Production"

### Manual Rollback
```bash
# Revert to previous commit
git log
git revert <commit-hash>
git push
```

---

## 📞 Post-Deployment

### Launch Checklist
- [ ] Verify all features work in production
- [ ] Test payment processing
- [ ] Check email notifications
- [ ] Verify PDF generation
- [ ] Test integrations (Google Sheets, Drive)
- [ ] Monitor error logs
- [ ] Check performance metrics
- [ ] Set up alerts
- [ ] Create backup schedule
- [ ] Document any production-specific configurations
- [ ] Train staff/users
- [ ] Prepare support documentation

### Monitoring Dashboards
- Application metrics
- User analytics
- Error rates
- API response times
- Database performance

---

**Deployment completed?** Monitor logs for the first 24-48 hours and be ready for hotfixes.

**Last Updated**: October 2025
