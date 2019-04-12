## Dev Machine

Using Vagrant, VirtualBox, Ansible and Ubuntu, bring up a new general purpose development machine.

### Usage
```
git clone https://github.com/EdwardPrentice/dev-machine.git
cd dev-machine
vagrant up && vagrant ssh
```

#### What's included by default
By default the tooling will take the official published ubuntu image, tweak some of the configurations to make running it a bit more sensible and pleasant and then using ansible to install a bunch of tools into the vm, including a desktop environment.

### Safe
Dev Machine makes no use of any 'pre baked' artifacts (like a published vagrant box) which would introduce security concerns. The only thing it relies on is the official, published ubuntu base image. The code behind the ansible roles is auditable as they are open source.

### Customisable
Dev Machine is completely customisable, simply modify the tooling as you wish before running `vagrant up`

### TODO
- Figure out how to start the GUI window bigger than a letter box by default
- - This is quite annoying as it will break the installed conky
- Enable wobbly windows with compiz. Demonstrates advanced customisation.
- Configure desktop theme to be a really cool dark theme
- Consider adding some of the kali tools
- Add and configure IntelliJ Community and a couple of other tools like Sublime, jq, etc

### Contributions welcome
Issues are welcome, but PRs are much more welcome! No contribution is too small.

Geography allowing, all PRs earn the author a free 🍺

<br>
<br>
Happy Hacking!
