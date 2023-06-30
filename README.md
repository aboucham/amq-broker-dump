# AMQ Broker OpenShift Resource Dump Script

This script allows you to dump resources, status, and logs of an AMQ Broker running on OpenShift. It provides a comprehensive report that includes various OpenShift and AMQ Broker resources.

## Prerequisites

- `kubectl` or `oc` command-line tools installed and configured to access your OpenShift cluster.
- Permissions to access the AMQ Broker resources and namespace.

## Usage

1. Download the `report.sh` script.
2. Make the script executable: `chmod +x report.sh`
3. Run the script with the following options:

```shell
./report.sh --namespace=<namespace> --cluster=<cluster> [options]
```

## Options

`--namespace=<string>`: Specify the OpenShift namespace where the AMQ Broker is deployed  (Required).

`--cluster=<string>`: Specify the name of the AMQ Broker cluster (Required).

`--secrets=(off|hidden|all)`: Specify the verbosity level for secrets. Default is hidden, which only reports the secret keys. Use off to exclude secrets entirely, and all to report secret keys and data values (Optional).

`--out-dir=<string>`: Specify the output directory for the report. If not provided, a temporary directory will be created (Optional).

## Examples

```shell
./report.sh --namespace=my-namespace --cluster=my-broker
```

```shell
./report.sh --namespace=my-namespace --cluster=my-broker --secrets=all --out-dir=/path/to/output
```

## Output
The script generates a report that includes the following:

YAML files for various OpenShift resources associated with the AMQ Broker, such as deployments, stateful sets, config maps, secrets, services, and more.

YAML files for custom resources and their corresponding instances.

Log files for AMQ Broker pods.

Configuration files used by the AMQ Broker, such as artemis-roles.properties, artemis-users.properties, broker.xml, etc.

The report is organized into different directories based on the resource types and includes subdirectories for secrets, pods, replicasets, deployments, config maps, and custom resources.

## Important Notes

The script checks for the presence of kubectl or oc command-line tools. Ensure that one of these tools is installed and configured properly.

The script requires permissions to access the specified namespace and AMQ Broker resources.

The verbosity level for secrets can be controlled using the --secrets option. By default, only secret keys are reported. Use caution when selecting the all verbosity level, as it may expose sensitive information.

Please ensure that you have the necessary permissions and review the output files carefully, considering the security implications.
