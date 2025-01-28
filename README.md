# jsfetch
A simple fetch program written in Node.js, in case we needed another one...

# install
<p><b>
For most distros (Debian, openSUSE, Arch, Void, Fedora, and derivatives)

```
$ git clone https://github.com/tfeshelman/jsfetch.git
$ cd jsfetch
$ ./install.sh
```
</b>

The script will ask for the sudo password. It installs nodejs (along with npm)
and uses the older pkg (now maintained under the excellent <a href="https://github.com/yao-pkg/pkg">@yao-pkg</a>) 
to build the actual application. While it removes this afterward,
nodejs is left behind, but is not required once the build is 
finished.  
</p>

<p><b>
For Slackware (you beautiful nerds!)</b><br>
More or less the same as the others, just be sure you
elevate to root (SlackBuilds explicitly state the use of the -l parameter
to invoke a true login shell - keeps proper items in PATH. More info 
<a href="https://slackbuilds.org/howto/"> here</a>).<br><br>

<b>

```
$ su -l
$ git clone https://github.com/tfeshelman/jsfetch.git
$ cd jsfetch
$ ./install.sh
```
</b></p>

# why
Because...<br><br>

I started it as a way to learn javascript and nodejs, however the scope 
evolved to include learning and using the major package managers found
in linux distros that I wasn't familiar with.<br><br>

Seriously, you slackware users are a crazy bunch. I have nothing but love
for all y'all, but my poor laptop took FOREVER to build nodejs.
