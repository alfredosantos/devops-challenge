#Configuration Management Challenge

Your task is to manage the state of a node using configuration management.

Your configuration should be able to:

1. Deploy the instance. To don't generate costs for you and for us, use `vagrant` with virtual box to provision your instance.
1. Manage a HTTP Server to listen in HTTP and HTTPS
1. Delivery the application using Docker and ensure it will "survire" at restarts
1. A simple way to update the binary

You can pick the configuration management tool from the above list:

1. Ansible (prefered)
1. Puppet

Keep in mind, an evaluator will check out your repository and will review:

1. Code design
1. Best practices

The evaluator will execute your code and it should be able to see the that the application is deployed and running.

Things you need to known
------------------------

1. `go build main.go` builds the app.
1. This application starts at port 8080 on localhost.
1. We appreciate Makefiles :)
1. Keep in mind, in the evaluator machine, does not have go compiler installed.
1. To see the content, access: https://\<host\>/

Tests should show that this page is reachable and is specific to the content the test page sends back.

Starting the Test
----------------
Create a branch, please, use mnemonic names. If you will use ansible, create a branch named ansible.

## Delivery Instructions

1. You must provide your github with your repo.
1. Commit your code in your repo and send it to recruitment team.
1. Please, give to us a documentation. We will read it see how to run your code.

P.S. comments matters. Please, don't rebase your code, we want see how your construction was evolved.

## Format

* This assessment must be delivered within 24 hours.
* You must be prepared to walk an evaluator through all the created artifacts including tests
    * Mention anything that was asked but not delivered and why, and any additional comments.
