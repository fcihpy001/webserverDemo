#!/bin/bash

# 确保已安装 GitHub CLI (gh)
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) 未安装，请先安装 https://cli.github.com/"
    exit 1
fi

# 检查.env文件是否存在
if [ ! -f ".env" ]; then
    echo "❌ .env 文件不存在，请创建后重试。"
    exit 1
fi

# 读取.env文件
echo "✅ 读取 .env 文件..."

SERVER_IP=$(grep SERVER_IP .env | cut -d '=' -f2)
SERVER_USER=$(grep SERVER_USER .env | cut -d '=' -f2)
SSH_PRIVATE_KEY=$(grep -A 100 SSH_PRIVATE_KEY .env | cut -d '=' -f2-)

# 检查变量是否为空
if [[ -z "$SERVER_IP" || -z "$SERVER_USER" || -z "$SSH_PRIVATE_KEY" ]]; then
    echo "❌ 变量缺失，请检查 .env 文件。"
    exit 1
fi

# 设置 GitHub Secrets (替换your-repo为实际仓库)
REPO="fcihpy001/webserverDemo"

echo "🔑 设置 GitHub Secrets..."

gh secret set SERVER_IP -b"$SERVER_IP" -R "$REPO"
gh secret set SERVER_USER -b"$SERVER_USER" -R "$REPO"
gh secret set SSH_PRIVATE_KEY -b"$SSH_PRIVATE_KEY" -R "$REPO"

echo "✅ GitHub Secrets 设置完成！"
