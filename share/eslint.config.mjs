import antfu from '@antfu/eslint-config'
import nextPlugin from '@next/eslint-plugin-next'
import react from 'eslint-plugin-react'
import reactHooks from 'eslint-plugin-react-hooks'
import tailwindcss from 'eslint-plugin-tailwindcss'

export default antfu({
  //  files: ['jest.config.ts', 'jest.setup.tsx', 'src/**/*.tsx', 'src/**/*.ts', 'test/**/*.tsx', 'test/**/*.ts'],
  ignores: [
    'src/dotenv.ts',
    'next-env.d.ts',
    'tsconfig.json',
    '.vscode/settings.json',
  ],
  plugins: {
    react,
    'react-hooks': reactHooks,
    '@next/eslint-plugin-next': nextPlugin,
    tailwindcss,
  },
  languageOptions: {
    parserOptions: {
      ecmaFeatures: {
        jsx: true,
      },
    },
  },
  rules: {
    'react/jsx-uses-react': 'off',
    'react/react-in-jsx-scope': 'off',
    'react-hooks/rules-of-hooks': 'error',
    'react-hooks/exhaustive-deps': 'error',
    // '@next/next/no-img-element': 'error',
    // '@next/next/no-page-custom-font': 'error',
    'tailwindcss/classnames-order': 'error',
  },
  settings: {
    react: {
      version: 'detect',
    },
  },
})
