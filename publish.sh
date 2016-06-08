npm run clean
npm run build
cd _book
git init
git commit -m 'update book'
git checkout -b gh-pages
git add .
git commit -m 'update book'
git push https://github.com/KleeGroup/focus-docs.git gh-pages --force
