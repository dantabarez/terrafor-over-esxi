# Proyecto Terraform + Ansible - Stack ELK en ESXi

Este proyecto proporciona una infraestructura completa para desplegar un stack ELK (Elasticsearch, Logstash, Kibana) en máquinas virtuales ESXi usando Terraform para la infraestructura y Ansible para el aprovisionamiento automático.

## 🚀 Características principales

- **Infraestructura como Código** con Terraform
- **Aprovisionamiento automático** del stack ELK con Ansible
- **Despliegue automatizado** desde OVA
- **Stack ELK completo** con seguridad habilitada
- **Scripts de automatización** para Windows PowerShell

## 📁 Estructura del proyecto

```
project/
├── main.tf                    # Configuración principal de Terraform
├── variables.tf               # Variables del proyecto
├── output.tf                  # Outputs del proyecto
├── terraform.tfvars           # Valores de las variables
├── deploy-elk.ps1            # Script de despliegue automatizado
├── destroy-elk.ps1           # Script de destrucción
├── modules/                   # Módulos de Terraform
│   ├── vm_from_template/      # Módulo para crear VMs desde template
│   └── vm_from_ova/          # Módulo para crear VMs desde OVA
├── ansible/                   # Configuraciones de Ansible
│   └── vm1/                  # Configuración específica para VM1
│       ├── vm_elk.yml        # Playbook del stack ELK
│       ├── inventory.ini     # Inventario de hosts
```

## 🚀 Despliegue rápido del Stack ELK

### Opción 1: Script automatizado (Recomendado)

Para un despliegue completamente automatizado, ejecuta:

```powershell
.\deploy-elk.ps1
```

Este script realizará automáticamente:
1. ✅ Verificación de Terraform y Ansible
2. 🔧 Inicialización de Terraform
3. 📋 Planificación del despliegue
4. 🚀 Creación de la VM desde OVA
5. ⚙️ Aprovisionamiento del stack ELK con Ansible
6. 📊 Muestra URLs y credenciales de acceso

### Opción 2: Paso a paso manual

#### 1. Configurar variables
Edita el archivo `terraform.tfvars` con tus valores:

```hcl
vsphere_user     = "administrator@vsphere.local"
vsphere_password = "tu_password"
vsphere_server   = "192.168.1.10"
datastore_name   = "datastore1"
```

#### 2. Desplegar infraestructura
```bash
# Inicializar Terraform
terraform init

# Planificar el despliegue
terraform plan

# Aplicar el despliegue (incluye Ansible automáticamente)
terraform apply
```

## 📊 Acceso al Stack ELK

Después del despliegue exitoso, obtendrás:

### URLs de acceso:
- **Elasticsearch**: `http://IP_VM:9200`
- **Kibana**: `http://IP_VM:5601`

### Credenciales por defecto:
- **Usuario**: `elastic`
- **Contraseña**: `elastic123`

### Verificar el despliegue:
```bash
# Ver outputs de Terraform
terraform output

# Ver credenciales (sensibles)
terraform output elk_credentials
```

## 🔧 Gestión de la infraestructura

### Destruir la infraestructura
```powershell
# Usando el script automatizado
.\destroy-elk.ps1

# O manualmente
terraform destroy
```

### Replicar en múltiples VMs
Para desplegar el stack ELK en múltiples VMs:

1. Duplica el módulo en `main.tf`:
```hcl
module "vm_desde_ova_vm2" {
  source             = "./modules/vm_from_ova"
  vm_name            = "ubuntu_elk_2"
  ova_path           = "C:\\Users\\claud\\Documents\\Projects\\Terraform\\Ubuntu64-bit-19.ova"
  datastore_name     = var.datastore_name
  datacenter_name    = "ha-datacenter"
  host_name          = "192.168.1.10"
  network_name       = "VM Network"
  resource_pool_name = "Resources"
}
```

2. Agrega el correspondiente `null_resource` para Ansible

## 📋 Requisitos del sistema

### Para Terraform y Ansible:
- Windows 10/11
- Terraform >= 1.0
- Ansible >= 2.9
- PowerShell 5.1+
- Acceso a vSphere/ESXi

### Para las VMs creadas:
- Ubuntu 18.04+ / Debian 9+
- Mínimo 4GB RAM (recomendado 8GB+)
- Mínimo 20GB espacio en disco
- Conectividad de red

## 🛠️ Troubleshooting

### Problemas comunes:

1. **Error de conexión vSphere**:
   - Verifica credenciales en `terraform.tfvars`
   - Confirma conectividad de red al vCenter/ESXi

2. **Ansible no puede conectar a la VM**:
   - Espera a que la VM complete el boot
   - Verifica las credenciales SSH en el inventario

3. **Servicios ELK no inician**:
   - Verifica que la VM tenga suficiente RAM
   - Revisa logs: `sudo journalctl -u elasticsearch -f`

### Logs útiles:
```bash
# En la VM (después de conectar via SSH)
sudo systemctl status elasticsearch
sudo systemctl status logstash  
sudo systemctl status kibana

# Ver logs en tiempo real
sudo journalctl -u elasticsearch -f
sudo journalctl -u kibana -f
```

## 📚 Documentación adicional

- [README del Stack ELK](ansible/vm1/README_ELK.md) - Documentación detallada del aprovisionamiento
- [Configuración de módulos](modules/) - Documentación de los módulos de Terraform
- [Configuración de Packer](packer/) - Templates para crear imágenes personalizadas

## 🔒 Seguridad

⚠️ **Importante para producción**:
- Cambia las contraseñas por defecto
- Habilita SSL/TLS en Elasticsearch y Kibana
- Configura firewall apropiadamente
- Implementa autenticación robusta
- Usa certificados válidos

## 🤝 Contribución

Para contribuir al proyecto:
1. Fork del repositorio
2. Crea una rama para tu feature
3. Commit de tus cambios
4. Push a la rama
5. Crear un Pull Request
