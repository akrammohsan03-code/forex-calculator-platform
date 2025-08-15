#!/bin/bash

echo "🔥 Building Forex Calculator Platform for GitHub Pages..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf docs
rm -rf dist

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Build the frontend
echo "🎨 Building frontend with Vite..."
npm run build

# Create docs folder for GitHub Pages
echo "📁 Setting up GitHub Pages structure..."
mkdir -p docs

# Copy built files to docs folder
echo "📋 Copying build files..."
cp -r dist/public/* docs/

# Create .nojekyll file to disable Jekyll processing
echo "⚙️ Configuring GitHub Pages settings..."
touch docs/.nojekyll

# Create index.html redirect if needed
echo "🔄 Setting up routing..."
cat > docs/404.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Forex Calculator Platform</title>
    <script>
        // Redirect 404s to index.html for SPA routing
        var pathSegmentsToKeep = 1;
        var l = window.location;
        l.replace(
            l.protocol + '//' + l.hostname + (l.port ? ':' + l.port : '') +
            l.pathname.split('/').slice(0, 1 + pathSegmentsToKeep).join('/') + 
            '/?/' + 
            l.pathname.slice(1).split('/').slice(pathSegmentsToKeep).join('/').replace(/&/g, '~and~') +
            (l.search ? '&' + l.search.slice(1).replace(/&/g, '~and~') : '') +
            l.hash
        );
    </script>
</head>
<body></body>
</html>
EOF

# Add GitHub Pages configuration
echo "📝 Creating GitHub Pages configuration..."
cat > docs/CNAME.example << 'EOF'
# Rename this file to CNAME and add your domain
# Example: yourdomain.com
# Don't include https:// or www
EOF

# Create success message
echo "✅ GitHub Pages build completed successfully!"
echo ""
echo "📊 Build Summary:"
echo "- Source files: $(find . -name '*.tsx' -o -name '*.ts' -o -name '*.css' | wc -l) files"
echo "- Build output: $(du -sh docs | cut -f1)"
echo "- Total files in docs: $(find docs -type f | wc -l) files"
echo ""
echo "🚀 Next Steps:"
echo "1. Commit and push all files to GitHub"
echo "2. Enable GitHub Pages in repository settings"
echo "3. Your site will be live at: https://USERNAME.github.io/REPOSITORY-NAME"
echo ""
echo "💡 For custom domain:"
echo "1. Rename docs/CNAME.example to docs/CNAME"
echo "2. Add your domain name to the CNAME file"
echo "3. Configure DNS at your domain registrar"