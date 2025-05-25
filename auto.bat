@echo off
setlocal

:: 设置仓库路径，修改为你的仓库实际路径
set "REPO_PATH=C:\Users/berni/Desktop/thesis-2025-summer"

:: 设置提交信息为当前日期
for /f "tokens=2 delims==" %%a in ('wmic OS Get LocalDateTime /value') do set "dt=%%a"
set "commit_date=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%"
set "COMMIT_MSG=Auto commit on %commit_date%"

:: 切换到仓库目录
cd /d "%REPO_PATH%" || (
    echo Error: Cannot switch to %REPO_PATH%
    goto :END
)

@REM :: 检查是否为Git仓库
@REM git rev-parse --is-inside-work-tree >nul 2>&1 || (
@REM     echo Error: %REPO_PATH% not a git repo
@REM     goto :END
@REM )

:: 检查是否有文件更改
git diff --quiet --exit-code && (
    echo no change
    goto :END
) || (
    echo has change today, good job...
)

:: 执行Git操作
echo add...
git add .

echo commit...
git commit -m "%COMMIT_MSG%"

echo push...
git push origin main

:END
echo done
endlocal

timeout /T 10