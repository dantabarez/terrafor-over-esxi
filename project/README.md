# Proyecto Terraform - ESXi Infrastructure as Code

Este proyecto proporciona una infraestructura completa para gestionar máquinas virtuales en ESXi usando Terraform, con configuración mediante Ansible y creación de templates con Packer.

## Estructura del proyecto

```
project/
├── main.tf                    # Configuración principal de Terraform
├── variables.tf               # Variables del proyecto
├── output.tf                  # Outputs del proyecto
├── terraform.tfvars           # Valores de las variables
├── modules/                   # Módulos de Terraform
│   ├── vm_from_template/      # Módulo para crear VMs desde template
│   │   ├── main.tf           # Configuración del módulo
│   │   ├── variables.tf      # Variables del módulo
│   │   └── outputs.tf        # Outputs del módulo
│   └── vm_from_ova/          # Módulo para crear VMs desde OVA
├── ansible/                   # Configuraciones de Ansible
│   └── vm1/                  # Configuración específica para VM1
│       ├── inventory.ini     # Inventario de hosts
│       ├── nginx.yml         # Playbook para instalar Nginx
│       └── README.md         # Documentación de Ansible
└── packer/                   # Configuraciones de Packer
    ├── ubuntu16/             # Templates para Ubuntu 16.04
    ├── ubuntu22/             # Templates para Ubuntu 22.04
    └── README.md             # Documentación de Packer
```

## Uso

### 1. Configurar variables
Edita el archivo `terraform.tfvars` con tus valores:

```hcl
vsphere_user     = "administrator@vsphere.local"
vsphere_password = "tu_password"
vsphere_server   = "192.168.100.99"
datacenter_name  = "Datacenter"
datastore_name   = "datastore1"
network_name     = "VM Network"
host_name        = "192.168.100.92"
template_name    = "ubuntu-template"
```

### 2. Desplegar infraestructura
```bash
terraform init
terraform plan
terraform apply
```

### 3. Configurar VM con Ansible
```bash
cd ansible/vm1
ansible-playbook -i inventory.ini nginx.yml
```

### 4. Crear templates con Packer (opcional)
```bash
cd packer/ubuntu22
packer build ubuntu-vsphere.pkr.hcl
```

## Módulos disponibles

### vm_from_template
Crea una máquina virtual desde un template existente en vSphere.

**Variables principales:**
- `vm_name`: Nombre de la VM
- `vm_cpu`: Número de CPUs
- `vm_memory`: Memoria en MB
- `template_name`: Nombre del template

### vm_from_ova
Crea una máquina virtual desde un archivo OVA.

## Componentes

### Terraform
- Gestión de infraestructura como código
- Módulos reutilizables para diferentes tipos de VM
- Outputs para obtener información de las VMs creadas

### Ansible
- Configuración automática de las VMs desplegadas
- Playbooks organizados por VM/propósito
- Inventarios dinámicos

### Packer
- Creación de templates personalizados
- Soporte para Ubuntu 16.04 y 22.04
- Configuración automatizada con preseed

## Requisitos

- Terraform >= 1.0
- Ansible >= 2.9
- Packer >= 1.7
- Acceso a vSphere/ESXi
- Red accesible desde las VMs

## Notas

- Asegúrate de que el template especificado existe en vSphere
- Las credenciales se manejan de forma segura usando variables sensitive
- Los playbooks de Ansible están configurados para usar autenticación por contraseña (recomendado cambiar a claves SSH en producción)
