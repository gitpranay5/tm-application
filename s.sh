git diff HEAD~$1 HEAD -- service-config.yml \
  | grep '^[+-]' \
  | grep -v '^[+-]\s*#' \
  | awk '
    /^[+-]?services:/ { in_services=1; next }

    in_services && match($0, /^[+-]\s{2}([a-zA-Z0-9_-]+):/, m) {
      current_service=m[1]
      print current_service
      next
    }

    in_services && /^[+-]\s{4}/ && current_service != "" {
      print current_service
    }
  ' \
  | sort -u \
  | jq -R -s -c 'split("\n")[:-1]'
