#!/bin/bash

# Script to prepare a release branch with only necessary files for production use

echo "Creating release branch with production files only..."

# Build the library first
echo "Building library..."
pnpm build

# Create a new branch for release
BRANCH_NAME="release/production"
git checkout -b $BRANCH_NAME

# Remove all dev-related directories and files
echo "Removing development files..."
rm -rf test/
rm -rf cypress/
rm -rf stories/
rm -rf .storybook/
rm -rf csp-server/
rm -rf docs/
rm -rf site/
rm -rf .github/
rm -rf .husky/

# Remove dev configuration files
rm -f .eslintrc.js
rm -f .eslintignore
rm -f .prettierrc
rm -f .prettierignore
rm -f .stylelintrc
rm -f commitlint.config.js
rm -f cypress.config.ts
rm -f jest.config.ts
rm -f lighthouse.config.js
rm -f rollup.config.mjs
rm -f tsconfig.json
rm -f .release-it.json
rm -f .nvmrc
rm -f a11y-audit-parse.js

# Keep only essential config files
# Keep: package.json, README.md, LICENSE, CHANGELOG.md

# Update .gitignore to be minimal
cat > .gitignore << 'EOF'
node_modules/
.DS_Store
npm-debug.log*
yarn-error.log
EOF

# Commit the dist folder (normally gitignored)
git add -f dist/

# Commit all changes
git add .
git commit -m "chore: prepare production release branch"

echo "Release branch created!"
echo "To use this branch in another project:"
echo "  yarn add @hello-pangea/dnd@https://github.com/ReClimbDev/dnd.git#$BRANCH_NAME"
echo ""
echo "Or in package.json:"
echo '  "@hello-pangea/dnd": "https://github.com/ReClimbDev/dnd.git#'$BRANCH_NAME'"'
