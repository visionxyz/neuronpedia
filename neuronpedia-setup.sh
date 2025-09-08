#!/bin/bash
# Neuronpedia本地环境一键搭建脚本
# 使用方法：chmod +x neuronpedia-setup.sh && ./neuronpedia-setup.sh

echo "🚀 开始搭建Neuronpedia本地环境..."

# 检查是否在正确目录
if [ ! -f "Makefile" ]; then
    echo "❌ 错误：请在neuronpedia项目根目录下运行此脚本"
    exit 1
fi

# 1. 初始化环境
echo "📝 初始化环境配置..."
make init-env

# 2. 创建缺失的环境文件
echo "📁 创建环境文件..."
touch docker/.env

# 3. 构建webapp
echo "🔨 构建webapp..."
make webapp-localhost-build

# 4. 运行webapp
echo "🚀 启动webapp..."
make webapp-localhost-run

echo "✅ 完成！请访问 http://localhost:3000"
