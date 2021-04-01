#!/usr/bin/env bash
### Created by Peter Forret ( pforret ) on 2021-04-01
### Based on https://github.com/pforret/bashew 1.15.1
script_version="0.0.1" # if there is a VERSION.md in this script's folder, it will take priority for version number
readonly script_author="peter@forret.com"
readonly script_created="2021-04-01"
readonly run_as_root=-1 # run_as_root: 0 = don't check anything / 1 = script MUST run as root / -1 = script MAY NOT run as root

list_options() {
  echo -n "
#commented lines will be filtered
flag|h|help|show usage
flag|q|quiet|no output
flag|v|verbose|output more
flag|f|force|do not ask for confirmation (always yes)
option|l|log_dir|folder for log files |$HOME/log/$script_prefix
option|t|tmp_dir|folder for temp files|.tmp
option|s|source|text source: lorem/latin/german/french/english/swedish|lorem
param|1|action|action to perform: chars/words/sentences/paragraphs
param|?|input|number of text blobs to generate (default: 20)
" | grep -v '^#' | grep -v '^\s*$'
}

#####################################################################
## Put your main script here
#####################################################################

main() {
  log_to_file "[$script_basename] $script_version started"

  action=$(lower_case "$action")
  case $action in
  characters|chars|c)
    #TIP: use «$script_prefix words» to generate a number of words
    #TIP:> $script_prefix words 100
    # shellcheck disable=SC2154
    show_chars "$input"
    ;;

  words|w)
    #TIP: use «$script_prefix words» to generate a number of words
    #TIP:> $script_prefix words 100
    # shellcheck disable=SC2154
    show_words "$input"
    ;;

  sentences|s)
    #TIP: use «$script_prefix words» to generate a number of words
    #TIP:> $script_prefix words 100
    # shellcheck disable=SC2154
    show_sentences "$input"
    ;;

  paragraphs|p)
    #TIP: use «$script_prefix words» to generate a number of words
    #TIP:> $script_prefix words 100
    # shellcheck disable=SC2154
    show_paragrapes "$input"
    ;;

  check|env)
    ## leave this default action, it will make it easier to test your script
    #TIP: use «$script_prefix check» to check if this script is ready to execute and what values the options/flags are
    #TIP:> $script_prefix check
    #TIP: use «$script_prefix env» to generate an example .env file
    #TIP:> $script_prefix env > .env
    check_script_settings
    ;;

  update)
    ## leave this default action, it will make it easier to test your script
    #TIP: use «$script_prefix update» to update to the latest version
    #TIP:> $script_prefix check
    update_script_to_latest
    ;;

  *)
    die "action [$action] not recognized"
    ;;
  esac
  log_to_file "[$script_basename] ended after $SECONDS secs"
  #TIP: >>> bash script created with «pforret/bashew»
  #TIP: >>> for bash development, also check out «pforret/setver» and «pforret/progressbar»
}

#####################################################################
## Put your helper scripts here
#####################################################################

show_chars() {
  local nb_chars=${input:-100}
  debug "generate $nb_chars chars"
  # shellcheck disable=SC2154
  load_source "$source" |
  cut -c1-"$nb_chars"
}

show_words() {
  local nb_words=${input:-20}
  debug "generate $nb_words words"
  # shellcheck disable=SC2154
  load_source "$source" |
  tr ' ' "\n" |
  head -"$nb_words" |
  tr "\n" " "
  echo ""
}

show_sentences() {
  local nb_lines=${input:-3}
  debug "generate $nb_lines sentences"
  # shellcheck disable=SC2154
  load_source "$source" |
  tr '.' "\n" |
  head -"$nb_lines" |
  tr "\n" "."
  echo ""
}

show_paragraphs() {
  local nb_lines=${input:-3}
  debug "generate $nb_lines paragraphs"
  # shellcheck disable=SC2154
  load_source "$source" |
  tr '.' "\n" |
  head -"$nb_lines" |
  tr "\n" "."
  echo ""
}


load_source(){
  case ${1:-lorem} in
  latin|cicero)   echo "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
    ;;
  it|italian|decamerone) echo "Ser Cepperello con una falsa confessione inganna uno santo frate, e muorsi; ed essendo stato un pessimo uomo in vita, è morto reputato per santo e chiamato san Ciappelletto. Convenevole cosa è, carissime donne, che ciascheduna cosa la quale l’uomo fa, dallo ammirabile e santo nome di Colui il quale di tutte fu facitore le dea principio. Per che, dovendo io al nostro novellare, sì come primo, dare cominciamento, intendo da una delle sue maravigliose cose incominciare, acciò che, quella udita, la nostra speranza in lui, sì come in cosa impermutabile, si fermi e sempre sia da noi il suo nome lodato.  Manifesta cosa è che, sì come le cose temporali tutte sono transitorie e mortali, così in sé e fuor di sé essere piene di noia e d’angoscia e di fatica e ad infiniti pericoli soggiacere; alle quali senza niuno fallo né potremmo noi, che viviamo mescolati in esse e che siamo parte d’esse, durare né ripararci, se spezial grazia di Dio forza e avvedimento non ci prestasse. La quale a noi e in noi non è da credere che per alcuno nostro merito discenda, ma dalla sua propia benignità mossa e da prieghi di coloro impetrata che, sì come noi siamo, furon mortali, e bene i suoi piaceri mentre furono in vita seguendo, ora con lui etterni sono divenuti e beati; alli quali noi medesimi, sì come a procuratori informati per esperienza della nostra fragilità, forse non audaci di porgere i prieghi nostri nel cospetto di tanto giudice, delle cose le quali a noi reputiamo opportune gli porgiamo."
    ;;
  de|goethe|german) echo "Ihr naht euch wieder, schwankende Gestalten! Die früh sich einst dem trüben Blick gezeigt. Versuch’ ich wohl euch diesmal fest zu halten? Fühl’ ich mein Herz noch jenem Wahn geneigt? Ihr drängt euch zu! nun gut, so mögt ihr walten. Wie ihr aus Dunst und Nebel um mich steigt. Mein Busen fühlt sich jugendlich erschüttert. Vom Zauberhauch der euren Zug umwittert. Ihr bringt mit euch die Bilder froher Tage. Und manche liebe Schatten steigen auf Gleich einer alten, halbverklungnen Sage. Kommt erste Lieb’ und Freundschaft mit herauf Der Schmerz wird neu, es wiederholt die Klage. Des Lebens labyrinthisch irren Lauf, Und nennt die Guten, die, um schöne Stunden Vom Glück getäuscht, vor mir hinweggeschwunden."
  ;;
  fr|baudelaire|french) echo "Lorsque, par un décret des puissances suprêmes, Le Poète apparaît en ce monde ennuyé, Sa mère épouvantée et pleine de blasphèmes Crispe ses poings vers Dieu qui la prend en pitié. Ah! Que n' ai je mis bas tout un nœud de vipères, Plutôt que de nourrir cette dérision! Maudite soit la nuit aux plaisirs éphémères Où mon ventre a conçu mon expiation! Puisque tu m’as choisie entre toutes les femmes Pour être le dégoût de mon triste mari. Et que je ne puis pas rejeter dans les flammes, Comme un billet d’amour, ce monstre rabougri. Je ferai rejaillir ta haine qui m’accable Sur l’instrument maudit de tes méchancetés, Et je tordrai si bien cet arbre misérable Qu’il ne pourra pousser ses boutons empestés!"
  ;;
  se|strindberg|swedish) echo "Han kom som ett yrväder en aprilafton och hade ett höganäskrus i en svångrem om halsen. Clara och Lotten voro inne med skötekan att hämta honom på Dalarö brygga; men det dröjde evigheter, innan de kommo i båt. De skulle till handelsman och ha en tunna tjära och på abeteket och hämta gråsalva åt grisen, och så skulle de på posten och få ett frimärke, och så skulle de ner till Fia Lövström i Kroken och låna tuppen mot ett halvpund småtärna till notbygget, och sist hade de hamnat på gästgivaregården, där Carlsson bjudit på kaffe med dopp. Och så kommo de äntligen i båt, men Carlsson ville styra, och det kunde han inte, för han hade aldrig sett en råseglare förr, och därför skrek han, att de skulle hissa focken, som inte fanns. Och på tullbryggan stodo lotsar och vaktmästare och grinade åt manövern, när ekan gick över stag och länsade ner åt Saltsäcken. Hörru, du har hål i båten! skrek en lotslärling genom vinden; Stopp till! stopp till! och medan Carlsson tittade efter hålen, hade Clara knuffat undan honom och tagit roret, och med årorna lyckades Lotten få ekan opp i vinden igen, så att nu strök det ner åt Aspösund med god gång. Carlsson var en liten fyrkantig värmländing med blå ögon och näsa krokig som en syskonhake. Livlig, lekfull och nyfiken var han, men sjöaffärerna förstod han inte alls, och han var också kallad ut till Hemsö för att ta hand om åker och kreatur, som ingen annan ville ta befattning med, sedan gubben Flod gått ur livet och änkan satt ensam vid gården. Men när Carlsson nu ville börja pumpa flickorna om ställningar och förhållanden, så fick han riktiga skärkarlssvar. Ja si, det vet jag inte! Ja si, det kan jag inte säga! Ja si, det vet jag rakt inte."
  ;;

  en|poe|english) echo "Once upon a midnight dreary, while I pondered, weak and weary. Over many a quaint and curious volume of forgotten lore.  While I nodded, nearly napping, suddenly there came a tapping.  As of some one gently rapping, rapping at my chamber door.  'Tis some visiter, I muttered, tapping at my chamber door.  Only this, and nothing more. Ah, distinctly I remember it was in the bleak December. And each separate dying ember wrought its ghost upon the floor.  Eagerly I wished the morrow;—vainly I had sought to borrow. From my books surcease of sorrow—sorrow for the lost Lenore. For the rare and radiant maiden whom the angels name Lenore. Nameless here for evermore.  And the silken sad uncertain rustling of each purple curtain Thrilled me, filled me with fantastic terrors never felt before; So that now, to still the beating of my heart, I stood repeating Tis some visiter entreating entrance at my chamber door.  Some late visiter entreating entrance at my chamber door.  This it is, and nothing more.  Presently my soul grew stronger; hesitating then no longer.  Sir, said I, or Madam, truly your forgiveness I implore.  But the fact is I was napping, and so gently you came rapping, And so faintly you came tapping, tapping at my chamber door.  That I scarce was sure I heard you, here I opened wide the door.  Darkness there, and nothing more.  Deep into that darkness peering, long I stood there wondering, fearing.  Doubting, dreaming dreams no mortal ever dared to dream before; But the silence was unbroken, and the darkness gave no token.  And the only word there spoken was the whispered word, Lenore!  This I whispered, and an echo murmured back the word, Lenore!  Merely this, and nothing more."
  ;;

  nl|dutch|erasmus) echo "Hoe de menschen ook gewoonlijk over mij spreken,—en ik weet maar al te goed, in welk een kwaden naam de Zotheid zelfs bij de zotsten staat—beweer ik toch, dat ik en ik alleen door mijn goddelijke macht Goden en menschen vervroolijk. Hiervan is dit zeker een meer dan voldoend bewijs, dat, zoodra ik voor deze zoo talrijke vergadering was opgetreden om het woord te voeren, eensklaps uw aller aangezichten zoo blonken van een ongekende en ongewone vreugde, dat gij zoo plotseling het voorhoofd ontrimpelde en mij met zulk een blijden en beminnelijken lach toejuichte, dat gij allen, die ik hier uit alle hoeken der wereld voor mij zie, waarlijk niemand uitgezonderd, gelijk de Goden bij Homerus, te veel nectar met nepenthes schijnt gebruikt te hebben, terwijl ge vroeger [16]zoo bedroefd en bekommerd waart neergezeten, alsof ge nog pas uit Trophonius’ hol waart teruggekomen. Maar ’t gaat hiermede als wanneer de zon het eerst haar schoon en gulden gelaat aan ’t aardrijk vertoont of na een strengen winter de lente opnieuw den zoelen adem der westenwinden brengt: dan verandert aanstonds het voorkomen van alles, dan krijgt alles een nieuwe kleur en een geheel nieuwe jeugd en zoo veranderde ook dadelijk op mijn aanblik uw voorkomen."
  ;;

  ru|russian) echo "Все люди рождаются свободными и равными в своем достоинстве и правах. Они наделены разумом и совестью и должны поступать в отношении друг друга в духе братства. Каждый человек должен обладать всеми правами и всеми свободами, провозглашенными настоящей Декларацией, без какого бы то ни было различия, как-то в отношении расы, цвета кожи, пола, языка, религии, политических или иных убеждений, национального или социального происхождения, имущественного, сословного или иного положения. Кроме того, не должно проводиться никакого различия на основе политического, правового или международного статуса страны или территории, к которой человек принадлежит, независимо от того, является ли эта территория независимой, подопечной, несамоуправляющейся или как-либо иначе ограниченной в своем суверенитете. Каждый человек имеет право на жизнь, на свободу и на личную неприкосновенность. Никто не должен содержаться в рабстве или в подневольном состоянии; рабство и работорговля запрещаются во всех их видах. Никто не должен подвергаться пыткам или жестоким, бесчеловечным или унижающим его достоинство обращению и наказанию. Каждый человек, где бы он ни находился, имеет право на признание его правосубъектности."
  ;;

  cn|chinese) echo "人人生而自由， 在尊严和权利上一律平等。 他们赋有理性和良心， 并应以兄弟关系的精神相对待。  人人有资格享有本宣言所载的一切权利和自由， 不分种族、 肤色、 性别、 语言、 宗教、 政治或其他见解、 国籍或社会出身、 财产、 出生或其他身分等任何区别。 并且不得因一人所属的国家或领土的政治的、 行政的或者国际的地位之不同而有所区别， 无论该领土是独立领土、 托管领土、 非自治领土或者处于其他任何主权受限制的情况之下。 人人有权享有生命、自由和人身安全。 任何人不得使为奴隶或奴役； 一切形式的奴隶制度和奴隶买卖， 均应予以禁止。 任何人不得加以酷刑，或施以残忍的、不人道的或侮辱性的待遇或刑罚。 人人在任何地方有权被承认在法律前的人格。 法律之前人人平等，并有权享受法律的平等保护，不受任何歧视。人人有权享受平等保护，以免受违反本宣言的任何歧视行为以及煽动这种歧视的任何行为之害。 任何人当宪法或法律所赋予他的基本权利遭受侵害时，有权由合格的国家法庭对这种侵害行为作有效的补救。 任何人不得加以任意逮捕、拘禁或放逐。 人人完全平等地有权由一个独立而无偏倚的法庭进行公正的和公开的审讯，以确定他的权利和义务并判定对他提出的任何刑事指控。 ㈠ 凡受刑事控告者，在未经获得辩护上所需的一切保证的公开审判而依法证实有罪以前，有权被视为无罪。 ㈡ 任何人的任何行为或不行为， 在其发生时依国家法或国际法均不构成刑事罪者， 不得被判为犯有刑事罪。 刑罚不得重于犯罪时适用的法律规定。"
  ;;

  rnd|random) base64 /dev/urandom | tr '/+' '\n\n' | awk '/^.+$/{gsub(/[0-9]/,"_"); print}' | head -500 | tr '\n' '. ' | awk '{ gsub(/(_+)/," "); print }'
  ;;

  # regular lorem ipsum in latin
  *)    echo "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui."
  esac
}
#####################################################################
################### DO NOT MODIFY BELOW THIS LINE ###################
#####################################################################

# set strict mode -  via http://redsymbol.net/articles/unofficial-bash-strict-mode/
# removed -e because it made basic [[ testing ]] difficult
set -uo pipefail
IFS=$'\n\t'
# shellcheck disable=SC2120
hash() {
  length=${1:-6}
  # shellcheck disable=SC2230
  if [[ -n $(which md5sum) ]]; then
    # regular linux
    md5sum | cut -c1-"$length"
  else
    # macos
    md5 | cut -c1-"$length"
  fi
}

force=0
help=0
verbose=0
#to enable verbose even before option parsing
[[ $# -gt 0 ]] && [[ $1 == "-v" ]] && verbose=1
quiet=0
#to enable quiet even before option parsing
[[ $# -gt 0 ]] && [[ $1 == "-q" ]] && quiet=1

### stdout/stderr output
initialise_output() {
  [[ "${BASH_SOURCE[0]:-}" != "${0}" ]] && sourced=1 || sourced=0
  [[ -t 1 ]] && piped=0 || piped=1 # detect if output is piped
  if [[ $piped -eq 0 ]]; then
    col_reset="\033[0m"
    col_red="\033[1;31m"
    col_grn="\033[1;32m"
    col_ylw="\033[1;33m"
  else
    col_reset=""
    col_red=""
    col_grn=""
    col_ylw=""
  fi

  [[ $(echo -e '\xe2\x82\xac') == '€' ]] && unicode=1 || unicode=0 # detect if unicode is supported
  if [[ $unicode -gt 0 ]]; then
    char_succ="✔"
    char_fail="✖"
    char_alrt="➨"
    char_wait="…"
    info_icon="✦"
    config_icon="⌘"
    clean_icon="♺"
    require_icon="⎆"
  else
    char_succ="OK "
    char_fail="!! "
    char_alrt="?? "
    char_wait="..."
    info_icon="(i)"
    config_icon="[c]"
    clean_icon="[c]"
    require_icon="[r]"
  fi
  error_prefix="${col_red}>${col_reset}"
}

out() {     ((quiet)) && true || printf '%b\n' "$*"; }
debug() {   if ((verbose)); then out "${col_ylw}# $* ${col_reset}" >&2; else true; fi; }
die() {     out "${col_red}${char_fail} $script_basename${col_reset}: $*" >&2 ;   tput bel; safe_exit ; }
alert() {   out "${col_red}${char_alrt}${col_reset}: $*" >&2 ; }
success() { out "${col_grn}${char_succ}${col_reset}  $*"; }
announce() { out "${col_grn}${char_wait}${col_reset}  $*"; sleep 1 ; }
progress() {
  ((quiet)) || (
    local screen_width
    screen_width=$(tput cols 2>/dev/null || echo 80)
    local rest_of_line
    rest_of_line=$((screen_width - 5))

    if flag_set ${piped:-0}; then
      out "$*" >&2
    else
      printf "... %-${rest_of_line}b\r" "$*                                             " >&2
    fi
  )
}

log_to_file() { [[ -n ${log_file:-} ]] && echo "$(date '+%H:%M:%S') | $*" >>"$log_file"; }

### string processing
lower_case() { echo "$*" | tr '[:upper:]' '[:lower:]'; }
upper_case() { echo "$*" | tr '[:lower:]' '[:upper:]'; }

slugify() {
    # slugify <input> <separator>
    # slugify "Jack, Jill & Clémence LTD"      => jack-jill-clemence-ltd
    # slugify "Jack, Jill & Clémence LTD" "_"  => jack_jill_clemence_ltd
    separator="${2:-}"
    [[ -z "$separator" ]] && separator="-"
    # shellcheck disable=SC2020
    echo "$1" |
        tr '[:upper:]' '[:lower:]' |
        tr 'àáâäæãåāçćčèéêëēėęîïííīįìłñńôöòóœøōõßśšûüùúūÿžźż' 'aaaaaaaaccceeeeeeeiiiiiiilnnoooooooosssuuuuuyzzz' |
        awk '{
          gsub(/[\[\]@#$%^&*;,.:()<>!?\/+=_]/," ",$0);
          gsub(/^  */,"",$0);
          gsub(/  *$/,"",$0);
          gsub(/  */,"-",$0);
          gsub(/[^a-z0-9\-]/,"");
          print;
          }' |
        sed "s/-/$separator/g"
}

title_case() {
    # title_case <input> <separator>
    # title_case "Jack, Jill & Clémence LTD"     => JackJillClemenceLtd
    # title_case "Jack, Jill & Clémence LTD" "_" => Jack_Jill_Clemence_Ltd
    separator="${2:-}"
    # shellcheck disable=SC2020
    echo "$1" |
        tr '[:upper:]' '[:lower:]' |
        tr 'àáâäæãåāçćčèéêëēėęîïííīįìłñńôöòóœøōõßśšûüùúūÿžźż' 'aaaaaaaaccceeeeeeeiiiiiiilnnoooooooosssuuuuuyzzz' |
        awk '{ gsub(/[\[\]@#$%^&*;,.:()<>!?\/+=_-]/," ",$0); print $0; }' |
        awk '{
          for (i=1; i<=NF; ++i) {
              $i = toupper(substr($i,1,1)) tolower(substr($i,2))
          };
          print $0;
          }' |
        sed "s/ /$separator/g" |
        cut -c1-50
}

### interactive
confirm() {
  # $1 = question
  flag_set $force && return 0
  read -r -p "$1 [y/N] " -n 1
  echo " "
  [[ $REPLY =~ ^[Yy]$ ]]
}

ask() {
  # $1 = variable name
  # $2 = question
  # $3 = default value
  # not using read -i because that doesn't work on MacOS
  local ANSWER
  read -r -p "$2 ($3) > " ANSWER
  if [[ -z "$ANSWER" ]]; then
    eval "$1=\"$3\""
  else
    eval "$1=\"$ANSWER\""
  fi
}

trap "die \"ERROR \$? after \$SECONDS seconds \n\
\${error_prefix} last command : '\$BASH_COMMAND' \" \
\$(< \$script_install_path awk -v lineno=\$LINENO \
'NR == lineno {print \"\${error_prefix} from line \" lineno \" : \" \$0}')" INT TERM EXIT
# cf https://askubuntu.com/questions/513932/what-is-the-bash-command-variable-good-for

safe_exit() {
  [[ -n "${tmp_file:-}" ]] && [[ -f "$tmp_file" ]] && rm "$tmp_file"
  trap - INT TERM EXIT
  debug "$script_basename finished after $SECONDS seconds"
  exit 0
}

flag_set() { [[ "$1" -gt 0 ]]; }

show_usage() {
  out "Program: ${col_grn}$script_basename $script_version${col_reset} by ${col_ylw}$script_author${col_reset}"
  out "Updated: ${col_grn}$script_modified${col_reset}"
  out "Description: Lorem Ipsum generator for the command line"
  echo -n "Usage: $script_basename"
  list_options |
    awk '
  BEGIN { FS="|"; OFS=" "; oneline="" ; fulltext="Flags, options and parameters:"}
  $1 ~ /flag/  {
    fulltext = fulltext sprintf("\n    -%1s|--%-12s: [flag] %s [default: off]",$2,$3,$4) ;
    oneline  = oneline " [-" $2 "]"
    }
  $1 ~ /option/  {
    fulltext = fulltext sprintf("\n    -%1s|--%-12s: [option] %s",$2,$3 " <?>",$4) ;
    if($5!=""){fulltext = fulltext "  [default: " $5 "]"; }
    oneline  = oneline " [-" $2 " <" $3 ">]"
    }
  $1 ~ /list/  {
    fulltext = fulltext sprintf("\n    -%1s|--%-12s: [list] %s (array)",$2,$3 " <?>",$4) ;
    fulltext = fulltext "  [default empty]";
    oneline  = oneline " [-" $2 " <" $3 ">]"
    }
  $1 ~ /secret/  {
    fulltext = fulltext sprintf("\n    -%1s|--%s <%s>: [secret] %s",$2,$3,"?",$4) ;
      oneline  = oneline " [-" $2 " <" $3 ">]"
    }
  $1 ~ /param/ {
    if($2 == "1"){
          fulltext = fulltext sprintf("\n    %-17s: [parameter] %s","<"$3">",$4);
          oneline  = oneline " <" $3 ">"
     }
     if($2 == "?"){
          fulltext = fulltext sprintf("\n    %-17s: [parameter] %s (optional)","<"$3">",$4);
          oneline  = oneline " <" $3 "?>"
     }
     if($2 == "n"){
          fulltext = fulltext sprintf("\n    %-17s: [parameters] %s (1 or more)","<"$3">",$4);
          oneline  = oneline " <" $3 " …>"
     }
    }
    END {print oneline; print fulltext}
  '
}

check_last_version(){
  (
  # shellcheck disable=SC2164
  pushd "$script_install_folder" &> /dev/null
  if [[ -d .git ]] ; then
    local remote
    remote="$(git remote -v | grep fetch | awk 'NR == 1 {print $2}')"
    progress "Check for latest version - $remote"
    git remote update &> /dev/null
    if [[ $(git rev-list --count "HEAD...HEAD@{upstream}" 2>/dev/null) -gt 0 ]] ; then
      out "There is a more recent update of this script - run <<$script_prefix update>> to update"
    fi
  fi
  # shellcheck disable=SC2164
  popd &> /dev/null
  )
}

update_script_to_latest(){
  # run in background to avoid problems with modifying a running interpreted script
  (
  sleep 1
  cd "$script_install_folder" && git pull
  ) &
}

show_tips() {
  ((sourced)) && return 0
  # shellcheck disable=SC2016
  grep <"${BASH_SOURCE[0]}" -v '$0' \
  | awk \
      -v green="$col_grn" \
      -v yellow="$col_ylw" \
      -v reset="$col_reset" \
      '
      /TIP: /  {$1=""; gsub(/«/,green); gsub(/»/,reset); print "*" $0}
      /TIP:> / {$1=""; print " " yellow $0 reset}
      ' \
  | awk \
      -v script_basename="$script_basename" \
      -v script_prefix="$script_prefix" \
      '{
      gsub(/\$script_basename/,script_basename);
      gsub(/\$script_prefix/,script_prefix);
      print ;
      }'
}

check_script_settings() {
  if [[ -n $(filter_option_type flag) ]]; then
    out "## ${col_grn}boolean flags${col_reset}:"
    filter_option_type flag |
      while read -r name; do
        if ((piped)); then
          eval "echo \"$name=\$${name:-}\""
        else
          eval "echo -n \"$name=\$${name:-}  \""
        fi
      done
    out " "
    out " "
  fi

  if [[ -n $(filter_option_type option) ]]; then
    out "## ${col_grn}option defaults${col_reset}:"
    filter_option_type option |
      while read -r name; do
        if ((piped)); then
          eval "echo \"$name=\$${name:-}\""
        else
          eval "echo -n \"$name=\$${name:-}  \""
        fi
      done
    out " "
    out " "
  fi

  if [[ -n $(filter_option_type list) ]]; then
    out "## ${col_grn}list options${col_reset}:"
    filter_option_type list |
      while read -r name; do
        if ((piped)); then
          eval "echo \"$name=(\${${name}[@]})\""
        else
          eval "echo -n \"$name=(\${${name}[@]})  \""
        fi
      done
    out " "
    out " "
  fi

  if [[ -n $(filter_option_type param) ]]; then
    if ((piped)); then
      debug "Skip parameters for .env files"
    else
      out "## ${col_grn}parameters${col_reset}:"
      filter_option_type param |
        while read -r name; do
          # shellcheck disable=SC2015
          ((piped)) && eval "echo \"$name=\\\"\${$name:-}\\\"\"" || eval "echo -n \"$name=\\\"\${$name:-}\\\"  \""
        done
      echo " "
    fi
  fi
}

filter_option_type() {
  list_options | grep "$1|" | cut -d'|' -f3 | sort | grep -v '^\s*$'
}

init_options() {
  local init_command
  init_command=$(list_options |
    grep -v "verbose|" |
    awk '
    BEGIN { FS="|"; OFS=" ";}
    $1 ~ /flag/   && $5 == "" {print $3 "=0; "}
    $1 ~ /flag/   && $5 != "" {print $3 "=\"" $5 "\"; "}
    $1 ~ /option/ && $5 == "" {print $3 "=\"\"; "}
    $1 ~ /option/ && $5 != "" {print $3 "=\"" $5 "\"; "}
    $1 ~ /list/ {print $3 "=(); "}
    $1 ~ /secret/ {print $3 "=\"\"; "}
    ')
  if [[ -n "$init_command" ]]; then
    eval "$init_command"
  fi
}

expects_single_params() { list_options | grep 'param|1|' >/dev/null; }
expects_optional_params() { list_options | grep 'param|?|' >/dev/null; }
expects_multi_param() { list_options | grep 'param|n|' >/dev/null; }

parse_options() {
  if [[ $# -eq 0 ]]; then
    show_usage >&2
    safe_exit
  fi

  ## first process all the -x --xxxx flags and options
  while true; do
    # flag <flag> is saved as $flag = 0/1
    # option <option> is saved as $option
    if [[ $# -eq 0 ]]; then
      ## all parameters processed
      break
    fi
    if [[ ! $1 == -?* ]]; then
      ## all flags/options processed
      break
    fi
    local save_option
    save_option=$(list_options |
      awk -v opt="$1" '
        BEGIN { FS="|"; OFS=" ";}
        $1 ~ /flag/   &&  "-"$2 == opt {print $3"=1"}
        $1 ~ /flag/   && "--"$3 == opt {print $3"=1"}
        $1 ~ /option/ &&  "-"$2 == opt {print $3"=$2; shift"}
        $1 ~ /option/ && "--"$3 == opt {print $3"=$2; shift"}
        $1 ~ /list/ &&  "-"$2 == opt {print $3"+=($2); shift"}
        $1 ~ /list/ && "--"$3 == opt {print $3"=($2); shift"}
        $1 ~ /secret/ &&  "-"$2 == opt {print $3"=$2; shift #noshow"}
        $1 ~ /secret/ && "--"$3 == opt {print $3"=$2; shift #noshow"}
        ')
    if [[ -n "$save_option" ]]; then
      if echo "$save_option" | grep shift >>/dev/null; then
        local save_var
        save_var=$(echo "$save_option" | cut -d= -f1)
        debug "$config_icon parameter: ${save_var}=$2"
      else
        debug "$config_icon flag: $save_option"
      fi
      eval "$save_option"
    else
      die "cannot interpret option [$1]"
    fi
    shift
  done

  ((help)) && (
    show_usage
    check_last_version
    out "                                  "
    echo "### TIPS & EXAMPLES"
    show_tips

  ) && safe_exit

  ## then run through the given parameters
  if expects_single_params; then
    single_params=$(list_options | grep 'param|1|' | cut -d'|' -f3)
    list_singles=$(echo "$single_params" | xargs)
    single_count=$(echo "$single_params" | count_words)
    debug "$config_icon Expect : $single_count single parameter(s): $list_singles"
    [[ $# -eq 0 ]] && die "need the parameter(s) [$list_singles]"

    for param in $single_params; do
      [[ $# -eq 0 ]] && die "need parameter [$param]"
      [[ -z "$1" ]] && die "need parameter [$param]"
      debug "$config_icon Assign : $param=$1"
      eval "$param=\"$1\""
      shift
    done
  else
    debug "$config_icon No single params to process"
    single_params=""
    single_count=0
  fi

  if expects_optional_params; then
    optional_params=$(list_options | grep 'param|?|' | cut -d'|' -f3)
    optional_count=$(echo "$optional_params" | count_words)
    debug "$config_icon Expect : $optional_count optional parameter(s): $(echo "$optional_params" | xargs)"

    for param in $optional_params; do
      debug "$config_icon Assign : $param=${1:-}"
      eval "$param=\"${1:-}\""
      shift
    done
  else
    debug "$config_icon No optional params to process"
    optional_params=""
    optional_count=0
  fi

  if expects_multi_param; then
    #debug "Process: multi param"
    multi_count=$(list_options | grep -c 'param|n|')
    multi_param=$(list_options | grep 'param|n|' | cut -d'|' -f3)
    debug "$config_icon Expect : $multi_count multi parameter: $multi_param"
    ((multi_count > 1)) && die "cannot have >1 'multi' parameter: [$multi_param]"
    ((multi_count > 0)) && [[ $# -eq 0 ]] && die "need the (multi) parameter [$multi_param]"
    # save the rest of the params in the multi param
    if [[ -n "$*" ]]; then
      debug "$config_icon Assign : $multi_param=$*"
      eval "$multi_param=( $* )"
    fi
  else
    multi_count=0
    multi_param=""
    [[ $# -gt 0 ]] && die "cannot interpret extra parameters"
  fi
}

require_binary(){
  binary="$1"
  path_binary=$(which "$binary" 2>/dev/null)
  [[ -n "$path_binary" ]] && debug "️$require_icon required [$binary] -> $path_binary" && return 0
  #
  words=$(echo "${2:-}" | wc -l)
  case $words in
    0)  install_instructions="$install_package $1";;
    1)  install_instructions="$install_package $2";;
    *)  install_instructions="$2"
  esac
  alert "$script_basename needs [$binary] but it cannot be found"
  alert "1) install package  : $install_instructions"
  alert "2) check path       : export PATH=\"[path of your binary]:\$PATH\""
  die   "Missing program/script [$binary]"
}

folder_prep() {
  if [[ -n "$1" ]]; then
    local folder="$1"
    local max_days=${2:-365}
    if [[ ! -d "$folder" ]]; then
      debug "$clean_icon Create folder : [$folder]"
      mkdir -p "$folder"
    else
      debug "$clean_icon Cleanup folder: [$folder] - delete files older than $max_days day(s)"
      find "$folder" -mtime "+$max_days" -type f -exec rm {} \;
    fi
  fi
}

count_words() { wc -w | awk '{ gsub(/ /,""); print}'; }

recursive_readlink() {
  [[ ! -L "$1" ]] && echo "$1" && return 0
  local file_folder
  local link_folder
  local link_name
  file_folder="$(dirname "$1")"
  # resolve relative to absolute path
  [[ "$file_folder" != /* ]] && link_folder="$(cd -P "$file_folder" &>/dev/null && pwd)"
  local symlink
  symlink=$(readlink "$1")
  link_folder=$(dirname "$symlink")
  link_name=$(basename "$symlink")
  [[ -z "$link_folder" ]] && link_folder="$file_folder"
  [[ "$link_folder" == \.* ]] && link_folder="$(cd -P "$file_folder" && cd -P "$link_folder" &>/dev/null && pwd)"
  debug "$info_icon Symbolic ln: $1 -> [$symlink]"
  recursive_readlink "$link_folder/$link_name"
}

lookup_script_data() {
  readonly script_prefix=$(basename "${BASH_SOURCE[0]}" .sh)
  readonly script_basename=$(basename "${BASH_SOURCE[0]}")
  readonly execution_day=$(date "+%Y-%m-%d")
  #readonly execution_year=$(date "+%Y")

  script_install_path="${BASH_SOURCE[0]}"
  debug "$info_icon Script path: $script_install_path"
  script_install_path=$(recursive_readlink "$script_install_path")
  debug "$info_icon Actual path: $script_install_path"
  readonly script_install_folder="$(dirname "$script_install_path")"
  if [[ -f "$script_install_path" ]]; then
    script_hash=$(hash <"$script_install_path" 8)
    script_lines=$(awk <"$script_install_path" 'END {print NR}')
  else
    # can happen when script is sourced by e.g. bash_unit
    script_hash="?"
    script_lines="?"
  fi

  # get shell/operating system/versions
  shell_brand="sh"
  shell_version="?"
  [[ -n "${ZSH_VERSION:-}" ]] && shell_brand="zsh" && shell_version="$ZSH_VERSION"
  [[ -n "${BASH_VERSION:-}" ]] && shell_brand="bash" && shell_version="$BASH_VERSION"
  [[ -n "${FISH_VERSION:-}" ]] && shell_brand="fish" && shell_version="$FISH_VERSION"
  [[ -n "${KSH_VERSION:-}" ]] && shell_brand="ksh" && shell_version="$KSH_VERSION"
  debug "$info_icon Shell type : $shell_brand - version $shell_version"

  readonly os_kernel=$(uname -s)
  os_version=$(uname -r)
  os_machine=$(uname -m)
  install_package=""
  case "$os_kernel" in
  CYGWIN* | MSYS* | MINGW*)
    os_name="Windows"
    ;;
  Darwin)
    os_name=$(sw_vers -productName)       # macOS
    os_version=$(sw_vers -productVersion) # 11.1
    install_package="brew install"
    ;;
  Linux | GNU*)
    if [[ $(which lsb_release) ]]; then
      # 'normal' Linux distributions
      os_name=$(lsb_release -i)    # Ubuntu
      os_version=$(lsb_release -r) # 20.04
    else
      # Synology, QNAP,
      os_name="Linux"
    fi
    [[ -x /bin/apt-cyg ]] && install_package="apt-cyg install"     # Cygwin
    [[ -x /bin/dpkg ]] && install_package="dpkg -i"                # Synology
    [[ -x /opt/bin/ipkg ]] && install_package="ipkg install"       # Synology
    [[ -x /usr/sbin/pkg ]] && install_package="pkg install"        # BSD
    [[ -x /usr/bin/pacman ]] && install_package="pacman -S"        # Arch Linux
    [[ -x /usr/bin/zypper ]] && install_package="zypper install"   # Suse Linux
    [[ -x /usr/bin/emerge ]] && install_package="emerge"           # Gentoo
    [[ -x /usr/bin/yum ]] && install_package="yum install"         # RedHat RHEL/CentOS/Fedora
    [[ -x /usr/bin/apk ]] && install_package="apk add"             # Alpine
    [[ -x /usr/bin/apt-get ]] && install_package="apt-get install" # Debian
    [[ -x /usr/bin/apt ]] && install_package="apt install"         # Ubuntu
    ;;

  esac
  debug "$info_icon System OS  : $os_name ($os_kernel) $os_version on $os_machine"
  debug "$info_icon Package mgt: $install_package"

  # get last modified date of this script
  script_modified="??"
  [[ "$os_kernel" == "Linux" ]] && script_modified=$(stat -c %y "$script_install_path" 2>/dev/null | cut -c1-16) # generic linux
  [[ "$os_kernel" == "Darwin" ]] && script_modified=$(stat -f "%Sm" "$script_install_path" 2>/dev/null)          # for MacOS

  debug "$info_icon Last modif : $script_modified"
  debug "$info_icon Script ID  : $script_lines lines / md5: $script_hash"
  debug "$info_icon Creation   : $script_created"
  debug "$info_icon Running as : $USER@$HOSTNAME"

  # if run inside a git repo, detect for which remote repo it is
  if git status &>/dev/null; then
    readonly git_repo_remote=$(git remote -v | awk '/(fetch)/ {print $2}')
    debug "$info_icon git remote : $git_repo_remote"
    readonly git_repo_root=$(git rev-parse --show-toplevel)
    debug "$info_icon git folder : $git_repo_root"
  else
    readonly git_repo_root=""
    readonly git_repo_remote=""
  fi

  # get script version from VERSION.md file - which is automatically updated by pforret/setver
  [[ -f "$script_install_folder/VERSION.md" ]] && script_version=$(cat "$script_install_folder/VERSION.md")
  # get script version from git tag file - which is automatically updated by pforret/setver
  [[ -n "$git_repo_root" ]] && [[ -n "$(git tag &>/dev/null)" ]] && script_version=$(git tag --sort=version:refname | tail -1)
}

prep_log_and_temp_dir() {
  tmp_file=""
  log_file=""
  if [[ -n "${tmp_dir:-}" ]]; then
    folder_prep "$tmp_dir" 1
    tmp_file=$(mktemp "$tmp_dir/$execution_day.XXXXXX")
    debug "$config_icon tmp_file: $tmp_file"
    # you can use this temporary file in your program
    # it will be deleted automatically if the program ends without problems
  fi
  if [[ -n "${log_dir:-}" ]]; then
    folder_prep "$log_dir" 30
    log_file="$log_dir/$script_prefix.$execution_day.log"
    debug "$config_icon log_file: $log_file"
  fi
}

import_env_if_any() {
  env_files=("$script_install_folder/.env" "$script_install_folder/$script_prefix.env" "./.env" "./$script_prefix.env")

  for env_file in "${env_files[@]}"; do
    if [[ -f "$env_file" ]]; then
      debug "$config_icon Read config from [$env_file]"
      # shellcheck disable=SC1090
      source "$env_file"
    fi
  done
}

initialise_output  # output settings
lookup_script_data # find installation folder

[[ $run_as_root == 1  ]] && [[ $UID -ne 0 ]] && die "user is $USER, MUST be root to run [$script_basename]"
[[ $run_as_root == -1 ]] && [[ $UID -eq 0 ]] && die "user is $USER, CANNOT be root to run [$script_basename]"

init_options       # set default values for flags & options
import_env_if_any  # overwrite with .env if any

if [[ $sourced -eq 0 ]]; then
  parse_options "$@"    # overwrite with specified options if any
  prep_log_and_temp_dir # clean up debug and temp folder
  main                  # run main program
  safe_exit             # exit and clean up
else
  # just disable the trap, don't execute main
  trap - INT TERM EXIT
fi
