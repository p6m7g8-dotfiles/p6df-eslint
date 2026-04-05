# shellcheck shell=bash
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
