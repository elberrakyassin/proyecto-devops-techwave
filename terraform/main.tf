# 1. Configuración de los Providers para Azure
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  skip_provider_registration = true
}

# 2. Creación del Grupo de Recursos (Contenedor para todo el proyecto)
resource "azurerm_resource_group" "rg" {
  name     = "rg-techwave-devops"
  location = "West Europe"
}

# 3. Definición de la Red Virtual (VPC en términos de Azure) [cite: 37]
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-techwave"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 4. Definición de la Subred para el clúster [cite: 37]
resource "azurerm_subnet" "subnet" {
  name                 = "snet-aks"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 5. Creación del clúster de Kubernetes (AKS) y los nodos [cite: 38]
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-techwave"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "techwaveaks"

  default_node_pool {
    name       = "default"
    node_count = 1                # Un solo nodo para minimizar costes
    vm_size    = "Standard_B2s"   # Tamaño económico compatible con pruebas
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    Project     = "TechWave-DevOps"
  }
}