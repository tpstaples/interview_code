import json
import requests

INSERT_KEY = 'xyz'
ACCOUNT_ID = '11111111111127'

headers = { 'X-Insert-Key': INSERT_KEY }
url = 'https://insights-collector.newrelic.com/v1/accounts/' + ACCOUNT_ID + '/events'

import subprocess
bashCommand = "sudo netstat-nat -p tcp -n | wc -l"
process = subprocess.Popen(bashCommand, stdout=subprocess.PIPE,shell=True)
portcount, error = process.communicate()

bashCommand = "sudo netstat-nat -p tcp -n | grep TIME_WAIT | wc -l"
process = subprocess.Popen(bashCommand, stdout=subprocess.PIPE,shell=True)
timewaitportcount, error = process.communicate()

bashCommand = "sudo netstat-nat -p tcp -n | grep ESTABLISHED | wc -l"
process = subprocess.Popen(bashCommand, stdout=subprocess.PIPE,shell=True)
establishedportcount, error = process.communicate()

bashCommand = "sudo netstat-nat -p tcp -n | grep CLOS | wc -l"
process = subprocess.Popen(bashCommand, stdout=subprocess.PIPE,shell=True)
closingportcount, error = process.communicate()

bashCommand = "sudo netstat-nat -p tcp -n | grep 11211 | wc -l"
process = subprocess.Popen(bashCommand, stdout=subprocess.PIPE,shell=True)
elasticacheportcount, error = process.communicate()

bashCommand = "sudo netstat-nat -p tcp -n | grep 3306 | wc -l"
process = subprocess.Popen(bashCommand, stdout=subprocess.PIPE,shell=True)
rdsportcount, error = process.communicate()

bashCommand = "hostname"
process = subprocess.Popen(bashCommand, stdout=subprocess.PIPE,shell=True)
hostname, error = process.communicate()
account = hostname[:3]

bashCommand = "ip -f inet -br a | grep ens | awk '{ print $3 }' | sed 's/\/.*//'"
process = subprocess.Popen(bashCommand, stdout=subprocess.PIPE,shell=True)
ipaddress, error = process.communicate()

content = json.dumps({
    'eventType': 'EC2PortUsage',
    'ec2name': hostname,
    'ipaddr': ipaddress,
    'account': account,
    'usedPorts': portcount,
    'timeWaitPorts': timewaitportcount,
    'establishedPorts': establishedportcount,
    'closingPorts': closingportcount,
    'elasticachePorts': elasticacheportcount,
    'rdsPorts': rdsportcount
})

requests.post(url, data = content, headers = headers)
