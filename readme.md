# CC-CI-CD

Doing anything complex in computercraft has been a pain, there's no easy way to get code from your editor, to the minecraft computer, and then debug it... Until now

What this project aims to do is to provide automated deployment of code to ComputerCraft computers with as little input as possible.

Allowing for continuous updating through git (tags, branches and any other ref), as well as debugging through websockets (WIP).

To get started all you need to do is copy these two lines into your ComputerCraft Computer

```
wget https://raw.githubusercontent.com/faximilie/CC-CI-CD/main/bootstrap/stage-1.lua
stage-1 {git_url} {ref}
```

CC-CI-CD will take care of the rest. There will be more options later, to be configured in a config file in the root of your git project but for now that's not implemented.
