(define (domain windfarm)
    (:requirements :strips :typing)

    ; -------------------------------
    ; Types
    ; -------------------------------

    ; EXAMPLE

    ; (:types
    ;     parent_type
    ;     child_type - parent_type

    ; )
    (:types
        location
        uuv
        gripper - uuv
        ;location - uuv
        image
        camera - uuv
        sample
        sonar_scan
        scanner - uvv
        ship
        ;location - ship
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
        (uuv_exists ?uuv - uuv)
        (uuv_docked ?uuv - uuv ?ship - ship)
        (uuv_deployed ?uuv - uuv)

        (at ?uuv ?location)
        (connected ?location1 ?location2)

        (memory_empty ?uuv - uuv)
        (storage_empty ?uuv - uuv)

        (ship_storage_empty ?ship - ship)

        (image_taken ?uuv ?location ?camera)
        (camera_working ?camera - camera)

        (scan_taken ?uuv ?location ?scanner)
        (scanner_working ?scanner - scanner)

        (sample_availabe ?location)
        (gripper_functionable ?gripper - gripper)
        (gripper_holding_sample)
        (sample_collected ?uuv ?location)

        (data_transmitted ?uuv ?ship)
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

    (:action moving
        :parameters (?uuv - uuv ?location1 - location ?location2 - location)
        :precondition 
            (and
                (uuv_exists ?uuv-uuv)
                (at uuv ?location1)
                (connected ?location1 ?location2)
            )
        :effect 
            (and
                (at uuv ?location2)
                (not(at uuv ?location1))
            )
    )

    (:action image
        :parameters (?uuv - uuv ?camera - camera ?location - location)
        :precondition 
            (and
                (uuv_exists ?uvv - uuv)
                (at uuv ?location)
                (memory_empty ?uuv - uuv)
                (camera_working ?camera)
            )
        :effect 
            (and
                (image_taken ?uuv ?location)
                (not(memory_empty))
            )
    )

    (:action sonar_scan
        :parameters (?uuv - uuv ?location - location ?scanner - scanner)
        :precondition 
            (and
                (uuv_exists ?uuv - uuv)
                (at uuv ?location)
                (memory_empty ?uuv - uuv)
                (scanner_working ?scanner)
            )
        :effect 
            (and
                (scan_taken ?uuv ?location)
                (not(memory_empty))
            )
    )

    (:action sample
        :parameters (?uuv - uuv ?location - location ?gripper - gripper ?sample - sample)
        :precondition 
            (and
                (uuv_exists ?uuv - uuv)
                (at uuv ?location)
                (storage_empty ?uuv - uuv)
                (ship_storage_empty ?ship)
                (sample_availabe)
                (gripper_functionable ?gripper)
            )
        :effect 
            (and
                (gripper_holding_sample ?gripper)
                (not(sample_availabe))
            )
    )

    (:action store_sample
        :parameters (?uuv - uuv ?gripper - gripper ?sample - sample)
        :precondition 
            (and
                (gripper_holding_sample ?gripper)
                (storage_empty ?uuv - uuv)
            )
        :effect 
        (and
            (not(storage_empty ?uuv - uuv))
            (not(gripper_holding_sample))
        )
    )

    (:action deploy_uuv
        :parameters (?uuv - uuv ?ship - ship)
        :precondition 
            (and
                (uuv_exists ?uuv - uuv)
                (uuv_docked ?uuv - uuv ?ship - ship)
            )
        :effect 
            (and
                (not(uuv_docked ?uuv ?ship))
                (uuv_deployed)
                (storage_empty ?uuv)
                (not(gripper_holding_sample ?uuv ?gripper))
                (memory_empty ?uuv)
            )
    )

    (:action dock_uuv
        :parameters (?uuv - uuv ?ship - ship)
        :precondition 
            (and
                (uuv_exists ?uuv - uuv)
                (uuv_deployed ?uuv)
                (at ?uuv ?ship)
            )
        :effect 
            (and
                (uuv_docked ?uuv ?ship)
                (not(uuv_deployed ?uuv))
            )
    )

    (:action sample_delivery
        :parameters (?uuv - uuv ?ship - ship)
        :precondition 
            (and
                (uuv_exists ?uuv - uuv)
                (uuv_docked ?uuv ?ship)
                (not(storage_empty))
                (ship_storage_empty)
            )
        :effect 
            (and
                (storage_empty ?uuv)
                (not(ship_storage_empty))
            )
    )

    (:action transmit_data
        :parameters (?uuv - uuv ?ship - ship)
        :precondition 
            (and
                (uuv_exists ?uuv - uuv)
                (not(memory_empty ?uuv))
            )
        :effect 
            (and
                (memory_empty ?uuv)
                (data_transmitted ?uuv ?ship)
            )
    )

)