(define (domain windfarm)
    (:requirements :strips :typing)

    ; -------------------------------
    ; Types
    ; -------------------------------

    ; EXAMPLE

    ; (:types
    ;     parent_type
    ;     child_type - parent_type blocks hand table

    ; )
    (:types
        uuv ship sample engineer location ship_location - object

        bay control_center - ship_location
        ;The types we are using in the domain and problem

        )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    ; EXAMPLE

    ; (:predicates
    ;     (no_arity_predicate)
    ;     (one_arity_predicate ?p - parameter_type)
    ; )

    (:predicates
        (uuv_docked ?uuv ?ship);used to show that the uuv is docked at the ship
        (uuv_deployed ?uuv);used to show that the uuv is deployed into the water

        (at ?uuv ?location);used to show that the uuv is at a location
        (connected ?location1 ?location2) ;used to show that 2 locations are connected and have a path

        (memory_empty ?uuv);used to show that the uuv's meemory is empty
        (memory_full ?uuv);used to show that uuv's memory is not full (could've used memory_empty but helps understand)

        (sample_on_ship ?uuv ?ship ?sample);used to show a sample is already on the ship from a uuv

        (image_taken ?uuv ?location);Shows that image is taken at a location
        (scan_taken ?uuv ?location);Shows that a scan is taken at a location

        (sample_collected ?uuv ?sample);Shows that uuv collected a sample and has it
        (data_transmitted ?uuv ?ship);Shows that data is transmitted from the uuv to the ship

        (with ?uuv ?ship);Shows that uuv is at a ship

        (engineer_at ?engineer - engineer ?ship_location-ship_location);Shows that enginer is at this location on the ship

        (bay ?ship_location - ship_location);bay is a location on the ship
        (control_center ?ship_location - ship_location);conrol center is a location on the ship

        (at_ship ?ship_location ?ship);making sure that a shipp location is on a ship

    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    ; EXAMPLE

    ; (:action action-template
    ;     :parameters (?p - parameter_type)
    ;     :precondition (and
    ;         (one_arity_predicate ?p)
    ;     )
    ;     :effect 
    ;     (and 
    ;         (no_arity_predicate)
    ;         (not (one_arity_predicate ?p))
    ;     )
    ; )

    (:action moving;Action for moving uuv betwen 2 locations
        :parameters (?uuv - uuv ?location1 ?location2);Takes 3 parameters uuv, and 2 locations
        :precondition (and
            (uuv_deployed ?uuv);checks if the uuv is deployed 
            (at ?uuv ?location1);and if the uuv is at the location 1
            (memory_empty ?uuv);Makes sure that uuv's memory is empty transmits data before moving to another location after taking a scan or image
            (connected ?location1 ?location2);the locations must have a path between them to travel
        )
        :effect (and
            (not(at ?uuv ?location1));The uuv is no longer at the first location 
            (at ?uuv ?location2);the uuv is now at the second location
        )
    )

    (:action image;Action to take an image at a specific location
        :parameters (?uuv - uuv ?location - location);Takes 2 parameters uuv and the location
        :precondition (and;The uuv should be deployed
            (at ?uuv ?location);uuv should be at the locatoin to take an image
            (memory_empty ?uuv);The uuv's memory should be empty to store the image
            (not(memory_full ?uuv));The uuv's memory should not be full
        )
        :effect (and
            (memory_full ?uuv);The uuv's memory should be full with the image
            (not(memory_empty ?uuv));The uuv's memory shopuld be empty
            (image_taken ?uuv ?location);The image should be taken at the location
        )
    )

    (:action sonar_scan ;Action to take a scan at a specific location
        :parameters (?uuv - uuv ?location - location);Takes 2 parameters uuv and the location
        :precondition (and
            (uuv_deployed ?uuv);The uuv should be deployed
            (at ?uuv ?location);uuv should be at the location to take a scan
            (memory_empty ?uuv);The uuv's memory should be empty to store the scan
        )
        :effect (and
            (scan_taken ?uuv ?location);The scan should be taken at the location
            (not(memory_empty ?uuv));The uuv's memory should be empty
            (memory_full ?uuv);The uuv's memory should be full with the scan
        )
    )

    (:action sample;Action to collect a sample from a specific location
        :parameters (?uuv - uuv ?location - location ?sample - sample);Takes 3 parameters uuv, sample to be collected and the location 
        :precondition (and
            (uuv_deployed ?uuv);uuv should be deployed
            (at ?uuv ?location);uuv should be at the location to collect sample
            (at ?sample ?location);sample should be present at the location
            (not(sample_collected ?uuv ?sample));sample should not be collected by the uuv already
        )
        :effect (and
            (sample_collected ?uuv ?sample);sample should be collected by the uuv
            (not (at ?sample ?location));sample should not be available at the location anymore
        )
    )

    (:action store_sample;Action to store the sample in the ship
        :parameters (?uuv - uuv ?sample - sample ?ship - ship);Takes 3 parameters uuv, sample to be stored and the ship
        :precondition (and
            (at ?uuv ?ship);uuv should be at the ship location
            (not(sample_on_ship ?uuv ?ship ?sample));sample should not be on the ship 
            (sample_collected ?uuv ?sample);uuv should have the sample 
        )
        :effect (and
            (sample_on_ship ?uuv ?ship ?sample);sample should be on the ship
            (not(sample_collected ?uuv ?sample));uuv should not have the sample anymore
        )
    )

    (:action deploy_uuv;Action to deploy a uuv at a location
        :parameters (?uuv - uuv ?ship - ship ?location - location ?engineer - engineer ?ship_location - ship_location);Takes 5 parameters uuv, ship, location, engineer and ship location(i.e bay and control center)
        :precondition (and
            (uuv_docked ?uuv ?ship);uuv should be docked
            (at ?ship ?location);ship should be at the location
            (engineer_at ?engineer ?ship_location);Engineer should be at the ship_location(i.e bay) to deploy
            (bay ?ship_location);bay is ship location
        )
        :effect (and
            (not(uuv_docked ?uuv ?ship));uuv should not be docked anymore
            (uuv_deployed ?uuv);uuv should be deployed
            (memory_empty ?uuv);the uuv's memory should be empty
            (at ?uuv ?location);the uuv should be at the deployed location
        )
    )

    (:action dock_uuv;Acion to dock a uuv on a ship
        :parameters (?uuv - uuv ?ship - ship ?location - location ?engineer - engineer ?ship_location - ship_location);Takes 5 parameters uuv, ship, location, engineer and ship location(i.e bay and control center)
        :precondition (and
            (uuv_deployed ?uuv);uuv should be deployed
            (at ?uuv ?ship);uuv should be at the ship
            (engineer_at ?engineer ?ship_location);Engineer should be at the ship_location(i.e bay) to dock
            (at_ship ?ship_location ?ship);ship location is on the ship
            (bay ?ship_location);bay is ship location
        )
        :effect (and
            (uuv_docked ?uuv ?ship);uuv should be docked
            (not(uuv_deployed ?uuv));uuv should not be deployed anymore
        )
    )

    (:action transmit_data;Action to transmit the data to the ship
        :parameters (?uuv - uuv ?ship - ship ?location - location ?engineer - engineer ?ship_location - ship_location);Takes 5 parameters uuv, ship, location, engineer, and ship lcoation
        :precondition (and
            (at ?uuv ?location);uuv is at the location
            (not(memory_empty ?uuv));uuv's memory should not be empty
            (memory_full ?uuv);uuv's memory should not be full
            (with ?uuv ?ship);uuv should be associated to a ship (eg uuv1 to ship1 and uuv2 to ship2)
            (control_center ?ship_location);control_center is a ship location
            (at_ship ?ship_location ?ship);ship location is on the ship
            (engineer_at ?engineer ?ship_location);Engineer should be at the ship_location(i.e control_center) for the data transmission
        )
        :effect (and
            (memory_empty ?uuv);uuv's memory should be empty after data transmission
            (not (memory_full ?uuv));uuv's memory should not be full
            (data_transmitted ?uuv ?ship);the data should be transmitted
        )
    )

    (:action move_engineer
        :parameters (?engineer - engineer ?ship_location1 - ship_location ?ship_location2 - ship_location ?ship - ship);Takes 4 parameters engineer, 2 ship locations and ship
        :precondition (and
            (engineer_at ?engineer ?ship_location1);Engineer should be at the first ship location
            (connected ?location1 ?location2);ship location 1 and ship location 2 should be connected
        )
        :effect (and
            (engineer_at ?engineer ?ship_location2);Engineer should be at the second ship location
            (not(engineer_at ?engineer ?ship_location1));Engineer should no longer be at the first ship location
        )
    )

)