locals {
  project = "terraformdemo"
  location  = "ci"

  common_tags = {
    environment = var.environment
    project     = local.project
  }

  # --- Fixed naming convention for this application (bank-app) ---
  # Same for every environment — only the module appends "-${var.environment}" internally

  vnet_name      = "bank-app"
  snet_app_name  = "bank-app_snet"
  snet_db_name   = "bank-db_snet"
  snet_mgmt_name = "bank-mgmt-snet"
  snet_pep_name  = "bank-pep-snet"



    # --- Address space / CIDR convention ---
  vnet_address_space    = ["10.10.0.0/16"]
  subnet_app_prefixes   = ["10.10.1.0/24"]
  subnet_db_prefixes    = ["10.10.2.0/24"]
  subnet_mgmt_prefixes  = ["10.10.3.0/24"]
  subnet_pep_prefixes   = ["10.10.4.0/24"]
}

locals {
  nsg_config = {
    app  = { 
      subnet_key = "app",  
      subnet_name = local.snet_app_name
      security_rule = [
       { 
          name = "Allow-HTTPS-From-Internet-via-LB",
          priority = 100,
          direction = "Inbound",
          access = "Allow",
          protocol = "Tcp",
          source_port_range = "*",
          destination_port_range = "443",
          source_address_prefix = "Internet",
          destination_address_prefix = "*" 
        },
        { 
          name = "Allow-LB-Health-Probes", 
          priority = 110, 
          direction = "Inbound", 
          access = "Allow", 
          protocol = "Tcp", 
          source_port_range = "*", 
          destination_port_range = "*", 
          source_address_prefix = "AzureLoadBalancer", 
          destination_address_prefix = "*" 
        },
        { 
          name = "Deny-All-Other-Inbound", 
          priority = 4096, 
          direction = "Inbound", 
          access = "Deny", 
          protocol = "*", 
          source_port_range = "*", 
          destination_port_range = "*", 
          source_address_prefix = "*", 
          destination_address_prefix = "*" 
        }
      ]
    }
    db   = { 
      subnet_key = "db",   
      subnet_name = local.snet_db_name
      security_rule = [
        { 
            name = "Deny-All-Inbound", 
            priority = 4096, 
            direction = "Inbound", 
            access = "Deny", 
            protocol = "*", 
            source_port_range = "*", 
            destination_port_range = "*", 
            source_address_prefix = "*", 
            destination_address_prefix = "*" 
        }
      ]
    }
    
    mgmt = { 
      subnet_key = "mgmt", 
      subnet_name = local.snet_mgmt_name
      security_rule = []
     }
     
    pep  = { 
      subnet_key = "pep",  
      subnet_name = local.snet_pep_name
      security_rule = [
        { 
            name = "Allow-Postgres-From-App-Subnet", 
            priority = 100, 
            direction = "Inbound", 
            access = "Allow", 
            protocol = "Tcp", 
            source_port_range = "*", 
            destination_port_range = "5432", 
            source_address_prefix = local.subnet_app_prefixes[0], 
            destination_address_prefix = "*" 
        },
        { 
            name = "Deny-All-Other-Inbound", 
            priority = 4096, 
            direction = "Inbound", 
            access = "Deny", 
            protocol = "*", 
            source_port_range = "*", 
            destination_port_range = "*", 
            source_address_prefix = "*", 
            destination_address_prefix = "*" 
        }
      ]
    }
  }
}
