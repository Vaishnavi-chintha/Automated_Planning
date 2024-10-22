(define (problem windfarm-mission-1)
    (:domain windfarm)

    (:objects
        uuv1 - uuv
        wp1 wp2 wp3 wp4 - location
        ship1 - ship
    )

    (:init
        (uuv_docked uuv1 ship1)
        (at ship1 wp1)
        (connected wp1 wp2)
        (connected wp2 wp1)
        (connected wp2 wp3)
        (connected wp3 wp4)
        (connected wp4 wp3)
        (connected wp4 wp1)
        (memory_empty uuv1)
        (associated_with uuv1 ship1)

    )

    (:goal
        (and
            (image_taken uuv1 wp3)
            ;(data_transmitted uuv1 ship1)

            (scan_taken uuv1 wp4)
            ;(data_transmitted uuv1 ship1)

            (memory_empty uuv1)
        )
    )
)