#!/bin/bash

# 定义登录函数
logincqu() {
    # 提示用户输入账号
    echo -n "请输入账号："
    local user_account
    read user_account

    # 检查是否输入了账号
    if [ -z "$user_account" ]; then
        echo "错误: 账号不能为空。"
        return 1
    fi

    # 提示用户输入密码，不回显
    echo -n "请输入密码："
    local user_password
    read -s user_password
    #上面用户输入不显示，这里加一个显式的换行，与下面输出进行分隔
    echo

    # 检查是否输入了密码
    if [ -z "$user_password" ]; then
        echo "错误: 密码不能为空。"
        return 1
    fi

    # 构造登录URL
    #  local login_url="http://login.cqu.edu.cn:801/eportal/portal/login?callback=dr1004&login_method=1&user_account=%2C0%2C${user_account}&user_password=${user_password}&wlan_user_ip=&wlan_user_ipv6=&wlan_user_mac=000000000000&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.2.2&terminal_type=1&lang=zh-cn&v=9585&lang=zh-cn"
    local login_url="https://login.cqu.edu.cn:802/eportal/portal/login?callback=dr1004&login_method=1&user_account=%2C0%2C${user_account}&user_password=${user_password}&wlan_user_ip=&wlan_user_ipv6=&wlan_user_mac=ffffffffffff&wlan_ac_ip=&wlan_ac_name=&term_ua=&term_type=1&jsVersion=4.2.2&terminal_type=1&lang=zh-cn&v=6122&lang=zh"

    # 执行登录请求
    local response=$(curl -s "$login_url")

    # 检查登录响应内容是否包含成功标志
    if [[ $response == *"Portal协议认证成功"* ]]; then
        echo "登录成功: $response"
    else
        echo "登录失败: $response"
    fi
}

#定义注销函数
logoutcqu() {
    local unbind_url="https://login.cqu.edu.cn:802/eportal/portal/mac/unbind?callback=dr1005&user_account=&wlan_user_mac=ffffffffffff&wlan_user_ip=&wlan_user_ipv6=&jsVersion=4.2.2&v=4798&lang=zh"
    #执行解绑请求
    local unbind_response=$(curl -s "$unbind_url")
    echo "解绑响应: $unbind_response"

    local logout_url="https://login.cqu.edu.cn:802/eportal/portal/logout?callback=dr1004&login_method=1&user_account=drcom&user_password=123&ac_logout=1&register_mode=1&wlan_user_ip=&wlan_user_ipv6=&wlan_vlan_id=0&wlan_user_mac=ffffffffffff&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.2.2&v=4212&lang=zh"
    # 执行注销请求
    local response=$(curl -s "$logout_url")
    # 检查注销响应内容是否包含成功标志
    # dr1004({"result":1,"msg":"Radius注销成功！"});
    if [[ $response == *"Radius注销成功"* ]]; then
        echo "注销成功: $response"
    else
        echo "注销失败: $response"
    fi
}
