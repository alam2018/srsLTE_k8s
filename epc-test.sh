if [ -z "$epc_pod_addr" ]; then

    while [ -z $(getent hosts epc-service-pod | awk '{ print $1 }') ]
    do
        echo "Waiting for the epc to come up..."
        sleep 10
    done

    echo "Epc service found"
    EPC_POD_ADDR=$(getent hosts epc-service-pod | awk '{ print $1 }')

else
    EPC_POD_ADDR=$epc_pod_addr
fi
