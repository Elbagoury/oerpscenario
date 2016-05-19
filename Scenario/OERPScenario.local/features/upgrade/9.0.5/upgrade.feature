# -*- coding: utf-8 -*-
@upgrade_from_9.0.4
Feature: upgrade to 9.0.5

  Scenario: upgrade
    Given I update the module list
    Given I install the required modules with dependencies:
      | name                       |
      | specific_product           |
    Then my modules should have been installed and models reloaded

  Scenario Outline: Create a delivery method for postlogistics
    Given I need a "delivery.carrier" with oid: <oid>
    And having:
      | name                           | value                                                      |
      | name                           | <name>                                                     |
      | type                           | postlogistics                                              |
      | partner_id                     | by oid: delivery_carrier_label_postlogistics.postlogistics |
      | postlogistics_service_group_id | by name: <service_group>                                   |
      | postlogistics_license_id       | by oid: scenario.postlogistics_<license>                   |

  Examples:
    | oid                            | name               | license  | service_group                 |
    | scenario.carrier_post_eco      | Post Economy       | license1 | Parcel                        |
    | scenario.carrier_post_pri      | Post Priority      | license1 | Parcel                        |
    | scenario.carrier_post_moon     | Post Express Mond  | license1 | Swiss-Express / Swiss-Courier |
    | scenario.carrier_post_lighting | Post Express Blitz | license1 | Swiss-Express / Swiss-Courier |
    | scenario.carrier_post_promo    | PostPac Promo      | license2 | Parcel                        |

  Scenario Outline: I setup a postlogistic carrier options
    Given I need a "delivery.carrier.option" with oid: <oid>
    And having:
      | name           | value             |
      | carrier_id     | by oid: <carrier> |
      | tmpl_option_id | by code: <option> |
      | mandatory      | 1                 |
      | by_default     | 1                 |

  Examples:
    | oid                                     | carrier                        | option |
    | scenario.carrier_option_post_eco_1      | scenario.carrier_post_eco      | ECO    |
    | scenario.carrier_option_post_pri_1      | scenario.carrier_post_pri      | PRI    |
    | scenario.carrier_option_post_moon_1     | scenario.carrier_post_moon     | SEM    |
    | scenario.carrier_option_post_lighting_1 | scenario.carrier_post_lighting | SKB    |

  Scenario: upgrade
    Given I set the version of the instance to "9.0.5"
