# Reference Implementations

## Oracle Java Card Simulator (jcsl)

The Oracle Java Card Development Kit Simulator ships a native reference
implementation of the JCVM (v3.2) and GlobalPlatform Card Specification (v2.3)
with SCP03 support. The `jcsl` binary is a 32-bit x86 Linux ELF that listens
on a TCP socket for APDU exchange using Oracle's RAW wire protocol.

The simrs project provides tooling to discover, configure, and drive the
Oracle simulator for differential testing against the simrs `GpCard`
implementation:

- **`simrs-jcsl`** (`../simrs/tools/simrs-jcsl/`) -- Rust crate providing
  jcsl binary discovery, binary patching (SCP keys + Global PIN), process
  management, and a TCP client implementing `simrs_transport::Transport`.

- **`simrs-differential-tests`** (`../simrs/tools/simrs-differential-tests/`) --
  Sends identical APDU sequences to both simrs and the Oracle reference
  simulator, comparing responses byte-for-byte.

- **`jvac`** (`../simrs/tools/jvac/`) -- JVA smartcard applet compiler.
  Accepts `.java`/`.jva` source and `.class`/`.jvc` classfiles, produces `.cap`
  output.

- **Oracle SDK samples and scripts** (`../simrs/tools/oracle-jcvm-ref/`) --
  Unpacked Oracle Java Card Development Kit Simulator contents including sample
  applets (HelloWorld, Wallet, Channels, etc.), the `Configurator.jar` tool,
  and build/run shell scripts. Requires `JAVA_HOME` (JDK 17),
  `JC_HOME_SIMULATOR`, and `JC_HOME_TOOLS` environment variables.

### Obtaining the Oracle SDK

The jcsl simulator is available at no cost from Oracle (requires an Oracle
account):

1. Visit https://www.oracle.com/java/technologies/javacard-sdk-downloads.html
2. Download the "Java Card Development Kit Simulator" for Linux x86
3. Extract the archive: `unzip java_card_kit-classic-*.zip -d /tmp/jcdk`
4. Install into the simrs cache: `cargo run -p simrs-jcsl -- install /tmp/jcdk`

This copies the runtime files to `~/.cache/simrs/` where they are automatically
discovered by the test harness. Alternatively, set `SIMRS_JCSL_BINARY` to
point directly at the `jcsl` binary.

Note: the jcsl binary is a 32-bit x86 Linux ELF. On 64-bit systems you may
need 32-bit compatibility libraries (`libc6-i386` or equivalent).
