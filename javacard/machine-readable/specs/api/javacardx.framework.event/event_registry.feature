@javacardx
@javacardx.framework.event
@v3.1
@v3.2
Feature: Event Framework -- EventListener, EventRegistry, EventSource
  The javacardx.framework.event package provides a lightweight event notification
  framework. EventSource objects notify registered EventListener objects through
  the EventRegistry.

  EventListener is a tagging interface for objects that wish to receive events.
  EventSource is a tagging interface for objects that produce events.
  EventRegistry is the central registry for connecting listeners to sources.

  # Source: [JavaCard 3.2 API, event package](../../../refs/javadoc-3.2/api_classic/javacardx/framework/event/package-summary.html)
  Background:
    Given a JavaCard runtime environment

  # ========== EventListener ==========
  Scenario: EventListener is a tagging interface
    Then EventListener is an interface with no methods
    And classes wishing to receive events must implement EventListener

  # Source: [JavaCard 3.2 API, EventListener](../../../refs/javadoc-3.2/api_classic/javacardx/framework/event/EventListener.html)
  # ========== EventSource ==========
  Scenario: EventSource is a tagging interface
    Then EventSource is an interface with no methods
    And classes that produce events must implement EventSource

  # Source: [JavaCard 3.2 API, EventSource](../../../refs/javadoc-3.2/api_classic/javacardx/framework/event/EventSource.html)
  # ========== EventRegistry ==========
  Scenario: EventRegistry.getEventRegistry returns the singleton registry
    When EventRegistry.getEventRegistry() is called
    Then the platform's singleton EventRegistry instance is returned

  # Source: [JavaCard 3.2 API, getEventRegistry](../../../refs/javadoc-3.2/api_classic/javacardx/framework/event/EventRegistry.html#getEventRegistry)
  Scenario: EventRegistry.register registers a listener for a source
    Given the singleton EventRegistry
    When register(EventSource source, EventListener listener) is called
    Then the listener is registered to receive events from the specified source

  # Source: [JavaCard 3.2 API, register](../../../refs/javadoc-3.2/api_classic/javacardx/framework/event/EventRegistry.html#register(EventSource,EventListener))
  Scenario: EventRegistry.unregister removes a listener registration
    Given a previously registered listener-source pair
    When unregister(EventSource source, EventListener listener) is called
    Then the listener is no longer notified of events from the specified source


# Source: [JavaCard 3.2 API, unregister](../../../refs/javadoc-3.2/api_classic/javacardx/framework/event/EventRegistry.html#unregister(EventSource,EventListener))