# git branch
# * master

# store last commit message
LAST_COMMIT=$(git log -1 --pretty=%B)
echo $LAST_COMMIT

# recreate gh-pages branch
git branch -D gh-pages
git checkout -b gh-pages

# Extract the generated _site into root of the branch
shopt -s extglob
rm !(_site) -r
mv _site/* ./
rm _site -r

# Add .nojekyll
touch .nojekyll

#adding changings
git add .
git commit -am $LAST_COMMIT

# go to source branch
git checkout source

# push it all to the server 
git push --all -f