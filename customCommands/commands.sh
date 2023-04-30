#DOCKER COMMANDS

# Usage dclog serviceName (dclog mobile-api) 
function dclog() { 
    docker-compose up $1 -d && docker-compose logs -f $1
}

# Usage dcdown serviceName (dcdown mobile-api)
function dcdown() {
     docker-compose down $1
}


# GIT COMMANDS

# Usage: gpull <branch>
# Example: gpull main
function gpull() {
    git pull origin $1;
}

# Usage: gpush <branch> <commit-message>
# Example: gpush main "Add new feature"
function gpush() {
    git add .;
    git commit -m "$2";
    git push origin $1;
}

# Usage: gbranch <branch>
# Example: gbranch new-feature
function gbranch() {
    git checkout -b $1;
}

# Usage: gmerge <source-branch> <destination-branch>
# Example: gmerge new-feature main
function gmerge() {
    git checkout $2;
    git merge $1;
}

# Usage: gstatus
function gstatus() {
    git status;
}

# Usage: glog
function glog() {
    git log --oneline --decorate --graph;
}
