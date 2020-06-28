# Debugging zsh

## Finding where env vars come from (and more)
`zsh -xl`

## Profiling the startup time
From https://esham.io/2018/02/zsh-profiling
- At the beginning of `.zshrc` add `zmodload zsh/zprof`
- At the end, add `zprof`

Other resources:
- https://blog.askesis.pl/post/2017/04/how-to-debug-zsh-startup-time.html
- https://kevin.burke.dev/kevin/profiling-zsh-startup-time/
- https://medium.com/@jzelinskie/please-dont-ship-binaries-with-shell-completion-as-commands-a8b1bcb8a0d0


## Completions
- List completions
```zsh
for command completion in ${(kv)_comps:#-*(-|-,*)}
do
    printf "%-32s %s\n" $command $completion
done | sort
```
