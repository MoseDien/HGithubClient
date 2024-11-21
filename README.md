# HGithubClient
- Bell Zheng
- 请查看[演示视频](./HGithubClient-demo.mp4)

## 特性
- 使用swiftui
- 用户名密码和生物登录，使用keychain存储用户名和密码
- 使用Github search API - https://api.github.com/search/repositories
- 登录之后设置头像
- 支持dark/light mode, 支持横竖屏
- 使用 MVVM 模式
- 针对ViewModel的单元测试

## 哪些使用了GitHub API
- GitHub趋势
- 搜索

## 哪些是模拟的
- 用户登录，用户名和密码，请用"Jerry" + "Jerry123"
- 个人资料(Profile)

## 缺失的特性和解释
- 最低iOS版本 - 15.6: 这是我的Xcode支持的最低版本
- 没有发布testflight: 我的开发者账号目前无法发布testflight
- 没有提供可安装包，如果需要测试，只能从源代码编译和安装
- 没有写UI automation
