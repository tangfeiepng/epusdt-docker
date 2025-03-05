# EPUSDT Docker 一键部署

<p align="center">
<img src="https://raw.githubusercontent.com/tangfeiepng/epusdt-docker/main/images/usdtlogo.png" alt="EPUSDT Logo">
</p>

[![Docker](https://img.shields.io/badge/Docker-Ready-blue)](https://hub.docker.com/r/tangpengfei/epusdt)
[![Docker Compose](https://img.shields.io/badge/Docker%20Compose-Ready-brightgreen)](https://docs.docker.com/compose/)
[![USDT](https://img.shields.io/badge/USDT-TRC20-green)](https://tron.network/)
[![GitHub](https://img.shields.io/badge/GitHub-tangfeiepng-lightgrey)](https://github.com/tangfeiepng/epusdt-docker)

## 项目简介

`EPUSDT Docker` 是对原 [EPUSDT](https://github.com/assimon/epusdt) 项目的 Docker 化封装，让您可以一键部署 EPUSDT 支付系统，无需复杂的环境配置。通过 Docker 和 Docker Compose 技术，我们实现了更简单、更稳定的部署方式，使您可以在几分钟内搭建一个完整的 USDT 支付系统。

### 什么是 EPUSDT？

EPUSDT (Easy Payment USDT) 是一个私有化部署的 USDT 支付中间件(Trc20网络)，您可以通过它提供的 HTTP API 接口来集成到您的系统中，实现 USDT 的在线支付和消息回调。

## 特点

- **一键部署**：只需一条命令即可完成整个系统的部署
- **完整容器化**：包含 EPUSDT、MySQL、Redis 三个核心组件
- **数据持久化**：所有数据安全存储在宿主机上，重启容器不丢失数据
- **自动初始化**：数据库结构和初始配置全自动完成
- **安全可靠**：私有化部署确保资金安全，无中间商赚差价
- **简单配置**：通过 .env 文件即可轻松配置所有参数
- **自动更新**：支持版本更新，保持系统安全和稳定

## 快速开始

### 一键安装

```bash
curl -sSfL https://raw.githubusercontent.com/tangfeiepng/epusdt-docker/main/quick-install.sh -o quick-install.sh && bash quick-install.sh
```

### 手动安装

1. 克隆仓库：

```bash
git clone https://github.com/tangfeiepng/epusdt-docker.git
cd epusdt-docker
```

2. 编辑配置文件：

```bash
cp .env.example .env
nano .env  # 根据需要修改配置
```

3. 启动服务：

```bash
docker-compose up -d
```

## 项目结构

```
epusdt-docker/
├── docker-compose.yml      # Docker Compose 配置文件
├── .env                    # 环境变量配置
├── docker-entrypoint-initdb.d/  # SQL初始化脚本
│   └── epusdt.sql          # 数据库结构和初始数据
├── logs/                   # 日志目录（挂载）
├── runtime/                # 运行时文件（挂载）
├── static/                 # 静态资源文件（挂载）
├── data/                   # 数据目录
│   ├── mysql/              # MySQL数据（挂载）
│   └── redis/              # Redis数据（挂载）
└── epusdt-quick-install.sh # 一键安装脚本
```

## 配置说明

主要配置项在 `.env` 文件中，您可以根据需要修改：

- **应用配置**：应用名称、域名、调试模式等
- **数据库配置**：MySQL连接信息
- **Redis配置**：Redis连接信息
- **队列配置**：队列并发和优先级
- **Telegram配置**：机器人Token和管理员信息
- **API配置**：API认证Token
- **订单配置**：支付超时时间和汇率设置

## 使用方法

### 访问管理面板

一键部署完成后，您可以通过以下地址访问管理面板：

```
http://您的服务器IP:8000
```

### API接入

请参考原项目的 [API文档](https://github.com/assimon/epusdt/blob/master/wiki/API.md) 进行接入开发。

### 添加钱包地址

您可以通过管理面板或API接口添加钱包地址，用于接收支付。

## 常见问题

### 如何查看日志？

```bash
# 查看所有容器日志
docker-compose logs

# 只查看EPUSDT日志
docker-compose logs epusdt
```

### 如何更新系统？

```bash
cd epusdt-docker
git pull
docker-compose pull
docker-compose up -d
```

### 数据库连接问题

如果遇到数据库连接问题，请检查：
1. .env文件中的数据库配置
2. 确保MySQL容器已正常启动
3. 尝试重启服务：`docker-compose restart`

## 安全提示

1. 请定期备份您的数据
2. 不要将API Token泄露给他人
3. 建议在生产环境中使用HTTPS

## 贡献

欢迎提交Issues和Pull Requests来完善本项目。

## 相关项目

- [EPUSDT原项目](https://github.com/assimon/epusdt)

## 声明

本项目仅用于学习和技术交流，不得用于任何违反法律法规的用途。使用者应当遵守当地法律法规，自行承担法律责任。

```
警告！
项目中所涉及区块链代币均为学习用途，不鼓励和支持任何"挖矿"，"炒币"，"虚拟币ICO"等非法行为
虚拟币市场行为不受监管要求和控制，投资交易需谨慎，仅供学习区块链知识
```

## 许可证

本项目遵循 [GPLv3](https://www.gnu.org/licenses/gpl-3.0.html) 开源协议。