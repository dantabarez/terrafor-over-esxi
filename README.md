# Terraformando un ESXi

Este proyecto utiliza **Terraform** para automatizar la provisión y gestión de recursos en un entorno **VMware vSphere ESXi**. El objetivo es facilitar la creación, configuración y despliegue de máquinas virtuales de manera reproducible y controlada.

## ¿Qué hace este proyecto?

- Se conecta a un servidor vSphere ESXi usando el proveedor oficial de Terraform.
- Obtiene información del datacenter, datastore, red y host configurados en vSphere.
- Utiliza una plantilla (template) de máquina virtual existente para clonar nuevas VMs.
- Crea una máquina virtual (VM) con recursos definidos (CPU, RAM, disco, red) a partir de la plantilla seleccionada.
- Permite modificar fácilmente los parámetros de la VM desde los archivos de configuración.

## Estructura principal

- **main.tf**: Archivo principal de configuración de Terraform. Define el proveedor, los datos de infraestructura existentes y el recurso para crear la VM.
- **.gitignore**: Evita que archivos sensibles o pesados (como estados y backups de Terraform) se suban al repositorio.
- **README.md**: Este archivo, con la descripción y guía del proyecto.
- **packer-ubuntu16/**: Carpeta con la configuración de Packer para crear una imagen de Ubuntu 16.
- **packer-ubuntu22/**: Carpeta con la configuración de Packer para crear una imagen de Ubuntu 22.

## Requisitos

- Acceso a un servidor vSphere ESXi.
- Terraform instalado en tu máquina local.
- Packer instalado para crear imágenes.
- Una plantilla de VM existente en vSphere para clonar.

## Uso básico de Terraform

1. Clona este repositorio.
2. Configura las variables necesarias en `main.tf` (usuario, contraseña, IP del servidor, nombres de recursos).
3. Ejecuta los comandos de Terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
4. Terraform creará la VM según la configuración especificada.

## Uso básico de Packer

Para construir imágenes de Ubuntu 16 y Ubuntu 22 con Packer, navega a la carpeta correspondiente y ejecuta:

**Ubuntu 16:**
```bash
cd packer-ubuntu16
packer init .
packer validate .
packer build .
```

**Ubuntu 22:**
```bash
cd packer-ubuntu22
packer init .
packer validate .
packer build .
```

---

**Autor:** Maldonado Tabarez