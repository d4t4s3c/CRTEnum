# CRTEnum

**Discovery `subdomains` from logs in the transparency certificates on `HTTPS` websites**
  
- CRTEnum not use attacks:

   * Brute Force
   * Zone Transfer (AXFR)

![](/01.png)

- <kbd>Use</kbd>

```cmd
root@kali:~# CRTEnum.sh -d <DOMAIN>
```

- <kbd>Download / Install</kbd>

```cmd
root@kali:~# wget -q "https://raw.githubusercontent.com/d4t4s3c/CRTEnum/main/CRTEnum.sh" -O /usr/bin/CRTEnum
root@kali:~# chmod +x /usr/bin/CRTEnum
```

- <kbd>Requirements</kbd>

  * cURL
  * html2text

---
