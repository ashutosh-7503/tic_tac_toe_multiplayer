export default [
  {
    ignores: ['node_modules/**'],
    languageOptions: {
      ecmaVersion: 'latest',
      sourceType: 'module',
    },
    rules: {
      // Add your rules here
      'no-unused-vars': 'warn',
      'no-console': 'off',
    },
  },
];