python3.5
python3
jupyter 
jupyter-notebook 
jupyter-notebook --no-browser
jupyter-notebook 
ipython
ipython notebook
spyder 
ipython
spyder 
sudo dd bs=4M if=archlinux-2017.01.01-dual.iso of=/dev/sdb && sync
ipython3
spyder
spyder 
spyder
python3
ipython
spyder
spyder 
echo 0 $(awk '/TYPE/ {print "+", $2}' /proc/`pidof PROCESS`/smaps) | bc
find papers/ -type f -size +1G
jupyter
jupyter-notebook 
ipython3
spyder 
ipython
jupyter-notebook 
spyder
cat fruits.txt | uniq
cat fruits.txt | uniq | wc -l
less shakespeare.txt 
ls
man sed
sed -e 's/\s/\n/g' | less
sed -e 's/\s/\n/g' shakespeare.txt  | less
sed -e 's/\s/\n/g' shakespeare.txt  | sort
sed -e 's/\s/\n/g' shakespeare.txt  | less
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e 's/\n/d' | less
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e 's/\n/d'
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e 'c\d'
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d'
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | less
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | uniq
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | uniq | sort
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | sort | uniq
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | sort | uniq -c
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | uniq -c | sort
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | uniq -c | sort | less
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | sort | uniq -c
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | sort | uniq -c | sort
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | sort | uniq -c | sort -nr
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | sort | uniq -c | sort -nr | less
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | sort | uniq -c | sort -nr | less | head -15
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | sort | uniq -c | sort -nr | head -15
sed -e 's/\s/\n/g' shakespeare.txt  | sed -e '/^$/d' | sort | uniq -c | sort -nr | head -15 > top_15_shakespeare.txt
cat top_15_shakespeare.txt 
dscl .
lid
ps -aef
ps -aef | less
ps -aef | cut -c3-5
ps -aef | less
ps -aef | cut -c1-5
ps -aef | cut -c1-6
ps -aef | cut -c1-4
ps -aef | cut -c2-4
ps -aef | cut -c1-4
ps -aef | cut -c1-4 | uniq -c 
ps -aef | cut -c1-4 | uniq -c | sort -nr
ps -aef | cut -c1-4 | uniq -c | sort -nr | head -10
ps -aef | cut -c1-4 | sort
ps -aef | cut -c1-4 | sort | uniq -c
ps -aef | cut -c1-4 | sort | uniq -c | sort -nr
gnuplot
jupyter-notebook 
spyder
jupyter-notebook 
htop
apt search xpdf
sudo apt-get install xpdf
curl https://s3-us-west-2.amazonaws.com/brave-apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://s3-us-west-2.amazonaws.com/brave-apt `lsb_release -sc` main" | sudo tee -a /etc/apt/sources.list.d/brave-`lsb_release -sc`.list
sudo apt update
sudo apt install brave
brave
echo 'kernel.unprivileged_userns_clone=1' > /etc/sysctl.d/00-local-userns.conf
sudo echo 'kernel.unprivileged_userns_clone=1' > /etc/sysctl.d/00-local-userns.conf
su
service procps restart
systemctl restart
systemctl reboot
history
spyder 
wget -nv -O Release.key   https://build.opensuse.org/projects/home:manuelschneid3r/public_key
apt-key add - < Release.key
ln -s /usr/share/applications/albert.desktop ~/.config/autostart/
alias gl='git log --oneline --graph --decorate --all'
ls
gl
ls
cat .bashrc
nano .bashrc
cat /usr/share/doc/bash-doc/examples
ls /usr/share/doc/examples
ls /usr/share/doc/bash-doc
ls /usr/share/doc/ | grep 'bash'
ls /usr/share/doc/bash
head .bash_history 
tail .bash_history 
ls
gl
man alias
alias --help
alias
alias -p
fish
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat .ssh/id_rsa.pub 
clear
cat .ssh/id_rsa.pub 
source ~/.bashrc
ls
history | grep ping
pwd
ls
cat gee_teste.R | less
ls relatorio
head *.docx
ls
ls relatorio
head relatorio/relatorio-thuany.docx 
pwd | xc
ls
ls ../
mv relatorio.Rmd ../
ls
ls ../
pwd
pwd | xc
clear
ls
ls relatorio
ls
ls relatorio
ls
nano ../../z1-organize.txt 
cd
cd Documents/git/810---Helenice/thuany/
ls
git log --oneline 
git log --graph 
git log --decorate
git stash apply stash@{0}
chsh -s /bin/bash
history 
history | grep ping
ping www.google.com.br 
history 
clear
ls
git status
git stash list
ping www.google.com.br 
clear
ls
cd thuany/
ls
ls relatorio/
cd relatorio/
ls
cp relatorio.Rmd /home/leouchoa/Documents/papers/2017-2/810/Thuany/prototype_dir/810-Cliente-Thuany
ls
cd ../
ls
git clean --help
git rm --help
ls
cd ../
ls
git rm -r thuany/
ls
mkdir thuany
cp --help
cp -r /home/leouchoa/Documents/papers/2017-2/810/Thuany/prototype_dir/810-Cliente-Thuany .
ls
ls 810-Cliente-Thuany/
mv -r 810-Cliente-Thuany/ thuany/
mv 810-Cliente-Thuany/ thuany/
ls
ls thuany/
ls
ls thuany/
cd thuany/
ls relatorio
ls
mv relatorio.Rmd relatorio_deprecated_version.Rmd 
ls
cd ../
ls
git status 
git add -A
ls
git status 
git commit --help
git commit 
git status 
git push origin master 
git status 
git log -p
git log
git log --help
git log
gl
cd
cat .bashrc | grep alias
ls
ssh-add -K ~/.ssh/id_rsa
ssh-add -k ~/.ssh/id_rsa
cat *.md
cat *.md | less
ls
cd documents/
ls
cd git
ls
git clone git@github.com:leouchoa/caioau-personal.git
ls
cd caioau-personal/installfestlivrecamp1s2018/
ls
nano dualbootv0.md 
xdg-open dualbootv0.md 
ls
cat dualbootv0.md 
ls -aux
ls -l
git push origin master 
ls
git status
rm .Rhistory 
ls
git status 
git pull origin master 
git commit
git add -A
git status 
git commit
git status
git log
git diff sudo dd if=imagem.iso of=/dev/sdb bs=4M status=progress && sync
git diff 094b919a
git diff 094b919a^ 094b919a
git difftool 094b919a^ 094b919a
git log
git diff --stat --cached
git diff --stat --cached origin/master 
git diff master 
git diff origin/master 
clear
git cherry -v
git cherry 
git status 
git push origin master 
git status 
gl
ls
ls -a
cat .bash_prompt 
ls
ls -l
ls -l | grep .bash
ls -l | grep bash
ls -la | grep .bash
nano .bashrc
atom .bashrc
ls
ls -a
ls -a | grep bash
nano .bash_prompt 
ls
wget https://raw.githubusercontent.com/CoreyMSchafer/dotfiles/master/.aliases
ls
la -a
ls -a
ls -a | grep bash
ls
ls -a | grep .*
clear
ls -a | grep ^.
ls
head .bashrc
nano .bashrc
ls -a 
ls -la 
ls -la | grep ^.
ls -la | grep .*
ls -la | grep bash
head .bash_prompt 
head .bash_logout 
ls
ls Desktop/
ls Desktop/see.txt 
cat Desktop/see.txt 
ping www.google.com.br 
ls
ls -a | grep .bash
cat .bashrc 
cat .bash_profile 
nano .aliases 
ls
ls -a | grep .bash
cat .bash_history 
ls dotfiles/ -a | grep .bash
 less dotfiles/.bash_logout 
mv dotfiles/.bash_logout ~
mv dotfiles/.bash_history ~/
less .bash_history 
ls
fish
youtube-dl -x --audio-format mp3 ''
cd music/
youtube-dl -x --audio-format mp3 'https://www.youtube.com/watch?v=Mqkh8YlRUf4'
cd
ls dotfiles/ -a | grep .bash
less dotfiles/.bashrc
less dotfiles/.bashrc
cp .bashrc Documents/
cat .bashrc 
mv dotfiles/.bashrc ~
nano .bashrc 
nano dotfiles/.bashrc
less .bashrc 
cat .bashrc 
cat .bash_profile 
gl
alias 
less .bashrc 
