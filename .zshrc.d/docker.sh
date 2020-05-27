
alias drmi=docker rmi -f $(docker images -f dangling=true)
