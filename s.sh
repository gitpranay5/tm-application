if ! git diff --quiet HEAD~1 HEAD -- service-config.yml; then
            changed_services=$(git diff HEAD~1 HEAD -- service-config.yml | tr -d '\r' | \
              awk '\
                /services:/ { in_services=1; next } \
                in_services && /([a-zA-Z0-9_-]+):/ { \
                  match($0, /([a-zA-Z0-9_-]+):/, m); \
                  print m[1]; \
                }' | grep 'application*' | sort -u | jq -R -s -c 'split("\n")[:-1]')

            echo "c_services=$changed_services"

          else
            echo "c_services=[]"
          fi