#!/usr/bin/env bash
# 生成 Gradle Wrapper（含 gradle-wrapper.jar）
# 前提：本机已安装 gradle（任意版本）与 JDK 17
# 用法：./generate-wrapper.sh
set -e
gradle wrapper --gradle-version 8.7 --distribution-type bin
echo "done. 现在可以使用 ./gradlew :app:assembleDebug"
