# Configuraciones de Packer

Este directorio contiene las configuraciones de Packer para crear templates de máquinas virtuales.

## Estructura de directorios

```
packer/
├── ubuntu16/           # Configuraciones para Ubuntu 16.04
│   ├── preseed.cfg     # Archivo de preconfiguración para instalación automática
│   ├── ubuntu-16.04.json    # Configuración de Packer en formato JSON
│   └── ubuntu-16.04.pkr.hcl # Configuración de Packer en formato HCL
```

## Uso

### Ubuntu 16.04
```bash
cd ubuntu16
packer build ubuntu-16.04.pkr.hcl
```

## Notas

- Asegúrate de configurar las credenciales de vSphere antes de ejecutar Packer
- Los archivos preseed.cfg contienen la configuración para instalación automática
- Los templates creados pueden ser usados con el módulo Terraform `vm_from_template`
