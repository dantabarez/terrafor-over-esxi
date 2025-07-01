# Configuración de Ansible para VM1

## Descripción
Este directorio contiene los playbooks y configuraciones de Ansible para la VM1 del proyecto.

## Archivos incluidos

- `inventory.ini`: Inventario de hosts para Ansible
- `nginx.yml`: Playbook para instalar y configurar Nginx

## Uso

Para ejecutar el playbook de nginx:

```bash
ansible-playbook -i inventory.ini nginx.yml
```

## Variables de conexión

- **ansible_user**: test
- **ansible_ssh_pass**: test
- **ansible_become_pass**: test
- **ansible_python_interpreter**: /usr/bin/python3

## Configuración SSH

Se deshabilita la verificación de claves SSH con `StrictHostKeyChecking=no` para facilitar las pruebas.

**Nota**: En producción, se recomienda usar autenticación por claves SSH en lugar de contraseñas.
