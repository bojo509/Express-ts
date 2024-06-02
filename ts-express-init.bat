@echo off
set /p projectName=Enter the name of the project:
mkdir %projectName%
cd %projectName%
call npm init -y
call tsc --init
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0tsconfigmodifier.ps1"
call npm install mongodb mongoose express typescript nodemon express-mongo-sanitize dotenv cors body-parser concurrently @types/node @types/express @types/cors
setlocal enabledelayedexpansion
set "insertLine=7"
set /a currentLine=0

(for /f "delims=" %%A in (package.json) do (
  set /a currentLine+=1
  if !currentLine! equ %insertLine% (
    echo "build": "npx tsc",
    echo "dev": "concurrently \"npx tsc -w\" \"nodemon ./dist/index.js\"",
  )
  echo %%A
)) > filename.tmp

move /y filename.tmp package.json
mkdir Controllers
mkdir dbConfig
mkdir Models
mkdir Routes
mkdir Middleware
type NUL > index.ts

(
echo logs
echo *.log
echo npm-debug.log*
echo yarn-debug.log*
echo yarn-error.log*
echo lerna-debug.log*
echo .pnpm-debug.log*
echo report.[0-9]*.[0-9]*.[0-9]*.[0-9]*.json
echo pids
echo *.pid
echo *.seed
echo *.pid.lock
echo lib-cov
echo coverage
echo *.lcov
echo .nyc_output
echo .grunt
echo bower_components
echo .lock-wscript
echo build/Release
echo node_modules/
echo jspm_packages/
echo web_modules/
echo *.tsbuildinfo
echo .npm
echo .eslintcache
echo .stylelintcache
echo .rpt2_cache/
echo .rts2_cache_cjs/
echo .rts2_cache_es/
echo .rts2_cache_umd/
echo .node_repl_history
echo *.tgz
echo .yarn-integrity
echo .env
echo .env.development.local
echo .env.test.local
echo .env.production.local
echo .env.local
echo .cache
echo .parcel-cache
echo .next
echo out
echo .nuxt
echo dist
echo .cache/
echo .vuepress/dist
echo .temp
echo .docusaurus
echo .serverless/
echo .fusebox/
echo .dynamodb/
echo .tern-port
echo .vscode-test
echo .yarn/cache
echo .yarn/unplugged
echo .yarn/build-state.yml
echo .yarn/install-state.gz
echo .pnp.*
echo .webpack/
echo .svelte-kit
) > .gitignore

type NUL > .env
call npm run build
echo Project setup completed successfully!
pause