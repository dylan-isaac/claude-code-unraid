# CLAUDE.md

This file provides context for Claude Code when helping maintain, optimize, and troubleshoot an Unraid server environment.

## Initial Server Assessment

When first connecting to an Unraid server, Claude should proactively assess:

1. **Hardware Configuration**
   - CPU, RAM, storage devices, network interfaces
   - Use commands like `cat /proc/cpuinfo`, `free -h`, `lsblk`, `ip a`

2. **Unraid Version and Setup**
   - Current Unraid version and update status
   - Array configuration (number of drives, parity, cache)
   - Check with `cat /etc/unraid-version`, `mdcmd status`

3. **Docker Environment**
   - Running containers and resource usage
   - Docker network configuration
   - Use `docker ps`, `docker stats`, `docker network ls`

4. **VM Configuration**
   - Running VMs and resource allocation
   - Use `virsh list --all`, `virsh dominfo <vm_name>`

5. **Plugin Inventory**
   - Installed plugins and their versions
   - Look in `/boot/config/plugins/`

6. **Network Configuration**
   - Network settings, port forwarding, firewall rules
   - Check `/etc/network/`, UI settings via API

## Common Maintenance Tasks

### System Health Monitoring

```bash
# Check array status
mdcmd status

# Check SMART status of all drives
for d in $(ls /dev/sd*); do smartctl -a $d | grep -E "Device Model|Serial Number|User Capacity|SMART overall-health|Current Temperature"; done

# Check system temperatures
sensors

# Monitor system resource usage
top -c
htop
```

### Docker Management

```bash
# Update all Docker containers
docker container ls -a | grep -v CONTAINER | awk '{print $1}' | xargs -I {} docker update --restart=always {}

# Prune unused Docker resources
docker system prune -a

# View container logs
docker logs <container_name>
```

### Backup Management

```bash
# Check backup status
ls -la /mnt/user/backups/

# Run manual backup
rsync -avh --progress /path/to/source /mnt/user/backups/destination

# Verify backup integrity
md5sum /mnt/user/backups/important_file.tar.gz
```

## Troubleshooting Guide

### Common Issues

1. **Array Issues**
   - Check syslog: `tail -f /var/log/syslog`
   - Review SMART data for failing drives
   - Verify parity status: `mdcmd check`

2. **Docker Problems**
   - Container won't start: Check logs with `docker logs <container>`
   - Network issues: Verify bridge network with `docker network inspect bridge`
   - Resource constraints: Check with `docker stats`

3. **VM Issues**
   - Startup failures: Check XML config in `/etc/libvirt/qemu/`
   - Performance problems: Check resource allocation and contention

4. **Network Problems**
   - Check interface status: `ip a`
   - Test connectivity: `ping -c 4 google.com`
   - Review firewall rules: `iptables -L`

## Best Practices

1. **Regular Maintenance**
   - Run array parity checks monthly
   - Update Unraid OS when stable releases are available
   - Keep Docker containers updated
   - Monitor drive health proactively

2. **Backup Strategy**
   - Maintain 3-2-1 backup policy (3 copies, 2 media types, 1 offsite)
   - Verify backups regularly with integrity checks
   - Document restore procedures

3. **Security Considerations**
   - Use strong passwords and consider 2FA
   - Minimize exposed ports to the internet
   - Keep OS and containers updated
   - Use VPN for remote access instead of direct exposure

4. **Performance Optimization**
   - Enable cache pools for frequently accessed data
   - Consider SSD for appdata
   - Adjust VM and container resource limits appropriately
   - Use appropriate share settings (cache vs disk)

## Information Gathering and Documentation

Claude should collect the following information when assisting with Unraid and update this file with the collected details:

1. **Hardware Specifications**
   - CPU: [To be updated after collection]
   - RAM: [To be updated after collection]
   - Storage Devices: [To be updated after collection]
   - Network Interfaces: [To be updated after collection]

2. **Unraid Configuration**
   - Unraid Version: [To be updated after collection]
   - Array Configuration: [To be updated after collection]
   - Cache Setup: [To be updated after collection]

3. **Installed Plugins**
   - [To be updated with plugin list after collection]

4. **Docker Containers**
   - [To be updated with container list after collection]

5. **Virtual Machines**
   - [To be updated with VM list after collection]

6. **Network Configuration**
   - [To be updated with network details after collection]

7. **Backup Strategy**
   - [To be updated with backup configuration after collection]

Once information is collected, Claude should update this section with the actual details, maintaining this documentation over time as the server configuration changes.

## Documentation Resources

- Unraid Official Documentation: https://docs.unraid.net/
- Unraid Community Forums: https://forums.unraid.net/
- Spaceinvader One Tutorials: https://www.youtube.com/c/SpaceinvaderOne
- Unraid Subreddit: https://www.reddit.com/r/unRAID/

Claude should help create or update comprehensive documentation about the specific server configuration, including:

1. Hardware inventory
2. Network diagram
3. Backup procedures
4. Recovery plans
5. Custom scripts and configurations

The goal is to provide a valuable assistant that helps maintain, optimize, and troubleshoot an Unraid server while building knowledge about the specific environment over time.