## Introduction

Blockchain Technology has garnered immense interest for its wide range of use cases in Governments as well as private sector enterprises.We have observed billions of dollars being spent in building Blockchain powered applications and yet the mainstream adoption is very much limited. We see that the acute rise in Blockchain technology fogged the focus on its most important aspect – The infrastructure. Technology infrastructure plays a significant role while building a scalable platform. The infrastructure must provide sufficient level of flexibility for developers to choose and adopt core protocols for the platform while designing it. Also, the infrastructure must empower an application to allow high performance during its runtime execution.

Auxesis Group, established in 2014, pioneers in building enterprise Blockchain solutions and is one of The Top 100 Most Influential Blockchain Organizations worldwide. Auxesis commenced ‘Auxledger project’ internally in 2017, with the idea of implementing blockchain network for the world’s largest democracy, India and to act as value chain for its economy by enabling trust, transparency and efficiency in various business processes. 

The team at Auxledger overviewed hundreds of Blockchain implementations across the globe to come up with a comprehensive platform which would be necessary to power the decentralized internet of tomorrow. Concluding our research, apart from numerous enhancements, we found three key elements which are the deciding factors for building Blockchain for mainstream adoption. 
The three key elements are:

- Customizability: The customization flexibility offered by a platform to meet the needs of the developer as well as that of a business. Granting full access to adopt different protocols suiting a particular design of a private/public Blockchain network.

- Performance: The ability of Blockchain networks and distributed applications to match up to today’s fast paced world, i.e.; sending information and processing transactions on real-time basis.

- Interoperability: Blockchain networks with different protocols and different sizes should be able to communicate to one-another in a trust-free manner. A communication protocol which sets a global standard of communication between networks without compromising on data integrity

Auxledger team has devised a platform and technology infrastructure that overcomes the requirements of customizability, performance and interoperability.
For application use-cases of Auxledger Infrastructure you can refer to https://wiki.auxledger.org/

## Building the source

For prerequisites and detailed build instructions please read the installation instructions on the wiki.
Building gaux requires both a Go (version 1.7 or later) and a C compiler. You can install them using your favourite package manager. 

Once the dependencies are installed, run

> make gaux

or, to build the full suite of utilities:
> make all

## Executables

The Auxledger project comes with several wrappers/executables found in the ‘cmd’ directory.

| Command    | Description |
|:----------:|-------------|
| **`gaux`** | It is the entry point into the Auxledger network (main-, test- or private net), capable of running as a full node (default), archive node (retaining all historical state) or a light node (retrieving data live). It can be used by other processes as a gateway into the Auxledger network via JSON RPC endpoints exposed on top of HTTP, WebSocket and/or IPC transports. Read more on our wiki page - [https://wiki.auxledger.org/](https://wiki.auxledger.org/) |
| `abigen` | Source code generator to convert Auxledger contract definitions into easy to use, compile-time type-safe Go packages. It operates on plain Auxledger contract ABIs with expanded functionality if the contract bytecode is also available. However it also accepts Solidity source files, making development much more streamlined. See our wiki page for for details - [https://wiki.auxledger.org/](https://wiki.auxledger.org/) | 
| `bootnode` | Stripped down version of our Auxledger client implementation that only takes part in the network node discovery protocol, but does not run any of the higher level application protocols. It can be used as a lightweight bootstrap node to aid in finding peers in private networks. |
| `avm` | Developer utility version of the AVM (Auxledger Virtual Machine) that is capable of running bytecode snippets within a configurable environment and execution mode. Its purpose is to allow isolated, fine-grained debugging of EVM opcodes (e.g. `avm --code 60ff60ff --debug`). |
| `gauxrpctest` | Developer utility tool to support our [auxledger/rpc-test](https://github.com/Auxledger/rpc-tests) test suite which validates baseline conformity to the [Auxledger JSON RPC](https://github.com/Auxledger/wiki/wiki/JSON-RPC) specs.
| `rlpdump` | Developer utility tool to convert binary RLP (Recursive Length Prefix) dumps (data encoding used by the Auxledger protocol, both network as well as consensus wise) to user friendlier hierarchical representation. (e.g. rlpdump --hex CE0183FFFFFFC4C304050583616263) |
| `swarm` | Swarm daemon and tools. This is the entrypoint for the Swarm network. 'swarm --help' for command line options and subcommands. See Swarm README for more information. |
| `puppeth` | a CLI wizard that aids in creating a new Auxledger network. |

## Running gaux
Pondering over all the command line flags is beyond the breadth for this piece of information, but we've enumerated a few common parameter combos to get you up to speed quickly on how you can run your own Gaux instance.

### Full Node on the main Auxledger Network

By far the most common scenario is people wanting to simply interact with the Auxledger network: create accounts; transfer funds; deploy and interact with contracts. For this particular use-case the user doesn't need to care about years-old historical data, so we can fast-sync quickly to the current state of the network. To do so:

> $ gaux console

This command will:
    -Start gaux in fast sync mode (default, can be changed with the --syncmode flag), causing it to download more data in exchange for avoiding processing the entire history of the Auxledger network, which is very CPU intensive.
    -Start up Gaux's built-in interactive JavaScript console, (via the trailing console subcommand) through which you can invoke all official web3 methods as well as Gaux's own management APIs. This tool is optional and if you leave it out you can always attach to an already running Gaux instance with gaux attach.
    
### Full node on the Auxledger test network

Transitioning towards developers, if you'd like to play around with creating Auxledger contracts, you almost certainly would like to do that without any real money involved until you get the hang of the entire system. In other words, instead of attaching to the main network, you want to join the test network with your node, which is fully equivalent to the main network. You can access the Auxledger test network at - [https://testnet.auxledger.org/#/](https://testnet.auxledger.org/#/)

> $ gaux --testnet console

The console subcommand have the exact same meaning as above and they are equally useful on the testnet too. Please see above for their explanations if you've skipped to here.
Specifying the --testnet flag however will reconfigure your Gaux instance a bit:

- Instead of using the default data directory ( `~/.Auxledger` on Linux for example), Gaux will nest itself one level deeper into a testnet subfolder ( `~/.auxledger/testnet` on Linux). Note, on OSX and Linux this also means that attaching to a running testnet node requires the use of a custom endpoint since gaux attach will try to attach to a production node endpoint by default. 

> E.g. gaux attach <datadir>/testnet/gaux.ipc. 
    
Windows users are not affected by this.

* Instead of connecting the main Auxledger network, the client will connect to the test network, which uses different P2P bootnodes, different network IDs and genesis states.

*Note: Although there are some internal protective measures to prevent transactions from crossing over between the main network and test network, you should make sure to always use separate accounts for play-money and real-money. Unless you manually move accounts, Gaux will by default correctly separate the two networks and will not make any accounts available between them.*


### Configuration

As an alternative to passing the numerous flags to the gaux binary, you can also pass a configuration file via:

> $ gaux --config /path/to/your_config.toml


To get an idea how the file should look like you can use the dumpconfig subcommand to export your existing configuration:

> $ gaux --your-favourite-flags dumpconfig


*Note: This works only with gaux v1.6.0 and above.*

#### Docker quick start

One of the quickest ways to get Auxledger up and running on your machine is by using Docker:

> docker run -d --name auxledger-node -v /Users/alice/auxledger:/root \
>          -p 8545:8545 -p 30303:30303 \
>          auxledger/client-go


This will start gaux in fast-sync mode with a DB memory allowance of 1GB just as the above command does. It will also create a persistent volume in your home directory for saving your blockchain as well as map the default ports. There is also an `alpine` tag available for a slim version of the image.

Do not forget `--rpcaddr 0.0.0.0`, if you want to access RPC from other containers and/or hosts. By default, gaux binds to the local interface and RPC endpoints is not accessible from the outside.


### Programatically interfacing gaux nodes

As a developer, sooner rather than later you'll want to start interacting with Gaux and the Auxledger network via your own programs and not manually through the console. To aid this, Gaux has built-in support for a JSON-RPC based APIs (standard APIs and Gaux specific APIs). These can be exposed via HTTP, WebSockets and IPC (unix sockets on unix based platforms, and named pipes on Windows).

The IPC interface is enabled by default and exposes all the APIs supported by Gaux, whereas the HTTP and WS interfaces need to manually be enabled and only expose a subset of APIs due to security reasons. These can be turned on/off and configured as you'd expect.


HTTP based JSON-RPC API options:

  * `--rpc` Enable the HTTP-RPC server
  * `--rpcaddr` HTTP-RPC server listening interface (default: "localhost")
  * `--rpcport` HTTP-RPC server listening port (default: 8545)
  * `--rpcapi` API's offered over the HTTP-RPC interface (default: "aux,net,web3")
  * `--rpccorsdomain` Comma separated list of domains from which to accept cross origin requests (browser enforced)
  * `--ws` Enable the WS-RPC server
  * `--wsaddr` WS-RPC server listening interface (default: "localhost")
  * `--wsport` WS-RPC server listening port (default: 8546)
  * `--wsapi` API's offered over the WS-RPC interface (default: "aux,net,web3")
  * `--wsorigins` Origins from which to accept websockets requests
  * `--ipcdisable` Disable the IPC-RPC server
  * `--ipcapi` API's offered over the IPC-RPC interface (default: "admin,debug,eth,miner,net,personal,shh,txpool,web3")
  * `--ipcpath` Filename for IPC socket/pipe within the datadir (explicit paths escape it)

You'll need to use your own programming environments' capabilities (libraries, tools, etc) to connect via HTTP, WS or IPC to a gaux node configured with the above flags and you'll need to speak [JSON-RPC](http://www.jsonrpc.org/specification) on all transports. You can reuse the same connection for multiple requests!

**Note: Please understand the security implications of opening up an HTTP/WS based transport before doing so! Hackers on the internet are actively trying to subvert Auxledger nodes with exposed APIs! Further, all browser tabs can access locally running web servers, so malicious web pages could try to subvert locally available APIs**

### Operating a private network

Maintaining your own private network is more involved as a lot of configurations taken for granted in the official networks need to be manually set up.

#### Defining the private genesis state

First, you'll need to create the genesis state of your networks, which all nodes need to be aware of and agree upon. This consists of a small JSON file (e.g. call it `genesis.json`):

```
{
  "config": {
        "chainId": 0,
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
  "alloc"      : {},
  "coinbase"   : "0x0000000000000000000000000000000000000000",
  "difficulty" : "0x20000",
  "extraData"  : "",
  "gasLimit"   : "0x2fefd8",
  "nonce"      : "0x0000000000000042",
  "mixhash"    : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000",
  "timestamp"  : "0x00"
}
```

The above fields should be fine for most purposes, although we'd recommend changing the nonce to some random value so you prevent unknown remote nodes from being able to connect to you. If you'd like to pre-fund some accounts for easier testing, you can populate the alloc field with account configs:

```
"alloc": {
  "0x0000000000000000000000000000000000000001": {"balance": "111111111"},
  "0x0000000000000000000000000000000000000002": {"balance": "222222222"}
}
```

With the genesis state defined in the above JSON file, you'll need to initialize **every** gaux node with it prior to starting it up to ensure all blockchain parameters are correctly set:

```
$ gaux init path/to/genesis.json
```

#### Creating the rendezvous point

With all nodes that you want to run initialized to the desired genesis state, you'll need to start a bootstrap node that others can use to find each other in your network and/or over the internet. The clean way is to configure and run a dedicated bootnode:


```
$ bootnode --genkey=boot.key
$ bootnode --nodekey=boot.key
```

With the bootnode online, it will display an [`enode` URL](https://github.com/Auxledger/wiki/wiki/enode-url-format) that other nodes can use to connect to it and exchange peer information. Make sure to replace the displayed IP address information (most probably `[::]`) with your externally accessible IP to get the actual `enode` URL.

*Note: You could also use a full fledged Gaux node as a bootnode, but it's the less recommended way.*

#### Starting up your member nodes

With the bootnode operational and externally reachable (you can try `telnet <ip> <port>` to ensure it's indeed reachable), start every subsequent gaux node pointed to the bootnode for peer discovery via the `--bootnodes` flag. It will probably also be desirable to keep the data directory of your private network separated, so do also specify a custom `--datadir` flag.

```
$ gaux --datadir=path/to/custom/data/folder --bootnodes=<bootnode-enode-url-from-above>
```

*Note: Since your network will be completely cut off from the main and test networks, you'll also need to configure a miner to process transactions and create new blocks for you.*

#### Running a private miner

Mining on the public Auxledger network is a complex task as it's only feasible using GPUs, requiring an OpenCL or CUDA enabled ethminer instance.
In a private network setting however, a single CPU miner instance is more than enough for practical purposes as it can produce a stable stream of blocks at the correct intervals without needing heavy resources (consider running on a single thread, no need for multiple ones either). To start a Gaux instance for mining, run it with all your usual flags, extended by:

```
$ gaux <usual-flags> --mine --minerthreads=1 --etherbase=0x0000000000000000000000000000000000000000
```

Which will start mining blocks and transactions on a single CPU thread, crediting all proceedings to the account specified by `--etherbase`. You can further tune the mining by changing the default gas limit blocks converge to (`--targetgaslimit`) and the price transactions are accepted at (`--gasprice`).

## JSON-RPC (Intro)

JSON-RPC is a remote procedure call protocol encoded in JSON. It is a very simple protocol (and very similar to XML-RPC), defining only a few data types and commands. JSON-RPC allows for notifications (data sent to the server that does not require a response) and for multiple calls to be sent to the server which may be answered out of order. 

JSON-RPC works by sending a request to a server implementing this protocol. The client in that case is typically software intending to call a single method of a remote system. Multiple input parameters can be passed to the remote method as an array or object, whereas the method itself can return multiple output data as well. (This depends on the implemented version.
All transfer types are single objects, serialized using JSON.[1] A request is a call to a specific method provided by a remote system. It must contain three certain properties:method -

* A String with the name of the method to be invoked.
* params - An Object or Array of values to be passed as parameters to the defined method.
* id - A value of any type used to match the response with the request that it is replying to.

The receiver of the request must reply with a valid response to all received requests. A response must contain the properties mentioned below:

* result - The data returned by the invoked method. If an error occurred while invoking the method, this value must be null.
* error - A specified error code if there was an error invoking the method, otherwise null.
* id - The id of the request it is responding to.

Since there are situations where no response is needed or even desired, notifications were introduced. A notification is similar to a request except for the id, which is not needed because no response will be returned. In this case the id property should be omitted (Version 2.0) or be null (Version 1.0).


## Roadmap

### Phase 1 - Orion
*Status - Completed*

* Fault Tolerant Virtual Machine
* Network synchronization and data portability
* Plug-in based architecture module
* Ethereum Virtual Machine compatibility
* Integrated asset management system
* Easy private Blockchain network deployment

### Phase 2 - Draco
*Status - Ongoing*
*Projected Completion Date - Q3,2019.*

* Enterprise public network launch
* Hybrid Tendermint DPOS Consensus
* Multi token economy governance
* Self-regulating economy model
* Privacy Preserving Smart Contracts
* Transactional & Contract Development
* Secure wallet and asset management.

### Phase 3 - Cetus
*Status - Ongoing*
*Projected Completion Date - Q2, 2020.*

* Auxledger Virtual Machine implementing higher degree of fault tolerance
* CLI enabled SDK and API’s for networks tiering
* Microservices oriented Blockchain protocol pool base
* Horizontally scalable architecture for new protocol development
* Enabling community contribution protocol repository

### Phase 4 - Hydra
*Status - Ongoing*
*Projected Completion Date - Q4, 2020.*

* Full scale AVM supporting multi language scripting & defensive contract techniques
* Decentralize tiered network consensus protocol
* Interoperability across networks and interchain transactions
* Bridge consensus to interface with heterogeneous networks
* GUI enabled SDK for networks & protocol customization
