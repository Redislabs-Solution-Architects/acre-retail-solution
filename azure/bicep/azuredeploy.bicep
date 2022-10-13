param azure_region_1 string = 'East US'
param azure_region_2 string = 'West US'
param azure_region_3 string = 'South Central US'
param cdn_origin_group_host_header string
param cdn_profile_custom_domain_host_name string
param cdn_profile_endpoint_custom_domain_host_name string
param cdn_profile_endpoint_origin_host_header string = 'magentocdnst.blob.core.windows.net'
param profiles_magento_fd_name string = 'magento-fd'
param servers_db_name string = 'magento-db'
param redisEnterprise_cartdemo1_name string = 'cartdemo1'
param redisEnterprise_cartdemo2_name string = 'cartdemo2'
param profiles_cdn_profile_name string = 'magento-cdn-profile'
param virtualMachine_size string = 'Standard_F4s_v2'
param virtualNetworks_vnet_east_name string = 'vnet-east'
param virtualMachines_east_magento_name string = 'east-magento'
param virtualMachines_west_magento_name string = 'west-magento'
param virtualMachines_admin_username string = 'demoadmin'
param privateEndpoints_db_pe_name string = 'magento-db-pe'
param sshPublicKeys_magento_key_name string = 'magento_key'
param virtualNetworks_vnet_west_name string = 'vnet-west'
param networkInterfaces_east_magento642_name string = 'east-magento642'
param networkInterfaces_west_magento805_name string = 'west-magento805'
param publicIPAddresses_east_magento_ip_name string = 'east-magento-ip'
param publicIPAddresses_west_magento_ip_name string = 'west-magento-ip'
param networkInterfaces_db_pe_nic_name string = 'db-pe-nic'
param storageAccounts_magentocdnst_name string = 'magentocdnst'
param networkInterfaces_magento536_name string = 'magento536'
param publicIPAddresses_magento_ip_name string = 'magento-ip'
param networkSecurityGroups_east_magento_nsg_name string = 'east-magento-nsg'
param networkSecurityGroups_west_magento_nsg_name string = 'west-magento-nsg'
param dnszones_demo_azure_redislabs_com_name string
param networkSecurityGroups_magento_nsg_name string = 'magento-nsg'
param privateEndpoints_cartdemo1_east_pe_name string = 'cartdemo1-east-pe'
param privateEndpoints_cartdemo2_west_pe_name string = 'cartdemo2-west-pe'
param virtualNetworks_vnet_south_central_name string = 'vnet-south-central'
param networkSecurityGroups_magento_west_nsg_name string = 'magento-west-nsg'
param networkInterfaces_cartdemo1_east_pe_nic_name string = 'cartdemo1-east-pe-nic'
param networkInterfaces_cartdemo2_west_pe_nic_name string = 'cartdemo2-west-pe-nic'
param privateDnsZones_privatelink_mariadb_database_azure_com_name string = 'privatelink.mariadb.database.azure.com'
param privateDnsZones_eastus_privatelink_redisenterprise_cache_azure_net_name string = 'eastus.privatelink.redisenterprise.cache.azure.net'
param privateDnsZones_westus_privatelink_redisenterprise_cache_azure_net_name string = 'westus.privatelink.redisenterprise.cache.azure.net'

resource redisEnterprise_cartdemo1_name_resource 'Microsoft.Cache/redisEnterprise@2022-01-01' = {
  name: redisEnterprise_cartdemo1_name
  location: azure_region_1
  sku: {
    name: 'Enterprise_E10'
    capacity: 2
  }
  properties: {
    minimumTlsVersion: '1.2'
  }
}

resource redisEnterprise_cartdemo2_name_resource 'Microsoft.Cache/redisEnterprise@2022-01-01' = {
  name: redisEnterprise_cartdemo2_name
  location: azure_region_2
  sku: {
    name: 'Enterprise_E10'
    capacity: 2
  }
  properties: {
    minimumTlsVersion: '1.2'
  }
}

resource profiles_cdn_profile_name_resource 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: profiles_cdn_profile_name
  location: 'Global'
  sku: {
    name: 'Standard_Microsoft'
  }
  kind: 'cdn'
  properties: {
  }
}

resource profiles_magento_fd_name_resource 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: profiles_magento_fd_name
  location: 'Global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  kind: 'frontdoor'
  properties: {
    originResponseTimeoutSeconds: 60
  }
}

resource sshPublicKeys_magento_key_name_resource 'Microsoft.Compute/sshPublicKeys@2022-03-01' = {
  name: sshPublicKeys_magento_key_name
  location: toLower(replace(azure_region_1, ' ', ''))
  properties: {
    publicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7oFN4dE61IXvXEk3xhjofJRNO\r\nCIfePEAIkXkxqfG+cGsDxyt1QJhnenq6J5MEhgy4PhyqdwLcPjTHpEqTm6qvSSv7\r\nwzlUzTlB8rcqTsA3ff77oh8ZO8Blh1YmfR4s+hPmv95tyGy9SwdZIADt2grb9LPZ\r\n+4MmSCm/tWiBbNeU4WSnAOMuv7AAoe+NuIyuqgNFVcwBfnckVmgRDkDLGd2MB3pk\r\nVykyRJd2sgGWdKiXfyiRRDom5lyPDCBOWQioZE+WfyFiex3/GO5z6U9acrD8Isf8\r\njyemvmkM8U6ChyDu63IxId6/xct8Lwif4eqHFQFHCBX2WFPYu/W5bdpNyH4xPnrS\r\nycP7jlKANwbNgogkBmSoq7XmGS6nmKaL0a157URAyWGVSHzCtPmgnmcEuJHnZNoA\r\n5jK09BMxkYPS8iphEk/155PqkJzaNidr21vfDGtC0rIiEbvfv8cpz/R3fp1ilFCF\r\nJuWlugigqGaIKMlDV4fuBgZJWgqWXieaQBHhKPE= generated-by-azure\r\n'
  }
}

resource servers_db_name_resource 'Microsoft.DBforMariaDB/servers@2018-06-01' = {
  name: servers_db_name
  location: toLower(replace(azure_region_3, ' ', ''))
  sku: {
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 2
  }
  properties: {
    storageProfile: {
      storageMB: 256000
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
      storageAutogrow: 'Enabled'
    }
    version: '10.3'
    sslEnforcement: 'Disabled'
    minimalTlsVersion: 'TLSEnforcementDisabled'
    publicNetworkAccess: 'Enabled'
  }
}

resource dnszones_demo_azure_redislabs_com_name_resource 'Microsoft.Network/dnszones@2018-05-01' = {
  name: dnszones_demo_azure_redislabs_com_name
  location: 'global'
  properties: {
    zoneType: 'Public'
  }
}

resource networkSecurityGroups_east_magento_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_east_magento_nsg_name
  location: toLower(replace(azure_region_1, ' ', ''))
  properties: {
    securityRules: [
      {
        name: 'HTTP'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1010
          direction: 'Inbound'
        }
      }
      {
        name: 'HTTPS'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1020
          direction: 'Inbound'
        }
      }
      {
        name: 'ElasticSearch'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '9200'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1030
          direction: 'Inbound'
        }
      }
      {
        name: 'default-allow-ssh'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1040
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowPort10000'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '10000'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '172.20.0.6'
          access: 'Allow'
          priority: 1050
          direction: 'Outbound'
        }
      }
    ]
  }
}

resource networkSecurityGroups_magento_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_magento_nsg_name
  location: toLower(replace(azure_region_1, ' ', ''))
  properties: {
    securityRules: [
      {
        name: 'HTTP'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1010
          direction: 'Inbound'
        }
      }
      {
        name: 'HTTPS'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1020
          direction: 'Inbound'
        }
      }
      {
        name: 'ElasticSearch'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '9200'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1030
          direction: 'Inbound'
        }
      }
      {
        name: 'default-allow-ssh'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1040
          direction: 'Inbound'
        }
      }
      {
        name: 'Port_8080'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '20.245.194.158'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1050
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource networkSecurityGroups_magento_west_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_magento_west_nsg_name
  location: toLower(replace(azure_region_2, ' ', ''))
  properties: {
    securityRules: [
      {
        name: 'HTTP'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1010
          direction: 'Inbound'
        }
      }
      {
        name: 'HTTPS'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1020
          direction: 'Inbound'
        }
      }
      {
        name: 'ElasticSearch'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '9200'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1030
          direction: 'Inbound'
        }
      }
      {
        name: 'default-allow-ssh'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1040
          direction: 'Inbound'
        }
      }
      {
        name: 'MagentoEast'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '20.228.206.172'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1050
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource networkSecurityGroups_west_magento_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_west_magento_nsg_name
  location: toLower(replace(azure_region_2, ' ', ''))
  properties: {
    securityRules: [
      {
        name: 'HTTP'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1010
          direction: 'Inbound'
        }
      }
      {
        name: 'HTTPS'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1020
          direction: 'Inbound'
        }
      }
      {
        name: 'ElasticSearch'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '9200'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1030
          direction: 'Inbound'
        }
      }
      {
        name: 'default-allow-ssh'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1040
          direction: 'Inbound'
        }
      }
      {
        name: 'Allow_20.25.104.152'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '20.25.104.152'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1050
          direction: 'Inbound'
        }
      }
    ]
  }
}

resource privateDnsZones_eastus_privatelink_redisenterprise_cache_azure_net_name_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDnsZones_eastus_privatelink_redisenterprise_cache_azure_net_name
  location: 'global'
  properties: {
    maxNumberOfRecordSets: 25000
    maxNumberOfVirtualNetworkLinks: 1000
    maxNumberOfVirtualNetworkLinksWithRegistration: 100
    numberOfRecordSets: 2
    numberOfVirtualNetworkLinks: 0
    numberOfVirtualNetworkLinksWithRegistration: 0
    provisioningState: 'Succeeded'
  }
}

resource privateDnsZones_privatelink_mariadb_database_azure_com_name_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDnsZones_privatelink_mariadb_database_azure_com_name
  location: 'global'
  properties: {
    maxNumberOfRecordSets: 25000
    maxNumberOfVirtualNetworkLinks: 1000
    maxNumberOfVirtualNetworkLinksWithRegistration: 100
    numberOfRecordSets: 2
    numberOfVirtualNetworkLinks: 0
    numberOfVirtualNetworkLinksWithRegistration: 0
    provisioningState: 'Succeeded'
  }
}

resource privateDnsZones_westus_privatelink_redisenterprise_cache_azure_net_name_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDnsZones_westus_privatelink_redisenterprise_cache_azure_net_name
  location: 'global'
  properties: {
    maxNumberOfRecordSets: 25000
    maxNumberOfVirtualNetworkLinks: 1000
    maxNumberOfVirtualNetworkLinksWithRegistration: 100
    numberOfRecordSets: 2
    numberOfVirtualNetworkLinks: 0
    numberOfVirtualNetworkLinksWithRegistration: 0
    provisioningState: 'Succeeded'
  }
}

resource publicIPAddresses_east_magento_ip_name_resource 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_east_magento_ip_name
  location: toLower(replace(azure_region_1, ' ', ''))
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.25.104.152'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    dnsSettings: {
      domainNameLabel: 'magento1'
      fqdn: 'magento1.eastus.cloudapp.azure.com'
    }
  }
}

resource publicIPAddresses_magento_ip_name_resource 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_magento_ip_name
  location: toLower(replace(azure_region_1, ' ', ''))
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.228.206.172'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    dnsSettings: {
      domainNameLabel: 'magento-east'
      fqdn: 'magento.eastus.cloudapp.azure.com'
    }
  }
}

resource publicIPAddresses_west_magento_ip_name_resource 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: publicIPAddresses_west_magento_ip_name
  location: toLower(replace(azure_region_2, ' ', ''))
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.245.124.246'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    dnsSettings: {
      domainNameLabel: 'magento-west'
      fqdn: 'magento.westus.cloudapp.azure.com'
    }
  }
}

resource virtualNetworks_vnet_east_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_vnet_east_name
  location: toLower(replace(azure_region_1, ' ', ''))
  properties: {
    addressSpace: {
      addressPrefixes: [
        '172.20.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '172.20.1.0/26'
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'default'
        properties: {
          addressPrefix: '172.20.0.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_south_central_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_vnet_south_central_name
  location: toLower(replace(azure_region_3, ' ', ''))
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.9.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.9.0.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_west_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_vnet_west_name
  location: toLower(replace(azure_region_2, ' ', ''))
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.3.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.3.0.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource storageAccounts_magentocdnst_name_resource 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccounts_magentocdnst_name
  location: toLower(replace(azure_region_1, ' ', ''))
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: false
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource redisEnterprise_cartdemo1_name_redisEnterprise_cartdemo1_name_east_pe 'Microsoft.Cache/redisEnterprise/privateEndpointConnections@2022-01-01' = {
  parent: redisEnterprise_cartdemo1_name_resource
  name: '${redisEnterprise_cartdemo1_name}-east-pe'
  properties: {
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-approved'
      actionsRequired: 'None'
    }
    provisioningState: 'Succeeded'
  }
}

resource redisEnterprise_cartdemo2_name_redisEnterprise_cartdemo2_name_west_pe 'Microsoft.Cache/redisEnterprise/privateEndpointConnections@2022-01-01' = {
  parent: redisEnterprise_cartdemo2_name_resource
  name: '${redisEnterprise_cartdemo2_name}-west-pe'
  properties: {
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-approved'
      actionsRequired: 'None'
    }
    provisioningState: 'Succeeded'
  }
}

resource profiles_magento_fd_name_magento 'Microsoft.Cdn/profiles/afdendpoints@2021-06-01' = {
  parent: profiles_magento_fd_name_resource
  name: 'magento'
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }
}

resource profiles_cdn_profile_name_magento_cdn_endpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' = {
  parent: profiles_cdn_profile_name_resource
  name: 'magento-cdn-endpoint'
  location: 'Global'
  properties: {
    originHostHeader: cdn_profile_endpoint_origin_host_header
    contentTypesToCompress: [
      'application/eot'
      'application/font'
      'application/font-sfnt'
      'application/javascript'
      'application/json'
      'application/opentype'
      'application/otf'
      'application/pkcs7-mime'
      'application/truetype'
      'application/ttf'
      'application/vnd.ms-fontobject'
      'application/xhtml+xml'
      'application/xml'
      'application/xml+rss'
      'application/x-font-opentype'
      'application/x-font-truetype'
      'application/x-font-ttf'
      'application/x-httpd-cgi'
      'application/x-javascript'
      'application/x-mpegurl'
      'application/x-opentype'
      'application/x-otf'
      'application/x-perl'
      'application/x-ttf'
      'font/eot'
      'font/ttf'
      'font/otf'
      'font/opentype'
      'image/svg+xml'
      'text/css'
      'text/csv'
      'text/html'
      'text/javascript'
      'text/js'
      'text/plain'
      'text/richtext'
      'text/tab-separated-values'
      'text/xml'
      'text/x-script'
      'text/x-component'
      'text/x-java-source'
    ]
    isCompressionEnabled: true
    isHttpAllowed: true
    isHttpsAllowed: true
    queryStringCachingBehavior: 'IgnoreQueryString'
    origins: [
      {
        name: 'magentocdnst-blob-core-windows-net'
        properties: {
          hostName: cdn_profile_endpoint_origin_host_header
          priority: 1
          weight: 1000
          enabled: true
        }
      }
    ]
  }
}

resource profiles_magento_fd_name_magento_origin_group 'Microsoft.Cdn/profiles/origingroups@2021-06-01' = {
  parent: profiles_magento_fd_name_resource
  name: 'magento-origin-group'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 100
    }
    sessionAffinityState: 'Disabled'
  }
}

resource profiles_magento_fd_name_1ddb6290_e51e_4800_8d37_550df54ddc57_retail_frontend_demo_azure_redislabs_com 'Microsoft.Cdn/profiles/secrets@2021-06-01' = {
  parent: profiles_magento_fd_name_resource
  name: '1ddb6290-e51e-4800-8d37-550df54ddc57-retail-frontend-demo-azure-redislabs-com'
  properties: {
    parameters: {
      type: 'ManagedCertificate'
    }
  }
}

resource virtualMachines_east_magento_name_resource 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: virtualMachines_east_magento_name
  location: toLower(replace(azure_region_1, ' ', ''))
  plan: {
    name: 'magento-ubuntu'
    product: 'magento-ubuntu'
    publisher: 'cloud-infrastructure-services'
  }
  properties: {
    hardwareProfile: {
      vmSize: virtualMachine_size
    }
    storageProfile: {
      imageReference: {
        publisher: 'cloud-infrastructure-services'
        offer: 'magento-ubuntu'
        sku: 'magento-ubuntu'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_east_magento_name}_OsDisk_1_706a11af157a46ffaa7d145176f04684'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_east_magento_name}_OsDisk_1_706a11af157a46ffaa7d145176f04684')
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
    }
    osProfile: {
      computerName: virtualMachines_east_magento_name
      adminUsername: virtualMachines_admin_username
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${virtualMachines_admin_username}/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7oFN4dE61IXvXEk3xhjofJRNO\r\nCIfePEAIkXkxqfG+cGsDxyt1QJhnenq6J5MEhgy4PhyqdwLcPjTHpEqTm6qvSSv7\r\nwzlUzTlB8rcqTsA3ff77oh8ZO8Blh1YmfR4s+hPmv95tyGy9SwdZIADt2grb9LPZ\r\n+4MmSCm/tWiBbNeU4WSnAOMuv7AAoe+NuIyuqgNFVcwBfnckVmgRDkDLGd2MB3pk\r\nVykyRJd2sgGWdKiXfyiRRDom5lyPDCBOWQioZE+WfyFiex3/GO5z6U9acrD8Isf8\r\njyemvmkM8U6ChyDu63IxId6/xct8Lwif4eqHFQFHCBX2WFPYu/W5bdpNyH4xPnrS\r\nycP7jlKANwbNgogkBmSoq7XmGS6nmKaL0a157URAyWGVSHzCtPmgnmcEuJHnZNoA\r\n5jK09BMxkYPS8iphEk/155PqkJzaNidr21vfDGtC0rIiEbvfv8cpz/R3fp1ilFCF\r\nJuWlugigqGaIKMlDV4fuBgZJWgqWXieaQBHhKPE= generated-by-azure\r\n'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_east_magento642_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
  }
}

resource virtualMachines_west_magento_name_resource 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: virtualMachines_west_magento_name
  location: toLower(replace(azure_region_2, ' ', ''))
  plan: {
    name: 'magento-ubuntu'
    product: 'magento-ubuntu'
    publisher: 'cloud-infrastructure-services'
  }
  properties: {
    hardwareProfile: {
      vmSize: virtualMachine_size
    }
    storageProfile: {
      imageReference: {
        publisher: 'cloud-infrastructure-services'
        offer: 'magento-ubuntu'
        sku: 'magento-ubuntu'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_west_magento_name}_disk1_a91aeaf8213846ceb6c4e3618260ca64'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_west_magento_name}_disk1_a91aeaf8213846ceb6c4e3618260ca64')
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
    }
    osProfile: {
      computerName: virtualMachines_west_magento_name
      adminUsername: virtualMachines_admin_username
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${virtualMachines_admin_username}/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7oFN4dE61IXvXEk3xhjofJRNO\r\nCIfePEAIkXkxqfG+cGsDxyt1QJhnenq6J5MEhgy4PhyqdwLcPjTHpEqTm6qvSSv7\r\nwzlUzTlB8rcqTsA3ff77oh8ZO8Blh1YmfR4s+hPmv95tyGy9SwdZIADt2grb9LPZ\r\n+4MmSCm/tWiBbNeU4WSnAOMuv7AAoe+NuIyuqgNFVcwBfnckVmgRDkDLGd2MB3pk\r\nVykyRJd2sgGWdKiXfyiRRDom5lyPDCBOWQioZE+WfyFiex3/GO5z6U9acrD8Isf8\r\njyemvmkM8U6ChyDu63IxId6/xct8Lwif4eqHFQFHCBX2WFPYu/W5bdpNyH4xPnrS\r\nycP7jlKANwbNgogkBmSoq7XmGS6nmKaL0a157URAyWGVSHzCtPmgnmcEuJHnZNoA\r\n5jK09BMxkYPS8iphEk/155PqkJzaNidr21vfDGtC0rIiEbvfv8cpz/R3fp1ilFCF\r\nJuWlugigqGaIKMlDV4fuBgZJWgqWXieaQBHhKPE= generated-by-azure\r\n'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_west_magento805_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
  }
}

resource virtualMachines_east_magento_name_AzureNetworkWatcherExtension 'Microsoft.Compute/virtualMachines/extensions@2022-03-01' = {
  parent: virtualMachines_east_magento_name_resource
  name: 'AzureNetworkWatcherExtension'
  location: toLower(replace(azure_region_1, ' ', ''))
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.Azure.NetworkWatcher'
    type: 'NetworkWatcherAgentLinux'
    typeHandlerVersion: '1.4'
  }
}

resource servers_db_name_alter_algorithm 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'alter_algorithm'
  properties: {
    value: 'DEFAULT'
    source: 'system-default'
  }
}

resource servers_db_name_audit_log_enabled 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'audit_log_enabled'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_audit_log_events 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'audit_log_events'
  properties: {
    value: 'CONNECTION'
    source: 'system-default'
  }
}

resource servers_db_name_audit_log_exclude_users 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'audit_log_exclude_users'
  properties: {
    value: 'azure_superuser'
    source: 'system-default'
  }
}

resource servers_db_name_audit_log_include_users 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'audit_log_include_users'
  properties: {
    source: 'system-default'
  }
}

resource servers_db_name_auto_increment_increment 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'auto_increment_increment'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_auto_increment_offset 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'auto_increment_offset'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_binlog_row_image 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'binlog_row_image'
  properties: {
    value: 'MINIMAL'
    source: 'system-default'
  }
}

resource servers_db_name_character_set_server 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'character_set_server'
  properties: {
    value: 'LATIN1'
    source: 'system-default'
  }
}

resource servers_db_name_collation_server 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'collation_server'
  properties: {
    value: 'latin1_swedish_ci'
    source: 'system-default'
  }
}

resource servers_db_name_connect_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'connect_timeout'
  properties: {
    value: '10'
    source: 'system-default'
  }
}

resource servers_db_name_default_regex_flags 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'default_regex_flags'
  properties: {
    source: 'system-default'
  }
}

resource servers_db_name_default_week_format 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'default_week_format'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_delayed_insert_limit 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'delayed_insert_limit'
  properties: {
    value: '100'
    source: 'system-default'
  }
}

resource servers_db_name_delayed_insert_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'delayed_insert_timeout'
  properties: {
    value: '300'
    source: 'system-default'
  }
}

resource servers_db_name_delayed_queue_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'delayed_queue_size'
  properties: {
    value: '1000'
    source: 'system-default'
  }
}

resource servers_db_name_dir_cache_enabled 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'dir_cache_enabled'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_div_precision_increment 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'div_precision_increment'
  properties: {
    value: '4'
    source: 'system-default'
  }
}

resource servers_db_name_event_scheduler 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'event_scheduler'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_expensive_subquery_limit 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'expensive_subquery_limit'
  properties: {
    value: '100'
    source: 'system-default'
  }
}

resource servers_db_name_expire_logs_days 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'expire_logs_days'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_explicit_defaults_for_timestamp 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'explicit_defaults_for_timestamp'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_group_concat_max_len 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'group_concat_max_len'
  properties: {
    value: '1048576'
    source: 'system-default'
  }
}

resource servers_db_name_histogram_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'histogram_size'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_histogram_type 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'histogram_type'
  properties: {
    value: 'SINGLE_PREC_HB'
    source: 'system-default'
  }
}

resource servers_db_name_host_cache_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'host_cache_size'
  properties: {
    value: '128'
    source: 'system-default'
  }
}

resource servers_db_name_idle_readonly_transaction_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'idle_readonly_transaction_timeout'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_idle_transaction_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'idle_transaction_timeout'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_idle_write_transaction_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'idle_write_transaction_timeout'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_init_connect 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'init_connect'
  properties: {
    source: 'system-default'
  }
}

resource servers_db_name_innodb_adaptive_flushing 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_adaptive_flushing'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_adaptive_flushing_lwm 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_adaptive_flushing_lwm'
  properties: {
    value: '10'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_adaptive_hash_index 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_adaptive_hash_index'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_adaptive_hash_index_parts 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_adaptive_hash_index_parts'
  properties: {
    value: '8'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_adaptive_max_sleep_delay 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_adaptive_max_sleep_delay'
  properties: {
    value: '150000'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_autoextend_increment 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_autoextend_increment'
  properties: {
    value: '64'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_autoinc_lock_mode 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_autoinc_lock_mode'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_buffer_pool_dump_at_shutdown 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_buffer_pool_dump_at_shutdown'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_buffer_pool_dump_pct 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_buffer_pool_dump_pct'
  properties: {
    value: '25'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_buffer_pool_load_at_startup 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_buffer_pool_load_at_startup'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_buffer_pool_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_buffer_pool_size'
  properties: {
    value: '7516192768'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_change_buffer_max_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_change_buffer_max_size'
  properties: {
    value: '25'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_change_buffering 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_change_buffering'
  properties: {
    value: 'all'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_cmp_per_index_enabled 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_cmp_per_index_enabled'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_compression_failure_threshold_pct 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_compression_failure_threshold_pct'
  properties: {
    value: '5'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_compression_level 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_compression_level'
  properties: {
    value: '6'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_compression_pad_pct_max 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_compression_pad_pct_max'
  properties: {
    value: '50'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_concurrency_tickets 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_concurrency_tickets'
  properties: {
    value: '5000'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_deadlock_detect 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_deadlock_detect'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_default_row_format 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_default_row_format'
  properties: {
    value: 'dynamic'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_file_per_table 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_file_per_table'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_fill_factor 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_fill_factor'
  properties: {
    value: '100'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_flush_log_at_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_flush_log_at_timeout'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_ft_cache_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_ft_cache_size'
  properties: {
    value: '8000000'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_ft_enable_stopword 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_ft_enable_stopword'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_ft_num_word_optimize 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_ft_num_word_optimize'
  properties: {
    value: '2000'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_ft_result_cache_limit 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_ft_result_cache_limit'
  properties: {
    value: '2000000000'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_ft_server_stopword_table 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_ft_server_stopword_table'
  properties: {
    source: 'system-default'
  }
}

resource servers_db_name_innodb_ft_total_cache_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_ft_total_cache_size'
  properties: {
    value: '640000000'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_io_capacity 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_io_capacity'
  properties: {
    value: '200'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_lock_wait_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_lock_wait_timeout'
  properties: {
    value: '50'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_log_compressed_pages 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_log_compressed_pages'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_lru_scan_depth 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_lru_scan_depth'
  properties: {
    value: '1024'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_max_dirty_pages_pct 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_max_dirty_pages_pct'
  properties: {
    value: '75'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_max_dirty_pages_pct_lwm 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_max_dirty_pages_pct_lwm'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_max_purge_lag 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_max_purge_lag'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_max_purge_lag_delay 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_max_purge_lag_delay'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_max_undo_log_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_max_undo_log_size'
  properties: {
    value: '10485760'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_old_blocks_pct 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_old_blocks_pct'
  properties: {
    value: '37'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_old_blocks_time 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_old_blocks_time'
  properties: {
    value: '1000'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_online_alter_log_max_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_online_alter_log_max_size'
  properties: {
    value: '134217728'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_open_files 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_open_files'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_optimize_fulltext_only 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_optimize_fulltext_only'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_page_cleaners 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_page_cleaners'
  properties: {
    value: '2'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_purge_batch_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_purge_batch_size'
  properties: {
    value: '300'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_purge_rseg_truncate_frequency 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_purge_rseg_truncate_frequency'
  properties: {
    value: '128'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_random_read_ahead 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_random_read_ahead'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_read_ahead_threshold 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_read_ahead_threshold'
  properties: {
    value: '56'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_read_io_threads 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_read_io_threads'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_stats_auto_recalc 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_stats_auto_recalc'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_stats_include_delete_marked 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_stats_include_delete_marked'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_stats_method 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_stats_method'
  properties: {
    value: 'nulls_equal'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_stats_modified_counter 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_stats_modified_counter'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_stats_on_metadata 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_stats_on_metadata'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_stats_persistent 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_stats_persistent'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_stats_persistent_sample_pages 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_stats_persistent_sample_pages'
  properties: {
    value: '20'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_stats_traditional 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_stats_traditional'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_stats_transient_sample_pages 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_stats_transient_sample_pages'
  properties: {
    value: '8'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_status_output 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_status_output'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_status_output_locks 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_status_output_locks'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_strict_mode 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_strict_mode'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_sync_array_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_sync_array_size'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_table_locks 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_table_locks'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_thread_concurrency 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_thread_concurrency'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_thread_sleep_delay 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_thread_sleep_delay'
  properties: {
    value: '10000'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_undo_log_truncate 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_undo_log_truncate'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_innodb_write_io_threads 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'innodb_write_io_threads'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_interactive_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'interactive_timeout'
  properties: {
    value: '1800'
    source: 'system-default'
  }
}

resource servers_db_name_join_buffer_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'join_buffer_size'
  properties: {
    value: '262144'
    source: 'system-default'
  }
}

resource servers_db_name_join_cache_level 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'join_cache_level'
  properties: {
    value: '2'
    source: 'system-default'
  }
}

resource servers_db_name_local_infile 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'local_infile'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_lock_wait_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'lock_wait_timeout'
  properties: {
    value: '86400'
    source: 'system-default'
  }
}

resource servers_db_name_log_bin_trust_function_creators 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'log_bin_trust_function_creators'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_log_output 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'log_output'
  properties: {
    value: 'FILE'
    source: 'system-default'
  }
}

resource servers_db_name_log_queries_not_using_indexes 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'log_queries_not_using_indexes'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_log_slow_admin_statements 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'log_slow_admin_statements'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_log_slow_disabled_statements 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'log_slow_disabled_statements'
  properties: {
    value: 'sp'
    source: 'system-default'
  }
}

resource servers_db_name_log_slow_filter 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'log_slow_filter'
  properties: {
    value: 'admin,filesort,filesort_on_disk,filesort_priority_queue,full_join,full_scan,query_cache,query_cache_miss,tmp_table,tmp_table_on_disk'
    source: 'system-default'
  }
}

resource servers_db_name_log_slow_rate_limit 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'log_slow_rate_limit'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_log_slow_verbosity 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'log_slow_verbosity'
  properties: {
    source: 'system-default'
  }
}

resource servers_db_name_long_query_time 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'long_query_time'
  properties: {
    value: '10'
    source: 'system-default'
  }
}

resource servers_db_name_low_priority_updates 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'low_priority_updates'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_lower_case_table_names 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'lower_case_table_names'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_max_allowed_packet 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_allowed_packet'
  properties: {
    value: '536870912'
    source: 'system-default'
  }
}

resource servers_db_name_max_connect_errors 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_connect_errors'
  properties: {
    value: '100'
    source: 'system-default'
  }
}

resource servers_db_name_max_connections 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_connections'
  properties: {
    value: '300'
    source: 'system-default'
  }
}

resource servers_db_name_max_delayed_threads 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_delayed_threads'
  properties: {
    value: '20'
    source: 'system-default'
  }
}

resource servers_db_name_max_digest_length 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_digest_length'
  properties: {
    value: '1024'
    source: 'system-default'
  }
}

resource servers_db_name_max_error_count 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_error_count'
  properties: {
    value: '64'
    source: 'system-default'
  }
}

resource servers_db_name_max_heap_table_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_heap_table_size'
  properties: {
    value: '16777216'
    source: 'system-default'
  }
}

resource servers_db_name_max_join_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_join_size'
  properties: {
    value: '18446744073709547520'
    source: 'system-default'
  }
}

resource servers_db_name_max_length_for_sort_data 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_length_for_sort_data'
  properties: {
    value: '1024'
    source: 'system-default'
  }
}

resource servers_db_name_max_prepared_stmt_count 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_prepared_stmt_count'
  properties: {
    value: '16382'
    source: 'system-default'
  }
}

resource servers_db_name_max_recursive_iterations 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_recursive_iterations'
  properties: {
    value: '4294967295'
    source: 'system-default'
  }
}

resource servers_db_name_max_seeks_for_key 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_seeks_for_key'
  properties: {
    value: '4294967295'
    source: 'system-default'
  }
}

resource servers_db_name_max_session_mem_used 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_session_mem_used'
  properties: {
    value: '9223372036854775807 '
    source: 'system-default'
  }
}

resource servers_db_name_max_sort_length 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_sort_length'
  properties: {
    value: '1024'
    source: 'system-default'
  }
}

resource servers_db_name_max_sp_recursion_depth 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_sp_recursion_depth'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_max_user_connections 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_user_connections'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_max_write_lock_count 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'max_write_lock_count'
  properties: {
    value: '4294967295'
    source: 'system-default'
  }
}

resource servers_db_name_min_examined_row_limit 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'min_examined_row_limit'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_net_read_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'net_read_timeout'
  properties: {
    value: '120'
    source: 'system-default'
  }
}

resource servers_db_name_net_retry_count 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'net_retry_count'
  properties: {
    value: '10'
    source: 'system-default'
  }
}

resource servers_db_name_net_write_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'net_write_timeout'
  properties: {
    value: '240'
    source: 'system-default'
  }
}

resource servers_db_name_optimizer_search_depth 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'optimizer_search_depth'
  properties: {
    value: '62'
    source: 'system-default'
  }
}

resource servers_db_name_optimizer_selectivity_sampling_limit 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'optimizer_selectivity_sampling_limit'
  properties: {
    value: '100'
    source: 'system-default'
  }
}

resource servers_db_name_optimizer_switch 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'optimizer_switch'
  properties: {
    value: 'default'
    source: 'system-default'
  }
}

resource servers_db_name_optimizer_use_condition_selectivity 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'optimizer_use_condition_selectivity'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_preload_buffer_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'preload_buffer_size'
  properties: {
    value: '32768'
    source: 'system-default'
  }
}

resource servers_db_name_query_cache_limit 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'query_cache_limit'
  properties: {
    value: '1048576'
    source: 'system-default'
  }
}

resource servers_db_name_query_cache_min_res_unit 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'query_cache_min_res_unit'
  properties: {
    value: '4096'
    source: 'system-default'
  }
}

resource servers_db_name_query_cache_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'query_cache_size'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_query_cache_strip_comments 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'query_cache_strip_comments'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_query_cache_type 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'query_cache_type'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_query_prealloc_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'query_prealloc_size'
  properties: {
    value: '24576'
    source: 'system-default'
  }
}

resource servers_db_name_range_alloc_block_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'range_alloc_block_size'
  properties: {
    value: '4096'
    source: 'system-default'
  }
}

resource servers_db_name_read_only 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'read_only'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_redirect_enabled 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'redirect_enabled'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_replicate_wild_ignore_table 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'replicate_wild_ignore_table'
  properties: {
    value: 'mysql.%,information_schema.%,performance_schema.%'
    source: 'system-default'
  }
}

resource servers_db_name_server_id 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'server_id'
  properties: {
    value: '1621538945'
    source: 'user-override'
  }
}

resource servers_db_name_session_track_schema 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'session_track_schema'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_session_track_state_change 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'session_track_state_change'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_session_track_transaction_info 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'session_track_transaction_info'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_skip_show_database 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'skip_show_database'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_slave_net_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'slave_net_timeout'
  properties: {
    value: '60'
    source: 'system-default'
  }
}

resource servers_db_name_slave_parallel_threads 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'slave_parallel_threads'
  properties: {
    value: '0'
    source: 'system-default'
  }
}

resource servers_db_name_slow_query_log 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'slow_query_log'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_sort_buffer_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'sort_buffer_size'
  properties: {
    value: '524288'
    source: 'system-default'
  }
}

resource servers_db_name_sql_mode 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'sql_mode'
  properties: {
    value: 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'
    source: 'system-default'
  }
}

resource servers_db_name_standard_compliant_cte 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'standard_compliant_cte'
  properties: {
    value: 'ON'
    source: 'system-default'
  }
}

resource servers_db_name_stored_program_cache 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'stored_program_cache'
  properties: {
    value: '256'
    source: 'system-default'
  }
}

resource servers_db_name_sync_master_info 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'sync_master_info'
  properties: {
    value: '10000'
    source: 'system-default'
  }
}

resource servers_db_name_sync_relay_log_info 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'sync_relay_log_info'
  properties: {
    value: '10000'
    source: 'system-default'
  }
}

resource servers_db_name_table_definition_cache 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'table_definition_cache'
  properties: {
    value: '400'
    source: 'system-default'
  }
}

resource servers_db_name_table_open_cache 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'table_open_cache'
  properties: {
    value: '2400'
    source: 'system-default'
  }
}

resource servers_db_name_table_open_cache_instances 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'table_open_cache_instances'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_thread_cache_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'thread_cache_size'
  properties: {
    value: '256'
    source: 'system-default'
  }
}

resource servers_db_name_thread_pool_max_threads 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'thread_pool_max_threads'
  properties: {
    value: '65536'
    source: 'system-default'
  }
}

resource servers_db_name_thread_pool_min_threads 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'thread_pool_min_threads'
  properties: {
    value: '1'
    source: 'system-default'
  }
}

resource servers_db_name_thread_pool_prio_kickup_timer 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'thread_pool_prio_kickup_timer'
  properties: {
    value: '1000'
    source: 'system-default'
  }
}

resource servers_db_name_thread_pool_priority 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'thread_pool_priority'
  properties: {
    value: 'auto'
    source: 'system-default'
  }
}

resource servers_db_name_thread_pool_stall_limit 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'thread_pool_stall_limit'
  properties: {
    value: '500'
    source: 'system-default'
  }
}

resource servers_db_name_thread_stack 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'thread_stack'
  properties: {
    value: '299008'
    source: 'system-default'
  }
}

resource servers_db_name_time_zone 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'time_zone'
  properties: {
    value: 'SYSTEM'
    source: 'system-default'
  }
}

resource servers_db_name_tmp_table_size 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'tmp_table_size'
  properties: {
    value: '16777216'
    source: 'system-default'
  }
}

resource servers_db_name_tx_isolation 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'tx_isolation'
  properties: {
    value: 'REPEATABLE-READ'
    source: 'system-default'
  }
}

resource servers_db_name_updatable_views_with_limit 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'updatable_views_with_limit'
  properties: {
    value: 'YES'
    source: 'system-default'
  }
}

resource servers_db_name_use_stat_tables 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'use_stat_tables'
  properties: {
    value: 'NEVER'
    source: 'system-default'
  }
}

resource servers_db_name_userstat 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'userstat'
  properties: {
    value: 'OFF'
    source: 'system-default'
  }
}

resource servers_db_name_wait_timeout 'Microsoft.DBforMariaDB/servers/configurations@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'wait_timeout'
  properties: {
    value: '180'
    source: 'system-default'
  }
}

resource servers_db_name_aria_log_control 'Microsoft.DBforMariaDB/servers/databases@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'aria_log_control'
  properties: {
    charset: 'latin1'
    collation: 'latin1_swedish_ci'
  }
}

resource servers_db_name_information_schema 'Microsoft.DBforMariaDB/servers/databases@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'information_schema'
  properties: {
    charset: 'utf8'
    collation: 'utf8_general_ci'
  }
}

resource servers_db_name_magento2 'Microsoft.DBforMariaDB/servers/databases@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'magento2'
  properties: {
    charset: 'latin1'
    collation: 'latin1_swedish_ci'
  }
}

resource servers_db_name_mysql 'Microsoft.DBforMariaDB/servers/databases@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'mysql'
  properties: {
    charset: 'latin1'
    collation: 'latin1_swedish_ci'
  }
}

resource servers_db_name_performance_schema 'Microsoft.DBforMariaDB/servers/databases@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'performance_schema'
  properties: {
    charset: 'utf8'
    collation: 'utf8_general_ci'
  }
}

resource servers_db_name_east 'Microsoft.DBforMariaDB/servers/firewallRules@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'east'
  properties: {
    startIpAddress: '20.25.104.152'
    endIpAddress: '20.25.104.152'
  }
}

resource servers_db_name_roberto 'Microsoft.DBforMariaDB/servers/firewallRules@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'roberto'
  properties: {
    startIpAddress: '68.205.197.144'
    endIpAddress: '68.205.197.144'
  }
}

resource servers_db_name_west 'Microsoft.DBforMariaDB/servers/firewallRules@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'west'
  properties: {
    startIpAddress: '20.245.124.246'
    endIpAddress: '20.245.124.246'
  }
}

resource servers_db_name_Default 'Microsoft.DBforMariaDB/servers/securityAlertPolicies@2018-06-01' = {
  parent: servers_db_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
}

resource dnszones_demo_azure_redislabs_com_name_retail 'Microsoft.Network/dnszones/A@2018-05-01' = {
  parent: dnszones_demo_azure_redislabs_com_name_resource
  name: 'retail'
  properties: {
    TTL: 60
    ARecords: [
      {
        ipv4Address: '20.25.104.152'
      }
    ]
  }
}

resource dnszones_demo_azure_redislabs_com_name_cdnverify_magento_cdn 'Microsoft.Network/dnszones/CNAME@2018-05-01' = {
  parent: dnszones_demo_azure_redislabs_com_name_resource
  name: 'cdnverify.magento-cdn'
  properties: {
    TTL: 3600
    CNAMERecord: {
      cname: 'cdnverify.magento-cdn-endpoint.azureedge.net'
    }
  }
}

resource dnszones_demo_azure_redislabs_com_name_retail_frontend 'Microsoft.Network/dnszones/CNAME@2018-05-01' = {
  parent: dnszones_demo_azure_redislabs_com_name_resource
  name: 'retail-frontend'
  properties: {
    TTL: 3600
    CNAMERecord: {
      cname: 'magento-gue5g5b7abf8bpap.z01.azurefd.net'
    }
  }
}

resource Microsoft_Network_dnszones_NS_dnszones_demo_azure_redislabs_com_name 'Microsoft.Network/dnszones/NS@2018-05-01' = {
  parent: dnszones_demo_azure_redislabs_com_name_resource
  name: '@'
  properties: {
    TTL: 172800
    NSRecords: [
      {
        nsdname: 'ns1-06.azure-dns.com.'
      }
      {
        nsdname: 'ns2-06.azure-dns.net.'
      }
      {
        nsdname: 'ns3-06.azure-dns.org.'
      }
      {
        nsdname: 'ns4-06.azure-dns.info.'
      }
    ]
  }
}

resource Microsoft_Network_dnszones_SOA_dnszones_demo_azure_redislabs_com_name 'Microsoft.Network/dnszones/SOA@2018-05-01' = {
  parent: dnszones_demo_azure_redislabs_com_name_resource
  name: '@'
  properties: {
    TTL: 3600
    SOARecord: {
      email: 'azuredns-hostmaster.microsoft.com'
      expireTime: 2419200
      host: 'ns1-06.azure-dns.com.'
      minimumTTL: 300
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource dnszones_demo_azure_redislabs_com_name_dnsauth_retail_frontend 'Microsoft.Network/dnszones/TXT@2018-05-01' = {
  parent: dnszones_demo_azure_redislabs_com_name_resource
  name: '_dnsauth.retail-frontend'
  properties: {
    TTL: 3600
    TXTRecords: [
      {
        value: [
          '7g8fxknl8zwt5sn76hxk9dx7cwbhdw1t'
        ]
      }
    ]
  }
}

resource networkInterfaces_cartdemo1_east_pe_nic_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_cartdemo1_east_pe_nic_name
  location: toLower(replace(azure_region_1, ' ', ''))
  properties: {
    ipConfigurations: [
      {
        name: 'privateEndpointIpConfig.4d0955af-3015-4222-8c5e-911db73a45d5'
        properties: {
          privateIPAddress: '172.20.0.6'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_east_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}

resource networkInterfaces_cartdemo2_west_pe_nic_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_cartdemo2_west_pe_nic_name
  location: toLower(replace(azure_region_2, ' ', ''))
  properties: {
    ipConfigurations: [
      {
        name: 'privateEndpointIpConfig.833f619b-de7b-4b77-9b5c-bbe668f578d8'
        properties: {
          privateIPAddress: '10.3.0.5'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_west_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    enableIPForwarding: false
  }
}

resource networkInterfaces_db_pe_nic_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_db_pe_nic_name
  location: toLower(replace(azure_region_3, ' ', ''))
  properties: {
    ipConfigurations: [
      {
        name: 'privateEndpointIpConfig.501b2122-e112-4b46-ada0-322c50ac3a46'
        properties: {
          privateIPAddress: '10.9.0.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_south_central_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}

resource networkSecurityGroups_west_magento_nsg_name_Allow_20_25_104_152 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_west_magento_nsg_name_resource
  name: 'Allow_20.25.104.152'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '20.25.104.152'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1050
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_east_magento_nsg_name_AllowPort10000 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_east_magento_nsg_name_resource
  name: 'AllowPort10000'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '10000'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '172.20.0.6'
    access: 'Allow'
    priority: 1050
    direction: 'Outbound'
  }
}

resource networkSecurityGroups_east_magento_nsg_name_default_allow_ssh 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_east_magento_nsg_name_resource
  name: 'default-allow-ssh'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1040
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_magento_nsg_name_default_allow_ssh 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_magento_nsg_name_resource
  name: 'default-allow-ssh'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1040
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_magento_west_nsg_name_default_allow_ssh 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_magento_west_nsg_name_resource
  name: 'default-allow-ssh'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1040
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_west_magento_nsg_name_default_allow_ssh 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_west_magento_nsg_name_resource
  name: 'default-allow-ssh'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1040
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_east_magento_nsg_name_ElasticSearch 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_east_magento_nsg_name_resource
  name: 'ElasticSearch'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '9200'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1030
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_magento_nsg_name_ElasticSearch 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_magento_nsg_name_resource
  name: 'ElasticSearch'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '9200'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1030
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_magento_west_nsg_name_ElasticSearch 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_magento_west_nsg_name_resource
  name: 'ElasticSearch'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '9200'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1030
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_west_magento_nsg_name_ElasticSearch 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_west_magento_nsg_name_resource
  name: 'ElasticSearch'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '9200'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1030
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_east_magento_nsg_name_HTTP 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_east_magento_nsg_name_resource
  name: 'HTTP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1010
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_magento_nsg_name_HTTP 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_magento_nsg_name_resource
  name: 'HTTP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1010
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_magento_west_nsg_name_HTTP 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_magento_west_nsg_name_resource
  name: 'HTTP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1010
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_west_magento_nsg_name_HTTP 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_west_magento_nsg_name_resource
  name: 'HTTP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1010
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_east_magento_nsg_name_HTTPS 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_east_magento_nsg_name_resource
  name: 'HTTPS'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1020
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_magento_nsg_name_HTTPS 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_magento_nsg_name_resource
  name: 'HTTPS'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1020
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_magento_west_nsg_name_HTTPS 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_magento_west_nsg_name_resource
  name: 'HTTPS'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1020
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_west_magento_nsg_name_HTTPS 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_west_magento_nsg_name_resource
  name: 'HTTPS'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1020
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_magento_west_nsg_name_MagentoEast 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_magento_west_nsg_name_resource
  name: 'MagentoEast'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '20.228.206.172'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1050
    direction: 'Inbound'
  }
}

resource networkSecurityGroups_magento_nsg_name_Port_8080 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_magento_nsg_name_resource
  name: 'Port_8080'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '20.245.194.158'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1050
    direction: 'Inbound'
  }
}

resource privateDnsZones_eastus_privatelink_redisenterprise_cache_azure_net_name_cartdemo1 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_eastus_privatelink_redisenterprise_cache_azure_net_name_resource
  name: 'cartdemo1'
  properties: {
    ttl: 10
    aRecords: [
      {
        ipv4Address: '172.20.0.6'
      }
    ]
  }
}

resource privateDnsZones_westus_privatelink_redisenterprise_cache_azure_net_name_cartdemo2 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_westus_privatelink_redisenterprise_cache_azure_net_name_resource
  name: 'cartdemo2'
  properties: {
    ttl: 10
    aRecords: [
      {
        ipv4Address: '10.3.0.5'
      }
    ]
  }
}

resource privateDnsZones_privatelink_mariadb_database_azure_com_name_db 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_privatelink_mariadb_database_azure_com_name_resource
  name: 'db'
  properties: {
    metadata: {
      creator: 'created by private endpoint db-pe with resource guid 6bf6e876-97b5-412f-8ed0-fa8da05d81bf'
    }
    ttl: 10
    aRecords: [
      {
        ipv4Address: '10.9.0.4'
      }
    ]
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_eastus_privatelink_redisenterprise_cache_azure_net_name 'Microsoft.Network/privateDnsZones/SOA@2018-09-01' = {
  parent: privateDnsZones_eastus_privatelink_redisenterprise_cache_azure_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_mariadb_database_azure_com_name 'Microsoft.Network/privateDnsZones/SOA@2018-09-01' = {
  parent: privateDnsZones_privatelink_mariadb_database_azure_com_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_westus_privatelink_redisenterprise_cache_azure_net_name 'Microsoft.Network/privateDnsZones/SOA@2018-09-01' = {
  parent: privateDnsZones_westus_privatelink_redisenterprise_cache_azure_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource virtualNetworks_vnet_east_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_east_name_resource
  name: 'AzureBastionSubnet'
  properties: {
    addressPrefix: '172.20.1.0/26'
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_east_name_default 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_east_name_resource
  name: 'default'
  properties: {
    addressPrefix: '172.20.0.0/24'
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_south_central_name_default 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_south_central_name_resource
  name: 'default'
  properties: {
    addressPrefix: '10.9.0.0/24'
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_west_name_default 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_west_name_resource
  name: 'default'
  properties: {
    addressPrefix: '10.3.0.0/24'
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource storageAccounts_magentocdnst_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: storageAccounts_magentocdnst_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_magentocdnst_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-09-01' = {
  parent: storageAccounts_magentocdnst_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_magentocdnst_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-09-01' = {
  parent: storageAccounts_magentocdnst_name_resource
  name: 'default'
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_magentocdnst_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-09-01' = {
  parent: storageAccounts_magentocdnst_name_resource
  name: 'default'
}

resource redisEnterprise_cartdemo1_name_default 'Microsoft.Cache/redisEnterprise/databases@2022-01-01' = {
  parent: redisEnterprise_cartdemo1_name_resource
  name: 'default'
  properties: {
    clientProtocol: 'Encrypted'
    port: 10000
    clusteringPolicy: 'EnterpriseCluster'
    evictionPolicy: 'NoEviction'
    persistence: {
      aofEnabled: false
      rdbEnabled: false
    }
    geoReplication: {
      linkedDatabases: [
        {
          id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Cache/redisEnterprise/${redisEnterprise_cartdemo1_name_resource.name}/databases/default'
        }
        {
          id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Cache/redisEnterprise/${redisEnterprise_cartdemo2_name_resource.name}/databases/default'
        }
      ]
      groupNickname: 'cartdemo'
    }
  }
}

resource redisEnterprise_cartdemo2_name_default 'Microsoft.Cache/redisEnterprise/databases@2022-01-01' = {
  parent: redisEnterprise_cartdemo2_name_resource
  name: 'default'
  properties: {
    clientProtocol: 'Encrypted'
    port: 10000
    clusteringPolicy: 'EnterpriseCluster'
    evictionPolicy: 'NoEviction'
    geoReplication: {
      linkedDatabases: [
        {
          id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Cache/redisEnterprise/${redisEnterprise_cartdemo1_name_resource.name}/databases/default'
        }
        {
          id: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Cache/redisEnterprise/${redisEnterprise_cartdemo2_name_resource.name}/databases/default'
        }
      ]
      groupNickname: 'cartdemo'
    }
  }
}

resource profiles_cdn_profile_name_magento_cdn_endpoint_magento_cdn_demo_azure_redislabs_com 'Microsoft.Cdn/profiles/endpoints/customdomains@2021-06-01' = {
  parent: profiles_cdn_profile_name_magento_cdn_endpoint
  name: 'magento-cdn-demo-azure-redislabs-com'
  properties: {
    hostName: cdn_profile_endpoint_custom_domain_host_name
  }
  dependsOn: [

    profiles_cdn_profile_name_resource
  ]
}

resource profiles_cdn_profile_name_magento_cdn_endpoint_magentocdnst_blob_core_windows_net 'Microsoft.Cdn/profiles/endpoints/origins@2021-06-01' = {
  parent: profiles_cdn_profile_name_magento_cdn_endpoint
  name: 'magentocdnst-blob-core-windows-net'
  properties: {
    hostName: cdn_profile_endpoint_origin_host_header
    priority: 1
    weight: 1000
    enabled: true
  }
  dependsOn: [

    profiles_cdn_profile_name_resource
  ]
}

resource profiles_magento_fd_name_magento_origin_group_magento_east 'Microsoft.Cdn/profiles/origingroups/origins@2021-06-01' = {
  parent: profiles_magento_fd_name_magento_origin_group
  name: 'magento-east'
  properties: {
    hostName: '20.25.104.152'
    httpPort: 80
    httpsPort: 443
    originHostHeader: cdn_origin_group_host_header
    priority: 1
    weight: 100
    enabledState: 'Enabled'
    enforceCertificateNameCheck: false
  }
  dependsOn: [

    profiles_magento_fd_name_resource
  ]
}

resource profiles_magento_fd_name_magento_origin_group_magento_west 'Microsoft.Cdn/profiles/origingroups/origins@2021-06-01' = {
  parent: profiles_magento_fd_name_magento_origin_group
  name: 'magento-west'
  properties: {
    hostName: '20.245.124.246'
    httpPort: 80
    httpsPort: 443
    originHostHeader: cdn_origin_group_host_header
    priority: 1
    weight: 100
    enabledState: 'Enabled'
    enforceCertificateNameCheck: false
  }
  dependsOn: [

    profiles_magento_fd_name_resource
  ]
}

resource servers_db_name_servers_db_name_pe_cb54eae1_b98b_44d1_a580_07309ed7b273 'Microsoft.DBforMariaDB/servers/privateEndpointConnections@2018-06-01' = {
  parent: servers_db_name_resource
  name: '${servers_db_name}-pe-cb54eae1-b98b-44d1-a580-07309ed7b273'
  properties: {
    privateEndpoint: {
      id: privateEndpoints_db_pe_name_resource.id
    }
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-approved'
    }
  }
}

resource dnszones_demo_azure_redislabs_com_name_magento_cdn 'Microsoft.Network/dnszones/CNAME@2018-05-01' = {
  parent: dnszones_demo_azure_redislabs_com_name_resource
  name: 'magento-cdn'
  properties: {
    TTL: 30
    targetResource: {
      id: profiles_cdn_profile_name_magento_cdn_endpoint.id
    }
  }
}

resource privateDnsZones_westus_privatelink_redisenterprise_cache_azure_net_name_clc3aao4f75um 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones_westus_privatelink_redisenterprise_cache_azure_net_name_resource
  name: 'clc3aao4f75um'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworks_vnet_west_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_mariadb_database_azure_com_name_kpje5bruc3aui 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones_privatelink_mariadb_database_azure_com_name_resource
  name: 'kpje5bruc3aui'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworks_vnet_south_central_name_resource.id
    }
  }
}

resource privateDnsZones_eastus_privatelink_redisenterprise_cache_azure_net_name_lkaatcv5uc4so 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2018-09-01' = {
  parent: privateDnsZones_eastus_privatelink_redisenterprise_cache_azure_net_name_resource
  name: 'lkaatcv5uc4so'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworks_vnet_east_name_resource.id
    }
  }
}

resource privateEndpoints_cartdemo1_east_pe_name_resource 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: privateEndpoints_cartdemo1_east_pe_name
  location: toLower(replace(azure_region_1, ' ', ''))
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_cartdemo1_east_pe_name
        properties: {
          privateLinkServiceId: redisEnterprise_cartdemo1_name_resource.id
          groupIds: [
            'redisEnterprise'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    subnet: {
      id: virtualNetworks_vnet_east_name_default.id
    }
    customDnsConfigs: [
      {
        fqdn: 'cartdemo1.eastus.redisenterprise.cache.azure.net'
        ipAddresses: [
          '172.20.0.6'
        ]
      }
    ]
  }
}

resource privateEndpoints_cartdemo2_west_pe_name_resource 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: privateEndpoints_cartdemo2_west_pe_name
  location: toLower(replace(azure_region_2, ' ', ''))
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_cartdemo2_west_pe_name
        properties: {
          privateLinkServiceId: redisEnterprise_cartdemo2_name_resource.id
          groupIds: [
            'redisEnterprise'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    subnet: {
      id: virtualNetworks_vnet_west_name_default.id
    }
    customDnsConfigs: [
      {
        fqdn: 'cartdemo2.westus.redisenterprise.cache.azure.net'
        ipAddresses: [
          '10.3.0.5'
        ]
      }
    ]
  }
}

resource privateEndpoints_db_pe_name_resource 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: privateEndpoints_db_pe_name
  location: toLower(replace(azure_region_3, ' ', ''))
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_db_pe_name
        properties: {
          privateLinkServiceId: servers_db_name_resource.id
          groupIds: [
            'mariadbServer'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    subnet: {
      id: virtualNetworks_vnet_south_central_name_default.id
    }
  }
}

resource privateEndpoints_cartdemo1_east_pe_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = {
  parent: privateEndpoints_cartdemo1_east_pe_name_resource
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'eastus-privatelink-redisenterprise-cache-azure-net'
        properties: {
          privateDnsZoneId: privateDnsZones_eastus_privatelink_redisenterprise_cache_azure_net_name_resource.id
        }
      }
    ]
  }
}

resource privateEndpoints_cartdemo2_west_pe_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = {
  parent: privateEndpoints_cartdemo2_west_pe_name_resource
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'westus-privatelink-redisenterprise-cache-azure-net'
        properties: {
          privateDnsZoneId: privateDnsZones_westus_privatelink_redisenterprise_cache_azure_net_name_resource.id
        }
      }
    ]
  }
}

resource privateEndpoints_db_pe_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2020-11-01' = {
  parent: privateEndpoints_db_pe_name_resource
  name: 'default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-mariadb-database-azure-com'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_mariadb_database_azure_com_name_resource.id
        }
      }
    ]
  }
}

resource storageAccounts_magentocdnst_name_default_magento 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: storageAccounts_magentocdnst_name_default
  name: 'magento'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'Container'
  }
  dependsOn: [

    storageAccounts_magentocdnst_name_resource
  ]
}

resource profiles_magento_fd_name_retail_frontend_demo_azure_redislabs_com 'Microsoft.Cdn/profiles/customdomains@2021-06-01' = {
  parent: profiles_magento_fd_name_resource
  name: 'retail-frontend-demo-azure-redislabs-com'
  properties: {
    hostName: cdn_profile_custom_domain_host_name
    tlsSettings: {
      certificateType: 'ManagedCertificate'
      minimumTlsVersion: 'TLS12'
      secret: {
        id: profiles_magento_fd_name_1ddb6290_e51e_4800_8d37_550df54ddc57_retail_frontend_demo_azure_redislabs_com.id
      }
    }
    azureDnsZone: {
      id: dnszones_demo_azure_redislabs_com_name_resource.id
    }
  }
}

resource networkInterfaces_east_magento642_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_east_magento642_name
  location: toLower(replace(azure_region_1, ' ', ''))
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '172.20.0.5'
          privateIPAllocationMethod: 'Static'
          publicIPAddress: {
            id: publicIPAddresses_east_magento_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_vnet_east_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    networkSecurityGroup: {
      id: networkSecurityGroups_east_magento_nsg_name_resource.id
    }
  }
}

resource networkInterfaces_magento536_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_magento536_name
  location: toLower(replace(azure_region_1, ' ', ''))
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '172.20.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_magento_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_vnet_east_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    networkSecurityGroup: {
      id: networkSecurityGroups_magento_nsg_name_resource.id
    }
  }
}

resource networkInterfaces_west_magento805_name_resource 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: networkInterfaces_west_magento805_name
  location: toLower(replace(azure_region_2, ' ', ''))
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAddress: '10.3.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_west_magento_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_vnet_west_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    networkSecurityGroup: {
      id: networkSecurityGroups_west_magento_nsg_name_resource.id
    }
  }
}

resource profiles_magento_fd_name_magento_magento_udr 'Microsoft.Cdn/profiles/afdendpoints/routes@2021-06-01' = {
  parent: profiles_magento_fd_name_magento
  name: 'magento-udr'
  properties: {
    customDomains: [
      {
        id: profiles_magento_fd_name_retail_frontend_demo_azure_redislabs_com.id
      }
    ]
    originGroup: {
      id: profiles_magento_fd_name_magento_origin_group.id
    }
    supportedProtocols: [
      'Http'
    ]
    patternsToMatch: [
      '/*'
    ]
    forwardingProtocol: 'HttpOnly'
    linkToDefaultDomain: 'Enabled'
    httpsRedirect: 'Disabled'
    enabledState: 'Enabled'
  }
  dependsOn: [

    profiles_magento_fd_name_resource

  ]
}
