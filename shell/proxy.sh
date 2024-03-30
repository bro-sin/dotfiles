# proxy
proxy_ip="$(echo $SSH_CLIENT | awk '{print $1}')"
proxy_port="7890"

proxy_on() {
  if [[ -z $proxy_ip || -z $proxy_port ]]; then
    echo "Please set the 'proxy_ip' and 'proxy_port' environment variables."
    return 1
  fi

  local proxy_url="http://$proxy_ip:$proxy_port"

  export http_proxy="$proxy_url"
  export https_proxy="$proxy_url"
  export HTTP_PROXY="$proxy_url"
  export HTTPS_PROXY="$proxy_url"

  echo "Proxy set to $proxy_url"
}

proxy_off() {
  unset http_proxy
  unset https_proxy
  unset HTTP_PROXY
  unset HTTPS_PROXY

  echo "Proxy disabled"
}

