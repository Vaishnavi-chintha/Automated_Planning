(define (problem windfarm-mission-2)
    (:domain windfarm)

    (:objects
        uuv1 - uuv
        wp1 wp2 wp3 wp4 wp5 - location
        ship1 - ship
        sample1 - sample
    )

    (:init
        (uuv_docked uuv1 ship1)
        (at ship1 wp1)
        (connected wp1 wp2)
        (connected wp2 wp3)
        (connected wp4 wp3)
        (connected wp1 wp4)
        (connected wp3 wp5)
        (connected wp5 wp1)
        (connected wp1 ship1)

        (at sample1 wp1)

        (memory_empty uuv1)

        (associated_with uuv1 ship1)
    )

    (:goal
        (and

            (sample_on_ship uuv1 ship1 sample1)
            ;(not(sample_collected uuv1 sample1))

            (image_taken uuv1 wp5)
            ;(data_transmitted uuv1 ship1)

            ;(memory_empty uuv1)

            (scan_taken uuv1 wp3)
            ;(data_transmitted uuv1 ship1)

        )
    )
)