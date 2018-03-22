kafkapod=$(/consul/bin/kubectl -n {{ .Values.nsPrefix }} get pod | grep -o "message-router-global-kafka-[^[:space:]]*")
if [ -n "$kafkapod" ]; then
   if /consul/bin/kubectl -n {{ .Values.nsPrefix }} exec -it $kafkapod -- ps ef | grep -i kafka; then
      echo Success. Kafka process is running. 2>&1
      exit 0
   else
      echo Failed. Kafka is not running. 2>&1
      exit 1
   fi
else
   echo Failed. Kafka container is offline. 2>&1
   exit 1
fi