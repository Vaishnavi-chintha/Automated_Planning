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
        location uuv ship sample - object
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
        (uuv_docked ?uuv ?ship)
        (uuv_deployed ?uuv)

        (at ?uuv ?location)
        (connected ?location1 ?location2)

        (memory_empty ?uuv)
        (memory_full ?uuv)

        (sample_on_ship ?uuv ?ship ?sample)

        (image_taken ?uuv ?location)
        (scan_taken ?uuv ?location)

        (sample_collected ?uuv ?sample)
        (data_transmitted ?uuv ?ship)

        (associated_with ?uuv ?ship)
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
        :parameters (?uuv - uuv ?location1 ?location2)
        :precondition (and
            (uuv_deployed ?uuv)
            (at ?uuv ?location1)
            (memory_empty ?uuv)
            (connected ?location1 ?location2)
        )
        :effect (and
            (not(at ?uuv ?location1))
            (at ?uuv ?location2)
        )
    )

    (:action image
        :parameters (?uuv - uuv ?location - location)
        :precondition (and
            (at ?uuv ?location)
            (memory_empty ?uuv)
            (not(memory_full ?uuv))
        )
        :effect (and
            (memory_full ?uuv)
            (not(memory_empty ?uuv))
            (image_taken ?uuv ?location)
        )
    )

    (:action sonar_scan
        :parameters (?uuv - uuv ?location - location)
        :precondition (and
            (uuv_deployed ?uuv)
            (at ?uuv ?location)
            (memory_empty ?uuv)
        )
        :effect (and
            (scan_taken ?uuv ?location)
            (not(memory_empty ?uuv))
            (memory_full ?uuv)
        )
    )

    (:action sample
        :parameters (?uuv - uuv ?location - location ?sample - sample)
        :precondition (and
            (uuv_deployed ?uuv)
            (at ?uuv ?location)
            (at ?sample ?location)
            (not(sample_collected ?uuv ?sample))
        )
        :effect (and
            (sample_collected ?uuv ?sample)
            (not (at ?sample ?location))
        )
    )

    (:action store_sample
        :parameters (?uuv - uuv ?sample - sample ?ship - ship)
        :precondition (and
            (at ?uuv ?ship)
            (not(sample_on_ship ?uuv ?ship ?sample))
            (sample_collected ?uuv ?sample)
        )
        :effect (and
            (sample_on_ship ?uuv ?ship ?sample)
            (not(sample_collected ?uuv ?sample))
        )
    )

    (:action deploy_uuv
        :parameters (?uuv - uuv ?ship - ship ?location - location)
        :precondition (and
            (uuv_docked ?uuv ?ship)
            (at ?ship ?location)
        )
        :effect (and
            (not(uuv_docked ?uuv ?ship))
            (uuv_deployed ?uuv)
            (memory_empty ?uuv)
            (at ?uuv ?location)
        )
    )

    (:action dock_uuv
        :parameters (?uuv - uuv ?ship - ship)
        :precondition (and
            (uuv_deployed ?uuv)
            (at ?uuv ?ship)
        )
        :effect (and
            (uuv_docked ?uuv ?ship)
            (not(uuv_deployed ?uuv))
        )
    )

    (:action transmit_data
        :parameters (?uuv - uuv ?ship - ship)
        :precondition (and
            (not(memory_empty ?uuv))
            (memory_full ?uuv)
            (associated_with ?uuv ?ship)
        )
        :effect (and
            (memory_empty ?uuv)
            (not (memory_full ?uuv))
            (data_transmitted ?uuv ?ship)
        )
    )
)