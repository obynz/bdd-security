Narrative: 

In order to reduce the risk of vulnerabilities introduced through software running on the host 
As an engineer responsible for the configuration of the host system and network
I want to ensure that the configuration of the host and network are as expected 

Meta: @story host_config

Scenario: Only the required ports should be open
Meta: @id open_ports @skip

Given the target host from the base URL
When TCP ports from 1 to 65535 are scanned using 100 threads and a timeout of 300 milliseconds
And the open ports are selected
Then only the following ports should be open:
|port|
|80|
|443|