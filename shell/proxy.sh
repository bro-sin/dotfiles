#!/bin/bash
# proxy
__default_proxy_ip="$(echo "$SSH_CLIENT" | awk '{print $1}')"
if [[ -z $__default_proxy_ip ]]; then
  __default_proxy_ip="localhost"
fi
__default_proxy_port="7897"

function __proxy_on() {
  local proxy_ip=$1
  local proxy_port=$2
  local proxy_url="http://$proxy_ip:$proxy_port"

  export http_proxy="$proxy_url"
  export https_proxy="$proxy_url"
  export HTTP_PROXY="$proxy_url"
  export HTTPS_PROXY="$proxy_url"

  echo "Proxy set to $proxy_url"
}

function __proxy_off() {
  unset http_proxy
  unset https_proxy
  unset HTTP_PROXY
  unset HTTPS_PROXY

  echo "Proxy disabled"
}

function __proxy_show_help() {
  local default_proxy_ip

  if [[ -z $proxy_ip ]]; then
    default_proxy_ip=$__default_proxy_ip
  else
    default_proxy_ip=$proxy_ip
  fi

  local default_proxy_port
  if [[ -z $proxy_port ]]; then
    default_proxy_port=$__default_proxy_port
  else
    default_proxy_port=$proxy_port
  fi

  echo "Usage: proxy [on|off] [--ip <proxy_ip>] [--port <proxy_port>]"
  echo
  echo "Options:"
  echo "  on                Enable the proxy"
  echo "  off               Disable the proxy"
  echo "  --ip <proxy_ip>   Set the proxy IP address (default: $default_proxy_ip)"
  echo "  --port <proxy_port> Set the proxy port (default: $default_proxy_port)"
  echo
  echo "Example: proxy on --ip 127.0.0.1 --port 7897"
}

function proxy() {
  local __proxy_ip
  if [[ -z $proxy_ip ]]; then
    __proxy_ip=$__default_proxy_ip
  else
    __proxy_ip=$proxy_ip
  fi

  local __proxy_port
  if [[ -z $proxy_port ]]; then
    __proxy_port=$__default_proxy_port
  else
    __proxy_port=$proxy_port
  fi

  local action
  while [[ $# -gt 0 ]]; do
    case $1 in
    on | off)
      action="$1"
      shift
      ;;
    --ip)
      __proxy_ip="$2"
      shift 2
      ;;
    --port)
      __proxy_port="$2"
      shift 2
      ;;
    -h | --help)
      __proxy_show_help
      return 0
      ;;
    *)
      echo "Unknown option: $1"
      __proxy_show_help
      return 1
      ;;
    esac
  done
  if [[ $action == "on" ]]; then
    __proxy_on "$__proxy_ip" "$__proxy_port"
  elif [[ $action == "off" ]]; then
    __proxy_off
  else
    __proxy_show_help
  fi
}
