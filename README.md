![bash_unit CI](https://github.com/pforret/shlorem/workflows/bash_unit%20CI/badge.svg)
![Shellcheck CI](https://github.com/pforret/shlorem/workflows/Shellcheck%20CI/badge.svg)
![GH Language](https://img.shields.io/github/languages/top/pforret/shlorem)
![GH stars](https://img.shields.io/github/stars/pforret/shlorem)
![GH tag](https://img.shields.io/github/v/tag/pforret/shlorem)
![GH License](https://img.shields.io/github/license/pforret/shlorem)
[![basher install](https://img.shields.io/badge/basher-install-white?logo=gnu-bash&style=flat)](https://basher.gitparade.com/package/)

# shlorem

Lorem Ipsum generator for the command line

## 🔥 Usage
```
Program: shlorem 1.0.0 by peter@forret.com
Updated: Apr  1 20:25:37 2021
Description: Lorem Ipsum generator for the command line
Usage: shlorem [-h] [-q] [-v] [-f] [-l <log_dir>] [-t <tmp_dir>] [-s <source>] <action> <input?>
Flags, options and parameters:
    -h|--help        : [flag] show usage [default: off]
    -q|--quiet       : [flag] no output [default: off]
    -v|--verbose     : [flag] output more [default: off]
    -f|--force       : [flag] do not ask for confirmation (always yes) [default: off]
    -l|--log_dir <?> : [option] folder for log files   [default: /Users/pforret/log/shlorem]
    -t|--tmp_dir <?> : [option] folder for temp files  [default: .tmp]
    -s|--source <?>  : [option] text source: lorem/latin/german/french/english/swedish/dutch/russian/chinese/random  [default: lorem]
    <action>         : [parameter] action to perform: chars/words/sentences/paragraphs
    <input>          : [parameter] number of text blobs to generate (default: 20) (optional)
                 
### TIPS & EXAMPLES
* use shlorem chars to generate a number of characters
  shlorem chars 100
* use shlorem words to generate a number of words
  shlorem words 20
* use shlorem sentences to generate a number of sentences
  shlorem sentences 5
* use shlorem paragraphs to generate a number of paragraphs
  shlorem paragraphs 3
* use shlorem check to check if this script is ready to execute and what values the options/flags are
  shlorem check
* use shlorem env to generate an example .env file
  shlorem env > .env
* use shlorem update to update to the latest version
  shlorem check
```

## 👻 Examples

```bash
$ shlorem s
# Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.

$ shlorem sentences 5
# Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. 
# Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. 
# Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.

$ shlorem -s fr words 49
# Lorsque, par un décret des puissances suprêmes, Le Poète apparaît en ce monde ennuyé, 
# Sa mère épouvantée et pleine de blasphèmes Crispe ses poings vers Dieu qui la prend en pitié. Ah! 
# Que n' ai je mis bas tout un nœud de vipères, Plutôt que de nourrir cette dérision!

$ shlorem -s latin p 2
# Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, 
# totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
#
# Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, 
# sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

$ shlorem -s se c 150
# Han kom som ett yrväder en aprilafton och hade ett höganäskrus i en svångrem om halsen. 
# Clara och Lotten voro inne med skötekan att hämta honom på Dal

$ shlorem -s nl w 28
# Hoe de menschen ook gewoonlijk over mij spreken,—en ik weet maar al te goed, 
# in welk een kwaden naam de Zotheid zelfs bij de zotsten staat—beweer ik toch,

$ shlorem -s cn c 20
# 人人生而自由， 在尊严和权利上一律平等。

$ shlorem -s rnd w 24
# Angling absorbent gene loom hart blowiest smoochy limey metros mils molly slopes. Piasters cutlets aspects mingling scapulars seating archers nosedived leave mender lofts
```

## 🚀 Installation

with [basher](https://github.com/basherpm/basher)

	$ basher install pforret/shlorem

or with `git`

	$ git clone https://github.com/pforret/shlorem.git
	$ cd shlorem
    $ ./shlorem ...

## 📝 Acknowledgements

* script created with [bashew](https://github.com/pforret/bashew)

&copy; 2021 Peter Forret
