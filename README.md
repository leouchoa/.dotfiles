# dotfiles
Personal Dotfiles

Configurações de Dotfiles. No momento, ainda há muito que fazer. 

# Porque esta página é útil?

Esta página é útil primeiramente pra que eu possa fazer backup. É isso. Entretanto, como eu não tinha muito o que fazer, decidi também facilitar a vida da galera. Sabe.... Ver vídeos e ir atrás dessas coisas é chato e toma um tempo danado. Então preferi deixar mais simples. 


É também útil caso você não saiba inglês (se for este o caso, vai aprender) e ainda sim queira deixar as coisas bonitinhas.


# O que são os 'dotfiles'?

São arquivos. Eles são chamados de 'dotfiles' porque tem um ponto no inicio, que torna eles escondidos na sua pasta. A jogada é que estes arquivos são **certas** configurações de outras coisas (como do Terminal ou de programas como Git).

# Por quê isso é útil?

É útil porque depois de configurados, dá pra poupar um tempo danado. Além disso, usar o terminal fica mais divertido (sei que tem uma galera que não curte).

# Como configurar os arquivos. 

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

# Links úteis

1. [Aqui](https://www.youtube.com/playlist?list=PL-osiE80TeTvGhHkpvfmKWOiIPF8UVy6c) tem um monte de vídeo legal sobre isso. O vídeo 'Customizing Your Terminal: How To Use and Modify Dotfiles' é especialmente útil.
2. [Esse](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789) aprofunda um pouco. 
