# Reference Implementations

## Oracle Java Card Development Kit v25.1

The Oracle Java Card Development Kit provides a reference simulator,
development tools, and an Eclipse plugin for Java Card applet development.
Downloaded from Oracle (free, requires an Oracle account) on 2025-10-27.

All components are version 25.1, targeting Java Card 3.2 Classic Edition.

### Archives

| File | Description |
|------|-------------|
| `java_card_devkit_simulator-linux-bin-v25.1-b_627-26-OCT-2025.tar.gz` | Simulator for Linux x86. Contains the `jcsl` binary (32-bit ELF), runtime shared libraries, sample applets (HelloWorld, Wallet, Channels, etc.), client libraries (AMService, COMService, DebugProxy), and IFD handler driver. |
| `java_card_devkit_simulator-win-bin-v25.1-b_627-26-OCT-2025.tar.gz` | Simulator for Windows. Same contents as the Linux variant but with Windows executables and DLLs. |
| `java_card_devkit_tools-bin-v25.1-b_611-26-OCT-2025.tar.gz` | Development Kit Tools. Contains the converter (`converter.sh`), verifier (`verifyexp.sh`), and supporting libraries for compiling Java Card applets into CAP files. Requires JDK 17. |
| `java_card_devkit_eclipse_plugin-bin-v25.1-b_598-26-OCT-2025.tar.gz` | Eclipse IDE plugin for Java Card development. Provides project templates, build integration, and debugging support. |

### Running the Simulator

Extract the simulator and tools archives, then set three environment variables:

- `JAVA_HOME` -- path to JDK 17
- `JC_HOME_SIMULATOR` -- path to the extracted simulator directory
- `JC_HOME_TOOLS` -- path to the extracted tools directory

The Linux `jcsl` binary is a 32-bit x86 ELF. On 64-bit systems you may
need 32-bit compatibility libraries (`libc6-i386` or equivalent).

### Sample Applets

The simulator archive includes sample applets under `samples/`:
ArrayViews, Channels, HelloWorld, ObjectDeletion, SignatureMessageRecovery,
Utility, and Wallet. Each has a `build.sh` and `run.sh` script.

### Obtaining Updates

Visit https://www.oracle.com/java/technologies/javacard-sdk-downloads.html
