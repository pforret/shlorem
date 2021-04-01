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
```bash
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
