#UTILITY COMMANDS
function myip(){
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
}
#DOCKER COMMANDS

# # Usage dclog serviceName (dclog mobile-api) 
# function dclog() { 
#     printCommand "docker-compose up $1 -d && docker-compose logs -f $1"
#     docker-compose up $1 -d && docker-compose logs -f $1
# }

# # Usage dcrun command (dcrun mobile-api yarn install)
# function dcrun() {
#     printCommand "docker-compose run --no-deps "${@}""
#   docker-compose run --no-deps "${@}"
# }

# Usage dclog [-f custom-compose-file] [serviceName] (dclog -f my-docker-compose.yml)
function dclog() {
  local service=
  local compose_file="docker-compose.yml"

  # Check for and parse the -f flag
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -f)
        compose_file="$2"
        shift 2
        ;;
      *)
        service="$1"
        shift
        ;;
    esac
  done

  if [ -n "$service" ]; then
    printCommand "docker-compose -f $compose_file up $service -d && docker-compose -f $compose_file logs -f $service"
    docker-compose -f "$compose_file" up "$service" -d && docker-compose -f "$compose_file" logs -f "$service"
  else
    printCommand "docker-compose -f $compose_file up -d && docker-compose -f $compose_file logs -f"
    docker-compose -f "$compose_file" up -d && docker-compose -f "$compose_file" logs -f
  fi
}


# Usage dcrun command [serviceName] -f custom-compose-file (dcrun command -f my-docker-compose.yml)
function dcrun() {
  local command="$1"
  local service="${2:-}"  # Use provided service name or leave it empty
  local compose_file="${3:-docker-compose.yal}"  # Use provided file or default to "docker-compose.yml"
  
  if [ -n "$service" ]; then
    printCommand "docker-compose -f $compose_file run --no-deps $service $command"
    docker-compose -f "$compose_file" run --no-deps "$service" "$command"
  else
    printCommand "docker-compose -f $compose_file run --no-deps $command"
    docker-compose -f "$compose_file" run --no-deps "$command"
  fi
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

# Usage: gpc
# Example: gpc 
function gpc() {
    current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    
    if [ -z "$current_branch" ]; then
        echo "Not on any branch."
        return 1
    fi
    
    git add .
    git push origin "$current_branch"
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

# Other Utilit
function checkinternet() {
       ping -c 1 google.com && echo "Internet is reachable" || echo "No internet connection"
}
