export GOROOT="/usr/lib/go-{{ golang.version }}"
export GOPATH="$HOME/go"
PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
