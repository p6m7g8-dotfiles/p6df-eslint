# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::eslint::deps()
#
#>
######################################################################
p6df::modules::eslint::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6df-js
  )
}

######################################################################
#<
#
# Function: p6df::modules::eslint::vscodes()
#
#>
######################################################################
p6df::modules::eslint::vscodes() {

  # webasm/ts/js/deno/node/html/css
  p6df::modules::vscode::extension::install dbaeumer.vscode-eslint
  p6df::modules::vscode::extension::install dsznajder.es7-react-js-snippets

  p6_return_void
}

######################################################################
#<
#
# Function: str json = p6df::modules::eslint::vscodes::config()
#
#  Returns:
#	str - json
#
#>
######################################################################
p6df::modules::eslint::vscodes::config() {

  cat <<'EOF'
  "eslint.format.enable": true,
  "eslint.lintTask.enable": true,
  "eslint.run": "onSave",
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "markdown",
    "json",
    "jsonc",
    "yaml",
    "xml"
  ],
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit",
    "source.organizeImports": "never"
  }
EOF

  p6_return_void
}

######################################################################
#<
#
# Function: str str = p6df::modules::eslint::prompt::line()
#
#  Returns:
#	str - str
#
#  Environment:	 ESLINT_USE_FLAT_CONFIG
#>
######################################################################
p6df::modules::eslint::prompt::line() {

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
# Function: p6df::modules::eslint::plugins()
#
#>
######################################################################
p6df::modules::eslint::plugins() {

  yarn add -D @typescript-eslint/eslint-plugin
  yarn add -D @typescript-eslint/parser
  yarn add -D @antfu/eslint-config
  yarn add -D @next/eslint-plugin-next
  yarn add -D eslint
  yarn add -D eslint-plugin-import
  yarn add -D eslint-plugin-react
  yarn add -D eslint-plugin-react-hooks
  yarn add -D eslint-plugin-tailwindcss
#  yarn add -D eslint-plugin-cdk

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::eslint::clones()
#
#  Environment:	 P6_DFZ_SRC_FOCUSED_DIR P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6df::modules::eslint::clones() {

  p6_github_login_clone eslint "$P6_DFZ_SRC_FOCUSED_DIR"

  p6_run_parallel "0" "4" "$(cat "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR"/p6df-js/conf/eslints)" "p6_git_p6_clone" "" "$P6_DFZ_SRC_FOCUSED_DIR"

  p6_return_void
}
