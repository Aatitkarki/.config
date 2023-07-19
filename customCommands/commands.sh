#UTILITY COMMANDS
function myip(){
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
}
#DOCKER COMMANDS

# Usage dclog serviceName (dclog mobile-api) 
function dclog() { 
    printCommand "docker-compose up $1 -d && docker-compose logs -f $1"
    docker-compose up $1 -d && docker-compose logs -f $1
}

# Usage dcrun command (dcrun mobile-api yarn install)
function dcrun() {
    printCommand "docker-compose run --no-deps "${@}""
  docker-compose run --no-deps "${@}"
}

# Usage dcdown serviceName (dcdown mobile-api)
function dcdown() {
    printCommand "docker-compose down $1"
     docker-compose down $1
}

function printCommand(){
    local command=$1
    echo "Running command: $command "
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
