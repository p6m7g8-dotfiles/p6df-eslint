# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::js::deps()
#
#>
######################################################################
p6df::modules::js::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6df-js
  )
}

######################################################################
#<
#
# Function: p6df::modules::js::vscodes()
#
#>
######################################################################
p6df::modules::js::vscodes() {

  # webasm/ts/js/deno/node/html/css
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension dsznajder.es7-react-js-snippets

  p6_return_void
}

######################################################################
#<
#
# Function: str str = p6df::modules::js::eslint::prompt::line()
#
#  Returns:
#	str - str
#
#  Environment:	 ESLINT_USE_FLAT_CONFIG
#>
######################################################################
p6df::modules::js::eslint::prompt::line() {

  local str=""

  if ! p6_string_blank "$ESLINT_USE_FLAT_CONFIG"; then
    str="${str}env:[ESLINT_USE_FLAT_CONFIG=$ESLINT_USE_FLAT_CONFIG]"
  fi

  local ext
  for ext in js mjs cjs ts mts cts; do
    if p6_file_exists "eslint.config.$ext"; then
      str="${str}file:[eslint.config.$ext]"
    fi
  done

  for ext in js json yaml yml; do
    if p6_file_exists ".eslintrc.$ext"; then
      str="${str}file:[.eslintrc.js]"
    fi
  done

  if p6_file_exists "package.json"; then
    if p6_file_contains "eslintOptions" "package.json"; then
      str="${str}file:[package.json]"
    fi
  fi

  if ! p6_string_blank "$str"; then
    str="eslint:\t\t  $str"
  fi

  p6_return_str "$str"
}

######################################################################
#<
#
# Function: p6df::modules::js::eslint::plugins()
#
#>
######################################################################
p6df::modules::js::eslint::plugins() {

  # @stylistic/eslint-plugin
  # @types/eslint
  # @unocss/eslint-plugin
  # eslint-plugin-eslint-comments
  # eslint-plugin-format
  # eslint-plugin-i
  # eslint-plugin-jsdoc
  # eslint-plugin-markdown
  # eslint-plugin-n
  # eslint-plugin-no-only-tests
  # eslint-plugin-perfectionist
  # eslint-plugin-react-hooks
  # eslint-plugin-react-refresh
  # eslint-plugin-react
  # eslint-plugin-unicorn
  # eslint-plugin-unused-imports

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::js::eslint::clones()
#
#  Environment:	 P6_DFZ_SRC_FOCUSED_DIR P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6df::modules::js::eslint::clones() {

  p6_github_login_clone eslint "$P6_DFZ_SRC_FOCUSED_DIR"

  p6_run_parallel "0" "4" "$(cat $P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-js/conf/eslints)" "p6_git_p6_clone" "" "$P6_DFZ_SRC_FOCUSED_DIR"

  p6_return_void
}
