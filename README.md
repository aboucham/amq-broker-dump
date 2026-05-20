# AMQ Broker OpenShift Resource Dump Script

This script allows you to dump resources, status, and logs of an AMQ Broker running on OpenShift. It provides a comprehensive report that includes various Kubernetes and AMQ Broker resources.

## Prerequisites

- `kubectl` or `oc` command-line tools installed and configured to access your OpenShift cluster.
- Permissions to access the AMQ Broker resources and namespace.
- **For Interactive Mode**: Cluster-wide permissions (cluster admin rights) to auto-discover brokers across all namespaces.
- **For Manual Mode**: Namespace-level permissions are sufficient.

## Usage

### Interactive Mode (Auto-Discovery) - NEW! ✨

**Requires cluster admin rights** to scan all namespaces.

Simply run the script without arguments to automatically discover all AMQ Broker clusters:

```shell
./report.sh
```

Or remotely via curl:

```shell
bash <(curl -sLk "https://raw.githubusercontent.com/aboucham/amq-broker-dump/refs/heads/main/report.sh")
```

The script will:
1. Discover all AMQ Broker clusters across all namespaces
2. Display an interactive menu
3. Let you select which cluster to diagnose

**Example:**
```shell
$ ./report.sh

Auto-discovering AMQ Broker clusters...

Found AMQ Broker clusters:

  1) Namespace: production, Cluster: broker-prod
  2) Namespace: staging, Cluster: broker-staging
  3) Namespace: dev, Cluster: broker-dev

Select cluster number (1-3) or 'q' to quit: 1

✓ Selected: Namespace=production, Cluster=broker-prod
...
Report file report-18-05-2026_15-45-30.zip created
```

### Manual Mode

**Works without cluster admin rights** - only requires namespace-level permissions.

Use this mode if you know the namespace and cluster name, or if you don't have cluster-wide permissions:

#### Local Script
1. Download the `report.sh` script.
2. Make the script executable: `chmod +x report.sh`
3. Run the script with the following options:

```shell
./report.sh --namespace=<namespace> --cluster=<cluster> [options]
```

#### Remote via curl (Recommended for users without cluster admin)
```shell
bash <(curl -sLk "https://raw.githubusercontent.com/aboucham/amq-broker-dump/refs/heads/main/report.sh") \
  --namespace=<namespace> \
  --cluster=<cluster>
```

**Example:**
```shell
bash <(curl -sLk "https://raw.githubusercontent.com/aboucham/amq-broker-dump/refs/heads/main/report.sh") \
  --namespace=broker \
  --cluster=broker

## Options

--namespace=<string>: Specify the Kubernetes namespace where the AMQ Broker is deployed. (Required)
--cluster=<string>: Specify the name of the AMQ Broker cluster. (Required)
--secrets=(off|hidden|all): Specify the verbosity level for secrets. Default is hidden, which only reports the secret keys. Use off to exclude secrets entirely, and all to report secret keys and data values. (Optional)
--out-dir=<string>: Specify the output directory for the report. If not provided, a temporary directory will be created. (Optional)

## Examples

### Interactive Mode
```shell
# Auto-discover and select from menu
./report.sh

# With custom output directory
./report.sh --out-dir=~/Downloads

# With all secrets included
./report.sh --secrets=all
```

### Manual Mode
```shell
# Basic usage (local script)
./report.sh --namespace=my-namespace --cluster=my-broker

# Remote via curl (works without cluster admin rights)
bash <(curl -sLk "https://raw.githubusercontent.com/aboucham/amq-broker-dump/refs/heads/main/report.sh") \
  --namespace=my-namespace \
  --cluster=my-broker

# With all options
./report.sh --namespace=my-namespace --cluster=my-broker --secrets=all --out-dir=/path/to/output

# Remote with all options
bash <(curl -sLk "https://raw.githubusercontent.com/aboucham/amq-broker-dump/refs/heads/main/report.sh") \
  --namespace=my-namespace \
  --cluster=my-broker \
  --secrets=all \
  --out-dir=/path/to/output
```


## Output
The script generates a report that includes the following:

YAML files for various OpenShift resources associated with the AMQ Broker, such as deployments, stateful sets, config maps, secrets, services, and more.
YAML files for custom resources and their corresponding instances.
Log files for AMQ Broker pods.
Configuration files used by the AMQ Broker, such as artemis-roles.properties, artemis-users.properties, broker.xml, etc.
The report is organized into different directories based on the resource types and includes subdirectories for secrets, pods, replicasets, deployments, config maps, and custom resources.

## Permissions and Auto-Discovery

### If You Don't Have Cluster Admin Rights

When you run the script in **Interactive Mode** without cluster-wide permissions, you'll see:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  INSUFFICIENT CLUSTER ADMIN RIGHTS DETECTED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Unable to auto-discover AMQ Broker clusters across all namespaces.
This typically means you don't have cluster-wide permissions.

Please use MANUAL MODE by specifying the namespace and cluster name:
```

Simply switch to **Manual Mode** with the provided curl command - no cluster admin rights needed!

## Important Notes

The script checks for the presence of kubectl or oc command-line tools. Ensure that one of these tools is installed and configured properly.
The script requires permissions to access the specified namespace and AMQ Broker resources.
The verbosity level for secrets can be controlled using the --secrets option. By default, only secret keys are reported. Use caution when selecting the all verbosity level, as it may expose sensitive information.
Please ensure that you have the necessary permissions and review the output files carefully, considering the security implications.