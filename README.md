# DevOps Engineering

## Azure CLI

I am using Ubuntu WSL:

```bash
Welcome to Ubuntu 26.04 LTS (GNU/Linux 6.6.87.2-microsoft-standard-WSL2 x86_64)

 * Documentation:  https://docs.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Mon May 25 10:46:59 SAST 2026

  System load:  0.08                Processes:             63
  Usage of /:   0.3% of 1006.85GB   Users logged in:       0
  Memory usage: 9%                  IPv4 address for eth0: 172.25.83.138
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

This message is shown once a day. To disable it please create the
/home/devzwide/.hushlogin file.
```

1. Check my current accounts

```bash
devzwide@BUNXU:~$ az account list
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "**********************",
    "id": "**********************",
    "isDefault": false,
    "managedByTenants": [],
    "name": "Azure subscription 1",
    "state": "Enabled",
    "tenantDefaultDomain": "**********************",
    "tenantDisplayName": "Mr Price Group Ltd",
    "tenantId": "**********************",
    "user": {
      "name": "**********************",
      "type": "user"
    }
  },
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "**********************",
    "id": "**********************",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure subscription 1",
    "state": "Enabled",
    "tenantDefaultDomain": "nxumalobukeka66gmail.onmicrosoft.com",
    "tenantDisplayName": "Default Directory",
    "tenantId": "**********************",
    "user": {
      "name": "nxumalobukeka66@gmail.com",
      "type": "user"
    }
  }
]
```

2. Set the account I want to work with and Confirm the account

```bash
devzwide@BUNXU:~$ az account set --subscription **********************
devzwide@BUNXU:~$ az account show
{
  "environmentName": "AzureCloud",
  "homeTenantId": "**********************",
  "id": "**********************",
  "isDefault": true,
  "managedByTenants": [],
  "name": "Azure subscription 1",
  "state": "Enabled",
  "tenantDefaultDomain": "nxumalobukeka66gmail.onmicrosoft.com",
  "tenantDisplayName": "Default Directory",
  "tenantId": "**********************",
  "user": {
    "name": "nxumalobukeka66@gmail.com",
    "type": "user"
  }
}
```

3. Create Entra ID application (Service Principle)

```bash
devzwide@BUNXU:~$ az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions **********************" --output json
Creating 'Contributor' role assignment under scope '/subscriptions/**********************'
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "**********************",
  "displayName": "**********************",
  "password": "**********************",
  "tenant": "**********************",
}
```

5. Navigate to my project and check git logs

```bash
devzwide@BUNXU:~$ cd DevOps && ls -a
.  ..  WebApp  mrpapplication  scripts
devzwide@BUNXU:~/DevOps$ cd .. && ls
DevOps  devops  snap
devzwide@BUNXU:~$ cd devops && ls -a
.  ..  mrp
devzwide@BUNXU:~/devops$ cd mrp
devzwide@BUNXU:~/devops/mrp$ ls
mrpapi
devzwide@BUNXU:~/devops/mrp$ cd mrpapi
devzwide@BUNXU:~/devops/mrp/mrpapi$ ls
README.md  infrastructure  kubernetes  scripts  src
devzwide@BUNXU:~/devops/mrp/mrpapi$ git status
On branch main
Your branch is up to date with 'github/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        README.md

nothing added to commit but untracked files present (use "git add" to track)
devzwide@BUNXU:~/devops/mrp/mrpapi$ git log
commit a233b0a547b78f1c1ecb474f2f85aa06fad4090e (HEAD -> main, github/main)
Author: devzwide <nxumalobukeka66@gmail.com>
Date:   Mon May 25 09:46:17 2026 +0200

    Insufficient vcpu quota requested 4, remaining 0 for family standardBsv2Family for region southafricanorth. Changed to Standard_D4ds_v4

commit d50b622b6d8972e38923b28a5eaf0fd44c98a284
Author: devzwide <nxumalobukeka66@gmail.com>
Date:   Mon May 25 09:39:10 2026 +0200

    Insufficient vcpu quota requested 4, remaining 0 for family standardBsv2Family for region southafricanorth. Changed to Standard_B2as_v2

commit 37bf6aab5f382e20049cb70c092f9c814909d3b3
Author: devzwide <nxumalobukeka66@gmail.com>
Date:   Mon May 25 08:46:20 2026 +0200

    (fix) ServiceCidrOverlapExistingSubnetsCidr
    The specified service CIDR 10.0.0.0/16 is conflicted with an existing subnet CIDR 10.0.2.0/24

commit e592fff17cd901127fa530fc52f51b1c6e0e8e66
Author: devzwide <nxumalobukeka66@gmail.com>
Date:   Mon May 25 06:05:23 2026 +0200

    (fix) VM Available size

commit 748709616b12c85c51b6d3f11d53c637b6ffe58d
Author: devzwide <nxumalobukeka66@gmail.com>
Date:   Mon May 25 05:54:51 2026 +0200

    (fix) Explicitly define a shorter name for the hidden node resource group

commit e48cf0258d6ee542345e536237a79956aaab127a
Author: devzwide <nxumalobukeka66@gmail.com>
Date:   Mon May 25 05:50:08 2026 +0200

    Kubernetes fix

commit 5f515a439bc669525918750edf8911004ad019fa
Author: devzwide <nxumalobukeka66@gmail.com>
Date:   Mon May 25 05:41:39 2026 +0200

    Container and Kubernetes init

commit 156fa7959de077376029ad250bdaae3e316bbe27
Author: devzwide <nxumalobukeka66@gmail.com>
Date:   Mon May 25 05:09:52 2026 +0200

    Virtual Network Subnets and Network Security Groups Resource
```

5. Go to Entra ID >>> Applications >>> (look for application you created with az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions **********************" --output json) and copy the:
    - Application (client) ID
    - Directory (tenant) ID
    - Client credentials (Secret ID)

6. Create the SP and store the JSON output in a temporary variable

```bash
devzwide@BUNXU:~/devops/mrp/mrpapi$ SP_OUTPUT=$(az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/*********************" --output json)
WARNING: Creating 'Contributor' role assignment under scope '/subscriptions/*********************'
WARNING: The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
```

7. Extract the clean, unquoted values into active variables

```bash
devzwide@BUNXU:~/devops/mrp/mrpapi$ CLIENT_ID=$(echo "$SP_OUTPUT" | jq -r .appId)
devzwide@BUNXU:~/devops/mrp/mrpapi$ CLIENT_SECRET=$(echo "$SP_OUTPUT" | jq -r .password)
```

8. Login to the service principle

```bash
devzwide@BUNXU:~/devops/mrp/mrpapi$ az login --service-principal -u "$CLIENT_ID" -p "$CLIENT_SECRET" --tenant "*********************"
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "*********************",
    "id": "*********************",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Azure subscription 1",
    "state": "Enabled",
    "tenantId": "*********************",
    "user": {
      "name": "*********************",
      "type": "servicePrincipal"
    }
  }
]
```

---

## Terraform

From the providers.tf I have organization and workspace details, create them on Terraform UI
- On Settings >>>> General >>> Execution Mode. Use Local (custom)
- On Account Settings >>>  Tokens >>> Create Token (TF_API_TOKEN) and copy it
- On Azure Pipelines >>> Pipelines >>> On Pipeline (Edit) >>> Variables then add secured variable

---

## Pipeline

Push to Github and Trigger Azure Pipeline:
```bash
devzwide@BUNXU:~/devops/mrp/mrpapi$ git status
On branch main
Your branch is up to date with 'github/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        README.md

nothing added to commit but untracked files present (use "git add" to track)
devzwide@BUNXU:~/devops/mrp/mrpapi$ git add .
devzwide@BUNXU:~/devops/mrp/mrpapi$ git commit -m "Documenting my steps"
[main 65385f3] Documenting my steps
 1 file changed, 232 insertions(+)
 create mode 100644 README.md
devzwide@BUNXU:~/devops/mrp/mrpapi$ git push
Enter passphrase for key '/home/devzwide/.ssh/id_ed25519':
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 2.88 KiB | 1.44 MiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To github.com:devzwide/mrpapi.git
   a233b0a..65385f3  main -> main
```

Trying to access it on the web:
```bash
devzwide@BUNXU:~/devops/mrp/mrpapi$  az aks get-credentials  --resource-group rg-mrpapi-dev-southafricanorth --name aks-mrpapi-dev-southafricanorth --file ~/.kube/config --overwrite-existing
Merged "aks-mrpapi-dev-southafricanorth" as current context in /home/devzwide/.kube/config
devzwide@BUNXU:~/devops/mrp/mrpapi$ kubectl get service mrpapi-backend-service
NAME                     TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)        AGE
mrpapi-backend-service   LoadBalancer   ***.**.***.**   20.87.38.219   80:****/TCP   2m1s
```