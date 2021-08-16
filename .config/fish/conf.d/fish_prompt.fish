# Initialize glyphs to be used in the prompt.
set -q chain_prompt_glyph
  or set -g chain_prompt_glyph ">"
set -q chain_git_branch_glyph
  or set -g chain_git_branch_glyph "⎇"
set -q chain_git_dirty_glyph
  or set -g chain_git_dirty_glyph "±"
set -q chain_su_glyph
  or set -g chain_su_glyph " ⚡"

function __chain_prompt_segment
  set_color $argv[1]
  echo -n -s "[" $argv[2..-1] "]"
  set_color CC7832
  echo -n -s "-"
end

function __chain_git_branch_name
  echo (command git branch --show-current 2>/dev/null)
end

function __chain_is_git_dirty
  echo (command git status -s --ignore-submodules=dirty)
end

function __chain_prompt_root
  set -l uid (id -u $USER)
  if test $uid -eq 0
    __chain_prompt_segment yellow $chain_su_glyph
  end
end

function __chain_prompt_dir
  __chain_prompt_segment CC7832 (prompt_pwd)
end

function __chain_prompt_time
  __chain_prompt_segment CC7832 (date "+%H:%M:%S")
end

function __chain_prompt_git
  if test (__chain_git_branch_name)
    set -l git_branch (__chain_git_branch_name)
    __chain_prompt_segment brblue "$chain_git_branch_glyph $git_branch"

    if test (__chain_is_git_dirty)
      __chain_prompt_segment yellow $chain_git_dirty_glyph
    end
  end
end

function __chain_prompt_arrow
  if test $last_status = 0
    set_color 629755
  else
    set_color red
    echo -n "($last_status)-"
  end

  echo -n "$chain_prompt_glyph "
end

function fish_prompt
  set -g last_status $status

  __chain_prompt_root
  __chain_prompt_time
  __chain_prompt_dir
  type -q git; and __chain_prompt_git
  __chain_prompt_arrow

  set_color normal
end
