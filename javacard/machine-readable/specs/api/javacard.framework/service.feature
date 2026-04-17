@v3.0.5 @v3.1 @v3.2
Feature: Service Framework (javacard.framework.service)
  The service sub-package provides a framework for building APDU
  processing services. The Service interface defines the processing
  contract. BasicService provides a concrete base implementation.
  Dispatcher manages routing APDUs to registered services.
  ServiceException reports service-layer errors.
  SecurityService, RemoteService, RMIService, and CardRemoteObject
  support security assessment and remote method invocation.

  # ===================================================================
  # Service Interface
  # ===================================================================

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, processDataIn](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/Service.html#processDataIn(APDU)
  # Source: [JavaCard 3.1 API, processDataIn](../../refs/javadoc-3.1/api_classic/javacard/framework/service/Service.html#processDataIn(APDU)
  # Source: [JavaCard 3.2 API, processDataIn](../../refs/javadoc-3.2/api_classic/javacard/framework/service/Service.html#processDataIn(APDU)
  Scenario: Service.processDataIn preprocesses incoming APDU data
    Given a Service implementation
    When processDataIn(apdu) is called
    Then the service processes incoming command data
    And returns true if the APDU has been processed, false otherwise

  # Source: [JavaCard 3.0.5 API, processCommand](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/Service.html#processCommand(APDU)
  # Source: [JavaCard 3.1 API, processCommand](../../refs/javadoc-3.1/api_classic/javacard/framework/service/Service.html#processCommand(APDU)
  # Source: [JavaCard 3.2 API, processCommand](../../refs/javadoc-3.2/api_classic/javacard/framework/service/Service.html#processCommand(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: Service.processCommand handles the APDU command
    Given a Service implementation
    When processCommand(apdu) is called
    Then the service performs the command processing
    And returns true if the command has been processed, false otherwise

  # Source: [JavaCard 3.0.5 API, processDataOut](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/Service.html#processDataOut(APDU)
  # Source: [JavaCard 3.1 API, processDataOut](../../refs/javadoc-3.1/api_classic/javacard/framework/service/Service.html#processDataOut(APDU)
  # Source: [JavaCard 3.2 API, processDataOut](../../refs/javadoc-3.2/api_classic/javacard/framework/service/Service.html#processDataOut(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: Service.processDataOut postprocesses outgoing APDU data
    Given a Service implementation
    When processDataOut(apdu) is called
    Then the service processes outgoing response data
    And returns true if the APDU has been processed, false otherwise

  # ===================================================================
  # BasicService Class
  # ===================================================================

  # -------------------------------------------------------------------
  # Constructor
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, BasicService](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html)
  # Source: [JavaCard 3.1 API, BasicService](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html)
  # Source: [JavaCard 3.2 API, BasicService](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService default constructor
    When a BasicService is constructed
    Then a new BasicService instance is created

  # -------------------------------------------------------------------
  # APDU Header Access Methods
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getCLA](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#getCLA(APDU)
  # Source: [JavaCard 3.1 API, getCLA](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#getCLA(APDU)
  # Source: [JavaCard 3.2 API, getCLA](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#getCLA(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.getCLA returns the CLA byte
    Given an APDU with CLA byte 0x00
    When getCLA(apdu) is called
    Then the return value is 0x00

  # Source: [JavaCard 3.0.5 API, getINS](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#getINS(APDU)
  # Source: [JavaCard 3.1 API, getINS](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#getINS(APDU)
  # Source: [JavaCard 3.2 API, getINS](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#getINS(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.getINS returns the INS byte
    Given an APDU with INS byte 0xA4
    When getINS(apdu) is called
    Then the return value is 0xA4

  # Source: [JavaCard 3.0.5 API, getP1](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#getP1(APDU)
  # Source: [JavaCard 3.1 API, getP1](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#getP1(APDU)
  # Source: [JavaCard 3.2 API, getP1](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#getP1(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.getP1 returns the P1 byte
    Given an APDU with P1 byte 0x04
    When getP1(apdu) is called
    Then the return value is 0x04

  # Source: [JavaCard 3.0.5 API, getP2](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#getP2(APDU)
  # Source: [JavaCard 3.1 API, getP2](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#getP2(APDU)
  # Source: [JavaCard 3.2 API, getP2](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#getP2(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.getP2 returns the P2 byte
    Given an APDU with P2 byte 0x00
    When getP2(apdu) is called
    Then the return value is 0x00

  # -------------------------------------------------------------------
  # Status and Processing State Methods
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, selectingApplet](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#selectingApplet)
  # Source: [JavaCard 3.1 API, selectingApplet](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#selectingApplet)
  # Source: [JavaCard 3.2 API, selectingApplet](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#selectingApplet)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.selectingApplet checks if applet is being selected
    Given a SELECT APDU that is selecting the current applet
    When selectingApplet() is called
    Then the result is true

  # Source: [JavaCard 3.0.5 API, isProcessed](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#isProcessed(APDU)
  # Source: [JavaCard 3.1 API, isProcessed](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#isProcessed(APDU)
  # Source: [JavaCard 3.2 API, isProcessed](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#isProcessed(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.isProcessed checks if APDU has been processed
    Given an APDU that has not been marked as processed
    When isProcessed(apdu) is called
    Then the result is false

  # Source: [JavaCard 3.0.5 API, setProcessed](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#setProcessed(APDU)
  # Source: [JavaCard 3.1 API, setProcessed](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#setProcessed(APDU)
  # Source: [JavaCard 3.2 API, setProcessed](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#setProcessed(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.setProcessed marks APDU as processed
    Given an APDU
    When setProcessed(apdu) is called
    Then isProcessed(apdu) returns true

  # Source: [JavaCard 3.0.5 API, getStatusWord](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#getStatusWord(APDU)
  # Source: [JavaCard 3.1 API, getStatusWord](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#getStatusWord(APDU)
  # Source: [JavaCard 3.2 API, getStatusWord](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#getStatusWord(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.getStatusWord returns the current status word
    Given an APDU with status word set to 0x9000
    When getStatusWord(apdu) is called
    Then the return value is 0x9000

  # Source: [JavaCard 3.0.5 API, setStatusWord](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#setStatusWord(APDU,short)
  # Source: [JavaCard 3.1 API, setStatusWord](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#setStatusWord(APDU,short)
  # Source: [JavaCard 3.2 API, setStatusWord](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#setStatusWord(APDU,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.setStatusWord sets the status word
    Given an APDU
    When setStatusWord(apdu, 0x6A82) is called
    Then getStatusWord(apdu) returns 0x6A82

  # Source: [JavaCard 3.0.5 API, getOutputLength](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#getOutputLength(APDU)
  # Source: [JavaCard 3.1 API, getOutputLength](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#getOutputLength(APDU)
  # Source: [JavaCard 3.2 API, getOutputLength](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#getOutputLength(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.getOutputLength returns the output data length
    Given an APDU with output length set to 10
    When getOutputLength(apdu) is called
    Then the return value is 10

  # Source: [JavaCard 3.0.5 API, setOutputLength](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#setOutputLength(APDU,short)
  # Source: [JavaCard 3.1 API, setOutputLength](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#setOutputLength(APDU,short)
  # Source: [JavaCard 3.2 API, setOutputLength](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#setOutputLength(APDU,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.setOutputLength sets the output data length
    Given an APDU
    When setOutputLength(apdu, 20) is called
    Then getOutputLength(apdu) returns 20

  # -------------------------------------------------------------------
  # Convenience Methods
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, succeed](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#succeed(APDU)
  # Source: [JavaCard 3.1 API, succeed](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#succeed(APDU)
  # Source: [JavaCard 3.2 API, succeed](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#succeed(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.succeed marks APDU as successfully processed
    Given an APDU
    When succeed(apdu) is called
    Then the APDU is marked as processed
    And the status word is set to SW_NO_ERROR (0x9000)

  # Source: [JavaCard 3.0.5 API, succeedWithStatusWord](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#succeedWithStatusWord(APDU,short)
  # Source: [JavaCard 3.1 API, succeedWithStatusWord](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#succeedWithStatusWord(APDU,short)
  # Source: [JavaCard 3.2 API, succeedWithStatusWord](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#succeedWithStatusWord(APDU,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.succeedWithStatusWord marks processed with custom SW
    Given an APDU
    When succeedWithStatusWord(apdu, 0x6100) is called
    Then the APDU is marked as processed
    And the status word is set to 0x6100

  # Source: [JavaCard 3.0.5 API, fail](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#fail(APDU,short)
  # Source: [JavaCard 3.1 API, fail](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#fail(APDU,short)
  # Source: [JavaCard 3.2 API, fail](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#fail(APDU,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.fail marks APDU as failed with status word
    Given an APDU
    When fail(apdu, 0x6A80) is called
    Then the APDU is marked as processed
    And the status word is set to 0x6A80

  # Source: [JavaCard 3.0.5 API, receiveInData](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#receiveInData(APDU)
  # Source: [JavaCard 3.1 API, receiveInData](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#receiveInData(APDU)
  # Source: [JavaCard 3.2 API, receiveInData](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#receiveInData(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.receiveInData receives incoming data
    Given an APDU with incoming data
    When receiveInData(apdu) is called
    Then incoming data bytes are received into the APDU buffer
    And the number of bytes received is returned

  # -------------------------------------------------------------------
  # Default Service Method Implementations
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, processCommand](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#processCommand(APDU)
  # Source: [JavaCard 3.1 API, processCommand](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#processCommand(APDU)
  # Source: [JavaCard 3.2 API, processCommand](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#processCommand(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.processCommand default returns false
    Given the base BasicService.processCommand implementation
    When processCommand(apdu) is called
    Then the result is false

  # Source: [JavaCard 3.0.5 API, processDataIn](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#processDataIn(APDU)
  # Source: [JavaCard 3.1 API, processDataIn](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#processDataIn(APDU)
  # Source: [JavaCard 3.2 API, processDataIn](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#processDataIn(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.processDataIn default returns false
    Given the base BasicService.processDataIn implementation
    When processDataIn(apdu) is called
    Then the result is false

  # Source: [JavaCard 3.0.5 API, processDataOut](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/BasicService.html#processDataOut(APDU)
  # Source: [JavaCard 3.1 API, processDataOut](../../refs/javadoc-3.1/api_classic/javacard/framework/service/BasicService.html#processDataOut(APDU)
  # Source: [JavaCard 3.2 API, processDataOut](../../refs/javadoc-3.2/api_classic/javacard/framework/service/BasicService.html#processDataOut(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: BasicService.processDataOut default returns false
    Given the base BasicService.processDataOut implementation
    When processDataOut(apdu) is called
    Then the result is false

  # ===================================================================
  # Dispatcher Class
  # ===================================================================

  # -------------------------------------------------------------------
  # Phase Constants
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, Dispatcher ](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/Dispatcher.html#Dispatcher(fieldsummary)
  # Source: [JavaCard 3.1 API, Dispatcher ](../../refs/javadoc-3.1/api_classic/javacard/framework/service/Dispatcher.html#Dispatcher(fieldsummary)
  # Source: [JavaCard 3.2 API, Dispatcher ](../../refs/javadoc-3.2/api_classic/javacard/framework/service/Dispatcher.html#Dispatcher(fieldsummary)
  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: Dispatcher phase constants
    When the constant Dispatcher.<constant_name> is accessed
    Then it represents processing phase "<description>"

    Examples:
      | constant_name      | description                        |
      | PROCESS_NONE       | No processing phase                |
      | PROCESS_INPUT_DATA | Input data preprocessing phase     |
      | PROCESS_COMMAND    | Command processing phase           |
      | PROCESS_OUTPUT_DATA| Output data postprocessing phase   |

  # -------------------------------------------------------------------
  # Constructor: Dispatcher(short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, Dispatcher](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/Dispatcher.html#Dispatcher(short)
  # Source: [JavaCard 3.1 API, Dispatcher](../../refs/javadoc-3.1/api_classic/javacard/framework/service/Dispatcher.html#Dispatcher(short)
  # Source: [JavaCard 3.2 API, Dispatcher](../../refs/javadoc-3.2/api_classic/javacard/framework/service/Dispatcher.html#Dispatcher(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: Dispatcher construction with maximum service count
    When a Dispatcher is constructed with maxServices 5
    Then the Dispatcher is created with capacity for 5 services

  # -------------------------------------------------------------------
  # Method: addService(Service, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, addService](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/Dispatcher.html#addService(Service,byte)
  # Source: [JavaCard 3.1 API, addService](../../refs/javadoc-3.1/api_classic/javacard/framework/service/Dispatcher.html#addService(Service,byte)
  # Source: [JavaCard 3.2 API, addService](../../refs/javadoc-3.2/api_classic/javacard/framework/service/Dispatcher.html#addService(Service,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: addService registers a service for a processing phase
    Given a Dispatcher and a Service implementation
    When addService(service, PROCESS_COMMAND) is called
    Then the service is registered for the command processing phase

  # Source: [JavaCard 3.0.5 API, addService](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/Dispatcher.html#addService(Service,byte)
  # Source: [JavaCard 3.1 API, addService](../../refs/javadoc-3.1/api_classic/javacard/framework/service/Dispatcher.html#addService(Service,byte)
  # Source: [JavaCard 3.2 API, addService](../../refs/javadoc-3.2/api_classic/javacard/framework/service/Dispatcher.html#addService(Service,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: addService throws ServiceException when dispatch table is full
    Given a Dispatcher with all service slots occupied
    When addService is called with another service
    Then a ServiceException is thrown with reason DISPATCH_TABLE_FULL

  # -------------------------------------------------------------------
  # Method: removeService(Service, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, removeService](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/Dispatcher.html#removeService(Service,byte)
  # Source: [JavaCard 3.1 API, removeService](../../refs/javadoc-3.1/api_classic/javacard/framework/service/Dispatcher.html#removeService(Service,byte)
  # Source: [JavaCard 3.2 API, removeService](../../refs/javadoc-3.2/api_classic/javacard/framework/service/Dispatcher.html#removeService(Service,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: removeService unregisters a service from a phase
    Given a service registered for PROCESS_COMMAND
    When removeService(service, PROCESS_COMMAND) is called
    Then the service is removed from the command processing phase

  # -------------------------------------------------------------------
  # Method: dispatch(APDU, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, dispatch](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/Dispatcher.html#dispatch(APDU,byte)
  # Source: [JavaCard 3.1 API, dispatch](../../refs/javadoc-3.1/api_classic/javacard/framework/service/Dispatcher.html#dispatch(APDU,byte)
  # Source: [JavaCard 3.2 API, dispatch](../../refs/javadoc-3.2/api_classic/javacard/framework/service/Dispatcher.html#dispatch(APDU,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: dispatch routes APDU through registered services for a phase
    Given services registered for PROCESS_INPUT_DATA and PROCESS_COMMAND
    When dispatch(command, PROCESS_INPUT_DATA) is called
    Then the APDU is dispatched to input data services in order

  # -------------------------------------------------------------------
  # Method: process(APDU)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, process](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/Dispatcher.html#process(APDU)
  # Source: [JavaCard 3.1 API, process](../../refs/javadoc-3.1/api_classic/javacard/framework/service/Dispatcher.html#process(APDU)
  # Source: [JavaCard 3.2 API, process](../../refs/javadoc-3.2/api_classic/javacard/framework/service/Dispatcher.html#process(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: process dispatches APDU through all three phases
    Given services registered for all processing phases
    When process(command) is called
    Then the APDU is routed through input data, command, and output data phases

  # ===================================================================
  # ServiceException (extends CardRuntimeException)
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, ServiceException ](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/ServiceException.html#ServiceException(fieldsummary)
  # Source: [JavaCard 3.1 API, ServiceException ](../../refs/javadoc-3.1/api_classic/javacard/framework/service/ServiceException.html#ServiceException(fieldsummary)
  # Source: [JavaCard 3.2 API, ServiceException ](../../refs/javadoc-3.2/api_classic/javacard/framework/service/ServiceException.html#ServiceException(fieldsummary)
  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: ServiceException reason code constants
    When the constant ServiceException.<reason_name> is accessed
    Then it represents the service error condition "<description>"

    Examples:
      | reason_name                | description                                         |
      | ILLEGAL_PARAM              | Illegal parameter value                             |
      | DISPATCH_TABLE_FULL        | Dispatch table is full                              |
      | COMMAND_DATA_TOO_LONG      | Command data too long for buffer                    |
      | COMMAND_IS_FINISHED        | Command has already been finished/processed          |
      | CANNOT_ACCESS_IN_COMMAND   | Cannot access APDU data during input processing     |
      | CANNOT_ACCESS_OUT_COMMAND  | Cannot access APDU data during output processing    |
      | REMOTE_OBJECT_NOT_EXPORTED | Remote object is not exported                       |

  # Source: [JavaCard 3.0.5 API, ServiceException](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/ServiceException.html#ServiceException(short)
  # Source: [JavaCard 3.1 API, ServiceException](../../refs/javadoc-3.1/api_classic/javacard/framework/service/ServiceException.html#ServiceException(short)
  # Source: [JavaCard 3.2 API, ServiceException](../../refs/javadoc-3.2/api_classic/javacard/framework/service/ServiceException.html#ServiceException(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: ServiceException construction with reason code
    When a ServiceException is constructed with reason ILLEGAL_PARAM
    Then the exception is created with that reason code

  # Source: [JavaCard 3.0.5 API, throwIt](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/ServiceException.html#throwIt(short)
  # Source: [JavaCard 3.1 API, throwIt](../../refs/javadoc-3.1/api_classic/javacard/framework/service/ServiceException.html#throwIt(short)
  # Source: [JavaCard 3.2 API, throwIt](../../refs/javadoc-3.2/api_classic/javacard/framework/service/ServiceException.html#throwIt(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: ServiceException.throwIt throws JCRE-owned instance
    When ServiceException.throwIt(ServiceException.DISPATCH_TABLE_FULL) is called
    Then a JCRE-owned ServiceException is thrown with reason DISPATCH_TABLE_FULL

  # ===================================================================
  # SecurityService Interface
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, SecurityService](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/SecurityService.html)
  # Source: [JavaCard 3.1 API, SecurityService](../../refs/javadoc-3.1/api_classic/javacard/framework/service/SecurityService.html)
  # Source: [JavaCard 3.2 API, SecurityService](../../refs/javadoc-3.2/api_classic/javacard/framework/service/SecurityService.html)
  @v3.0.5 @v3.1 @v3.2
  Scenario: SecurityService extends Service for security assessment
    Given the SecurityService interface
    Then it extends Service
    And it provides methods to query authentication and confidentiality properties

  # ===================================================================
  # RemoteService Interface
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, RemoteService](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/RemoteService.html)
  # Source: [JavaCard 3.1 API, RemoteService](../../refs/javadoc-3.1/api_classic/javacard/framework/service/RemoteService.html)
  # Source: [JavaCard 3.2 API, RemoteService](../../refs/javadoc-3.2/api_classic/javacard/framework/service/RemoteService.html)
  @v3.0.5 @v3.1 @v3.2
  Scenario: RemoteService extends Service for remote method invocation
    Given the RemoteService interface
    Then it extends Service
    And it marks services that process remote method invocations

  # ===================================================================
  # RMIService Class
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, RMIService](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/RMIService.html)
  # Source: [JavaCard 3.1 API, RMIService](../../refs/javadoc-3.1/api_classic/javacard/framework/service/RMIService.html)
  # Source: [JavaCard 3.2 API, RMIService](../../refs/javadoc-3.2/api_classic/javacard/framework/service/RMIService.html)
  @v3.0.5 @v3.1 @v3.2
  Scenario: RMIService implements RemoteService for Java Card RMI
    Given the RMIService class
    Then it implements RemoteService
    And it processes Java Card RMI requests

  # ===================================================================
  # CardRemoteObject Class
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, CardRemoteObject](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/service/CardRemoteObject.html)
  # Source: [JavaCard 3.1 API, CardRemoteObject](../../refs/javadoc-3.1/api_classic/javacard/framework/service/CardRemoteObject.html)
  # Source: [JavaCard 3.2 API, CardRemoteObject](../../refs/javadoc-3.2/api_classic/javacard/framework/service/CardRemoteObject.html)
  @v3.0.5 @v3.1 @v3.2
  Scenario: CardRemoteObject enables remote access to card-side objects
    Given an object extending CardRemoteObject
    Then it can be exported for remote method invocation
    And clients can invoke its methods via the RMI framework
