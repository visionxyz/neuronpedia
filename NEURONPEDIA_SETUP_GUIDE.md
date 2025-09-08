# Neuronpedia本地环境搭建成功指南

## 🎯 最终成功的命令序列

### 第一步：初始化环境
```bash
# 1. 克隆项目（如果还没有）
git clone https://github.com/hijohnnylin/neuronpedia.git
cd neuronpedia

# 2. 初始化环境配置
make init-env
```

### 第二步：修改配置文件
```bash
# 3. 修改Dockerfile（使用build:simple避免数据库连接问题）
# 文件：apps/webapp/Dockerfile 第65行
# 将：npm run build
# 改为：npm run build:simple

# 4. 创建缺失的环境文件
touch docker/.env
```

### 第三步：构建和运行
```bash
# 5. 构建webapp
make webapp-localhost-build

# 6. 运行webapp（包含数据库）
make webapp-localhost-run
```

### 第四步：访问应用
```bash
# 7. 打开浏览器访问
# http://localhost:3000
```

## 🔧 关键修改说明

### 修改1：Dockerfile
```dockerfile
# 文件：apps/webapp/Dockerfile
# 第65行修改为：
RUN bash -c 'set -a && source .env && set +a && npx prisma generate && npm run build:simple'
```

### 修改2：创建环境文件
```bash
# 创建缺失的docker/.env文件
touch docker/.env
```

## 📋 一键搭建脚本

创建 `neuronpedia-setup.sh` 文件：

```bash
#!/bin/bash
# neuronpedia-setup.sh

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
```

使用方法：
```bash
chmod +x neuronpedia-setup.sh
./neuronpedia-setup.sh
```

## ✅ 成功标志

当看到以下日志时，说明环境搭建成功：

```
✅ Database initialization completed successfully!
✅ Next.js 14.2.32
✅ Local: http://localhost:3000
✅ Ready in 283ms
```

## ⚠️ 注意事项

1. **推理服务器错误是正常的**：`Error: getaddrinfo EAI_AGAIN inference` 不影响基本功能
2. **PostgreSQL警告是正常的**：checkpoint频繁是正常的，不影响使用
3. **环境文件**：确保 `docker/.env` 文件存在

## 🎉 最终状态

- ✅ **应用运行**：http://localhost:3000
- ✅ **数据库连接**：本地PostgreSQL正常工作
- ✅ **数据加载**：神经元数据正常显示
- ✅ **基本功能**：浏览、搜索、查看神经元功能正常

## 🚀 下一步建议

1. **探索功能**：尝试浏览不同的神经元和模型
2. **配置推理服务器**（可选）：如果需要激活测试功能
3. **导入更多数据**（可选）：通过管理面板导入更多数据集

## 📝 问题解决记录

### 已解决的问题：

1. **Demo数据库权限问题**：
   - 原因：Demo数据库schema过时，缺少 `hasGraphs` 字段
   - 解决：改用本地数据库环境

2. **Docker构建问题**：
   - 原因：构建时执行 `prisma db push` 但数据库未启动
   - 解决：修改Dockerfile使用 `build:simple` 脚本

3. **环境文件路径问题**：
   - 原因：Makefile中的环境文件路径配置错误
   - 解决：创建缺失的 `docker/.env` 文件

4. **推理服务器连接错误**：
   - 原因：webapp试图连接未启动的推理服务器
   - 状态：这是正常的，不影响基本功能

5. **日期显示错误**：
   - 原因：可能是临时的数据格式问题
   - 状态：已自动解决

---

**创建时间**：2025-09-06
**环境**：Linux 5.19.0-41-generic
**项目版本**：Neuronpedia main branch
