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
        ;location - uuv
        image
        sample
        sonar_scan
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
        (at ?uuv ?location)
        (connected ?location1 ?location2)
        (image_taken ?uuv ?location)
        (scan_taken ?uuv ?location)
        (sample_collected ?uuv ?location)
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

    (:action action_name
        :parameters ()
        :precondition (and)
        :effect (and)
    )

)