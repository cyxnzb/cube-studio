# TME Cube Studio
TME Cube Studio是由TME研发的集成数据处理、分布式计算、机器学习模型训练等多项功能的容器化算法平台, 帮助算法使用者提升算法迭代效率和共享度. Cube Studio包含多种组件, 支持TensorFlow、PyTorch等多种框架的分布式训练，自定义Pipeline构建等功能. 

# 开源共建
有意向进行开源共建的同学请微信添加767065521并备注"Cube Studio开源共建"进入微信群.

# 功能简述

<object data="docs/user.pdf" type="application/pdf" width="700px" height="700px">
    <embed src="http://yoursite.com/the.pdf">
        <p> 下载 <a href="./docs/user.pdf"> PDF</a>.</p>
    </embed>
</object>

# 平台部署流程

基础环境依赖
 - docker >= 19.03  
 - kubernetes >=1.18  
 - kubectl >=1.18  
 - ssd ceph > 10T  挂载到每台机器的 /data/k8s/  
 - 单机 磁盘>=1T   单机磁盘容量要求不大，仅做镜像容器的的存储  
 - 控制端机器 cpu>=32 mem>=64G * 2  
 - 任务端机器，根据需要自行配置  

本平台依赖k8s/kubeflow/prometheus/efk相关组件，请优先参考install/kubenetes/readme.md 部署依赖组件。

平台完成部署之后如下:
![image](./docs/example/pic/pipeline.png)

# 本地调试

## deploy mysql

```
linux
docker run --network host --restart always --name mysql -e MYSQL_ROOT_PASSWORD=admin -d mysql:5.7
mac
docker run -p 3306:3306 --restart always --name mysql -e MYSQL_ROOT_PASSWORD=admin -d mysql:5.7

```
进入数据库创建一个db
```
CREATE DATABASE IF NOT EXISTS kubeflow DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
```
镜像构建


```
构建基础镜像（包含基础环境）
docker build -t ai.tencentmusic.com/tme-public/kubeflow-dashboard:base -f install/docker/Dockerfile-base .

使用基础镜像构建生产镜像
docker build -t ai.tencentmusic.com/tme-public/kubeflow-dashboard:2021.10.01 -f install/docker/Dockerfile .
```

镜像拉取(如果你不参与开发可以直接使用线上镜像)
```
docker pull ai.tencentmusic.com/tme-public/kubeflow-dashboard:2021.10.01
```

## deploy myapp (docker-compose)

本地开发使用

docker-compose.yaml文件在install/docker目录下，这里提供了mac和linux版本的docker-compose.yaml。
可自行修改
image：刚才构建的镜像
LOGIN_URL地址：登录重定向地址
MYSQL_SERVICE：mysql的地址


1) init database
```
STAGE: 'init'
docker-compose -f docker-compose.yml  up
```
2) build fore
```
STAGE: 'build'
docker-compose -f docker-compose.yml  up
```
3) debug backend
```
STAGE: 'dev'
docker-compose -f docker-compose.yml  up
```
4) Production
```
STAGE: 'prod'
docker-compose -f docker-compose.yml  up
```

部署以后，登录首页 会自动创建用户，绑定角色（Gamma和username同名角色）。

可根据自己的需求为角色授权。


## 可视化页面

页面资源镜像制作：
```sh
cd myapp/vision && docker build --no-cache ./ -t your_images_name:your_label --network host
```

项目资源打包：
```
开发环境要求：
node: 14.15.0+
npm: 6.14.8+

包管理（建议使用yarn）：
yarn: npm install yarn -g
```
```sh
# 初始化安装可能会遇到依赖包的版本选择，直接回车默认即可
cd myapp/vision && yarn && yarn build
```

输出路径：`/myapp/static/appbuilder`



