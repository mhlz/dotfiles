# Defined in - @ line 1
function pbpaste --wraps='xsel --clipboard --output' --description 'alias pbpaste=xsel --clipboard --output'
  xsel --clipboard --output $argv;
end
