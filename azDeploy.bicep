param location string = 'northeurope'

@description('admin username')
@minLength(3)
@maxLength(15)
param adminUsername string = 'mlvcsuperuser'

//ip address: 52.138.248.225
param sshPublicKey string = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyZMvUc24GfJUUlIgZrJ6MnRqFPkq/HBD2rDuufSi1yZ51RRglc3asHso5etZHbi9K0n+AXJ30ggOYgwKXz8xOhTxgFWFCdTWbLcepS1JL9QdanydE8J+zkntnADjWyMT0doXhNXEXIwclDGOz+s+4qp560sbT5PhANzkmU7uQvC1qY99P6kLMsD6TvuUb70hRmhXCgoPacU4adurBOt/zVnI1wlIxOdM0uZYb87Q/x4r6MMZUmoSaul70pFGHNb51w4dHz2FCzAJ8Dv/p+73Wz/wJ3mmsz5N7huNVJv9YkdCv9BFc3hMSThLYockoYwP8oVCh6ZwLEYUmy1e28ECvNaxnol/iBwyv2FwL6Yuyf9o9X1IIzhvRgCn70HSaTdp/MsCuQPczNnV5L085a9vlGBmyOUaDeuQmMl1TXFZMPToQF+amCjG7yzIvAu+yP/cUqC3nrELEjtziBOodlCezTLVOeRtaxQVkaYiP8D6H3LhXqnJ0ETqf9dorR6059hc= vetle@velte'
param sshPrivateKey string = '-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAlwAAAAdzc2gtcn
NhAAAAAwEAAQAAAYEAxY8wrmklB3Yk1mcj8q4xKhSnw+RFGH9iA4PyHyAtAUVRWtHG8nRQ
lqz02FUkklHncnxhVZ0ZTew0KNMZ6PslC0LZ5Ut58ReV4NsW0C25Th1jxn8Vu2yzpFlxTA
rVr1eDRn/uqhxZhTSKc5CGk2UUlG8FY4vHqYy2QIdXeUWr9rM9fY6jz0La6eZ+7KMqBZEV
Y0jT1EDrIs0Obc9X2F5NnbyHppA6cH4mS4KqzSOTI2lyZPQoAo9LJP9BQ1BgYja6i5noy4
EFQhz1CWvFSOdquz9nUAmrEY1ksB9kAsTRwAAAGBSPPrijzz64o8AAAAHc3NoLXJzYQAAA
wEAAQAAAYEAxY8wrmklB3Yk1mcj8q4xKhSnw+RFGH9iA4PyHyAtAUVRWtHG8nRQlqz02FU
kklHncnxhVZ0ZTew0KNMZ6PslC0LZ5Ut58ReV4NsW0C25Th1jxn8Vu2yzpFlxTArVr1eDR
n/uqhxZhTSKc5CGk2UUlG8FY4vHqYy2QIdXeUWr9rM9fY6jz0La6eZ+7KMqBZEVY0jT1ED
rIs0Obc9X2F5NnbyHppA6cH4mS4KqzSOTI2lyZPQoAo9LJP9BQ1BgYja6i5noy4EFQhz1C
WvFSOdquz9nUAmrEY1ksB9kAsTRwAAAAMBAAEAAAGACkrnGvlWTvfbLDmPrMH+zJux2Z9N
oOZX+2lGuAeKFVtP6KFn2+UwZtJObTG7sGHWfxkgyd8BxjT8PlWn3U0GeMuAX78b3GhUgp
xe1o+bI9IQ6i3e9K06jhWvXv1VwOhZPNZ7X5iFvhpeH9MJ6m7XYa1n6ivk+Rrq8r5y+zQ4
6Oj5uAAABAHqU0lJ6lNJSAQAAAMEAyTq/xDZmaeMFEN5CU51yIpNVig6fXK4ZnEl5oRyRn
oHtx3kC0WwWNd0E8ZSLknt1zIQybP1S98DpKeOZYY6O6V9nt+V89QZHwblXdbzy82mBFqj
JgHT4U3XSh5Jra03Z1k+KhPlcsxIyg10gJwZ3MykApieME+EZD3l3qmp0UAAAAMBAAEAAA
GAZsnFSHgpcNwoWbNPkeEB2iZVvdVp1nEHzfhjdpv+IBI2VjnpOGg1MlfP8xuEGnZcMiHg
K0iH+kRGSYjCKhO3yOb6ka49lpoRA1nKDsRQ9MuBOMuqrs2vqIP3Wok7eoZgbUVOCsiMwn
7PI6mFZMPWDGyD1+u4qFysiv8umYVzhGdUAAAAYQGVkdWNhdG9yQGV4YW1wbGUuY29t
-----END OPENSSH PRIVATE KEY-----'

param vmName string = 'vm1'

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'vnet'
  location: location
  properties: {
     addressSpace: {
       addressPrefixes: [
        '10.13.37.0/24'
       ]
     }
     subnets: [
      { 
        name: 'testVMsubnet'
        properties: {
          addressPrefix: '10.13.37.0/24'
        }
      }
     ]
  }
}

resource networksecuritygroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: 'networksecuritygroup'
  location: location
  properties: {
     securityRules: [
       {
        name: 'Allow-SSH'
        properties:{
          priority: 1001
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
          description: 'Allows SSH'
        }
       }
     ]
  }
}

resource publicIP 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: 'publicIP'
  location: location
  properties:{
     publicIPAllocationMethod: 'Static'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: 'testVMnic'
  location:location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
           subnet: {
             id: vnet.properties.subnets[0].id
           }
        publicIPAddress: {
          id: publicIP.id
          }
        }
      }
    ]
    networkSecurityGroup: { 
      id: networksecuritygroup.id
    }
  }
}

var imageReference = {
  'Ubuntu-2204': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
  }
}


resource vm 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: vmName
  location: location
   properties: {
     hardwareProfile: {
       vmSize: 'Standard_B1s'
     }
      osProfile: {
        computerName: 'testVM'
        adminUsername: adminUsername
        linuxConfiguration: {
          disablePasswordAuthentication: true
          ssh: {
            publicKeys: [
              {
                path: '/home/${adminUsername}/.ssh/authorized_keys'
                keyData: sshPublicKey
              } 
            ]
          }
          
        }
      }
      storageProfile: {
         imageReference: imageReference['Ubuntu-2204']
      }
      networkProfile: {
        networkInterfaces:[
          {
            id: nic.id
          }
        ]
      }
   }
}
