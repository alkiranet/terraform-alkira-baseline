#### Example billing tag configuration
**Billing tags** can be created and applied to resources for _cost optimization_ purposes. 

```yml
---
tags:
  - name: 'cloud'
    description: 'Cloud Engineering'

  - name: 'network'
    description: 'Network Engineering'

  - name: 'security'
    description: 'Security Engineering'
...
```

#### Example group configuration
There are two group types you can create. You can indicate which type of group with **type** set to either **connector** or **user**.

```yml
---
groups:
  - name: 'nonprod'
    description: 'Non-Production environments'
    type: 'connector'

  - name: 'prod'
    description: 'Production environments'
    type: 'connector'

  - name: 'remote'
    description: 'SecureConnect VPN users'
    type: 'user'
...
```

#### Example segment configuration
_Segments_ are used for _macro-segmentation_.

```yml
---
segments:
  - name: 'corporate'
    asn: '65514'
    cidr: '10.255.250.0/24'

  - name: 'partner'
    asn: '65514'
    cidr: '10.255.251.0/24'
...
```