# Navegação
- [dotfiles](https://github.com/leouchoa/dotfiles#dotfiles)
  - [Porque esta página é útil?](https://github.com/leouchoa/dotfiles#porque-esta-p%C3%A1gina-%C3%A9-%C3%BAtil)
  - [O que são os 'dotfiles'?](https://github.com/leouchoa/dotfiles#o-que-s%C3%A3o-os-dotfiles)
  - [Por quê isso é útil?](https://github.com/leouchoa/dotfiles#por-qu%C3%AA-isso-%C3%A9-%C3%BAtil)
  - [Como configurar os arquivos.](https://github.com/leouchoa/dotfiles#como-configurar-os-arquivos)
  - [Links úteis](https://github.com/leouchoa/dotfiles#links-%C3%BAteis)
- [Tmux](https://github.com/leouchoa/dotfiles#Tmux)
  - [Instalação](https://github.com/leouchoa/dotfiles#instala%C3%A7%C3%A3o)
  - [Como usar](https://github.com/leouchoa/dotfiles#Como-usar)
  - [Comandos](https://github.com/leouchoa/dotfiles#Comandos)
  - [Exemplo pra Cloud](https://github.com/leouchoa/dotfiles#Exemplo-pra-Cloud)

# dotfiles
Personal Dotfiles

Configurações de Dotfiles. O que tem aqui são:

- atalhos (aliases)
- configuração da aparência do terminal
- configuração do vim


**Cuidado** para não copiar a colar tudo pois essas configurações são para a distro *debian*! Se quiser usar somente os atalhos, olhe o arquivo [.aliases](https://github.com/leouchoa/dotfiles/blob/master/.aliases).

## Porque esta página é útil?

Esta página é útil primeiramente pra que eu possa fazer backup. É isso. Entretanto, como eu não tinha muito o que fazer, decidi também facilitar a vida da galera. Sabe.... Ver vídeos e ir atrás dessas coisas é chato e toma um tempo danado. Então preferi deixar mais simples. 


É também útil caso você não saiba inglês (se for este o caso, vai aprender) e ainda sim queira deixar as coisas bonitinhas.


## O que são os 'dotfiles'?

São arquivos. Eles são chamados de 'dotfiles' porque tem um ponto no inicio, que torna eles escondidos na sua pasta. A jogada é que estes arquivos são **certas** configurações de outras coisas (como do Terminal ou de programas como Git).

## Por quê isso é útil?

É útil porque depois de configurados, dá pra poupar um tempo danado. Além disso, usar o terminal fica mais divertido (sei que tem uma galera que não curte).

## Como configurar os arquivos. 

Comentarei aqui como configurar os dotfiles para a shell bash. Relacionados a isto, existem 4 arquivos principais:

- `.bashrc`
- `.bash_profile`
- `.bash_prompt`
- `.aliases`

Basicamente, a forma como as coisas funcionam é assim: o arquivo `.bashrc` aciona o arquivo, que aciona `.bash_profile`, que aciona `.bash_prompt` e `.aliases`. 

Ou seja (`.bashrc`) -> (`.bash_profile`) -> ( `.bash_prompt` + `.aliases`).

A parte do `.bashrc` que desencadeia o próximo é 

```
[ -n "$PS1" ] && source ~/.bash_profile;
```

Então entra o `.bash_profile`. Este arquivo é simplesmente um loop que roda os arquivos `.bash_prompt` e `.aliases` e faz uns testes ai (para saber mais sobre os testes use `man test)`.

O arquivo `.bash_prompt` é o que deixar o terminal bonitinho. A forma que ele vai ficar é +/- [assim](http://i.imgur.com/EkEtphC.png).

Já o arquivo `.aliases` é onde estão armazenados alguns atalhos úteis. O ponto disso é que digitar um baita testão é chato. Imagina só escrever 

```
git log --oneline --graph --decorate --all
```

toda vez. Doi a alma. E isso ta aí pra ajudar, então melhor usar. 

## Links úteis

1. [Aqui](https://www.youtube.com/playlist?list=PL-osiE80TeTvGhHkpvfmKWOiIPF8UVy6c) tem um monte de vídeo legal sobre isso. O vídeo 'Customizing Your Terminal: How To Use and Modify Dotfiles' é especialmente útil.
2. [Esse](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789) aprofunda um pouco. 

# Tmux

[Tmux](https://github.com/tmux/tmux) é um multiplicador de terminais. É o programa que faz a tela do terminal ficar dividida e você poder usar metade da tela para uma coisa e a outra metade para outra. Mas ele é mais que isso e permite, por exemplo, você não se ferrar e perder seus processos quando tiver logado em um seção por ssh.

## Instalação 

No linux basta usar seu gerenciador de arquivos para o instalar. No caso de distros derivadas do debian:
```
sudo apt install -y tmux
```

## Como usar

Na moral [esse vídeo resolve boa parte do que eu uso no dia-a-dia](https://www.youtube.com/watch?v=BHhA_ZKjyxo). Mas segue aqui alguns atalhos para eu passse um tempo usar e não queira voltar no vídeo.

**Importante!!** se seguir a [configuração](https://github.com/leouchoa/dotfiles/blob/master/.tmux.conf) que tem neste repo, o gatilho do tmux é `control-a` pois `control-b` é esquisito.

### Comandos

- `control-a %`: abre nova divisória (painel) à esquerda
- `control-a c`: abre nova janela
- `control-a ,`: renomear janela
- `control-a n`: muda para próxima janela
- `control-a ;`: muda para último janela utilizada
- `control-a w`: lista as janelas abertas
- `control-a ARROW_KEY_HERE`: navegação entre paineis

#### Exemplo pra Cloud

Eu faço modelos e muitas vezes rodo eles na núvem. Só que eles demoram. 

Suponha que você também faz e que seus modelos também demoram pra ficar pronto. Qual a chance de você virar a madrugada olhando pra tela do note? Nenhuma né? Pois é. 

Dá pra resolver isso facilmente ao rodar o comando em background assim:

```
python faz_modelo_demorado.py &
```

ou se você quiser fazer mais chique com [redirecionamento](https://linuxize.com/post/bash-redirect-stderr-stdout/), assim:
```
python faz_modelo_demorado.py > saidas.txt 2>&1
```

Com tmux também dá pra fazer. É meio overkill e tem mais passos, mas é mais flexível. Passo-a-passo é:

1. crie uma nova seção
2. roda o modelo na nova seção
3. sai (detach) da nova seção
4. faz qualquer coisa
5. volta de manhã cedo no outro dia e abre a seção criada ontem.

Em código:

0. loga na máquina `ssh blablabla`
1. nova seção: `tmux new -s nova_secao`
2. roda modelo: `python faz_modelo_demorado.py > saidas.txt 2>&1`
3. sai da nova seção: aperta `control-b d`
4. 🎶🏋️‍♀️🍴🎶
5. Putz esqueci o nome da seção! Use: `tmux list-sessions`
6. `tmux attach -t nova_secao`


# Tools I Usually use

- [zshell](https://gist.github.com/derhuerst/12a1558a4b408b3b2b6e)
- [neovim](https://neovim.io)
- [delta](https://github.com/dandavison/delta)
- [doom emacs](https://github.com/doomemacs/doomemacs)
- [vimium](https://vimium.github.io)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [bat](https://github.com/sharkdp/bat)
- [fzf](https://github.com/junegunn/fzf)
- [tmux](https://github.com/tmux/tmux/wiki)
- [cheat.sh](https://github.com/chubin/cheat.sh)
- [nerdfont](https://www.nerdfonts.com)
- [exa](https://the.exa.website)
- [procs](https://github.com/dalance/procs)
- [z](https://github.com/rupa/z)

# What I might try

- [starship](https://starship.rs)
- Some youtuber window manager
=======
# Tools I Usually use

- [zshell](https://gist.github.com/derhuerst/12a1558a4b408b3b2b6e)
- [neovim](https://neovim.io)
- [delta](https://github.com/dandavison/delta)
- [doom emacs](https://github.com/doomemacs/doomemacs)
- [vimium](https://vimium.github.io)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [bat](https://github.com/sharkdp/bat)
- [fzf](https://github.com/junegunn/fzf)
- [tmux](https://github.com/tmux/tmux/wiki)
- [cheat.sh](https://github.com/chubin/cheat.sh)
- [nerdfont](https://www.nerdfonts.com)
- [exa](https://the.exa.website)
- [procs](https://github.com/dalance/procs)
- [z](https://github.com/rupa/z)
- [lazygit](https://github.com/jesseduffield/lazygit)

# What I might try

- [starship](https://starship.rs)
- Some youtuber window manager


# To-do 

- Remake this README
- Organize things with [gnu stow](https://www.youtube.com/watch?v=90xMTKml9O0)
- configure zsh instead of using oh-my-zsh
