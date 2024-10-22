(define (problem windfarm-mission-3)
    (:domain windfarm)

    (:objects
        uuv1 uuv2 - uuv
        wp1 wp2 wp3 wp4 wp5 wp6 - location
        ship1 ship2 - ship
        sample1 sample2 - sample

    )

    (:init
        (uuv_deployed uuv1)
        (at uuv1 wp2)

        (at ship1 wp2)
        (at ship2 wp5)

        (uuv_docked uuv2 ship2)
        (at uuv2 wp5)

        (connected ship1 wp2)
        (connected wp2 ship1)

        (connected ship2 wp5)
        (connected wp5 ship2)

        (connected wp1 wp2)
        (connected wp2 wp1)
        (connected wp2 wp3)
        (connected wp3 wp5)
        (connected wp5 wp3)
        (connected wp5 wp6)
        (connected wp6 wp4)
        (connected wp4 wp2)
        (connected wp2 wp4)

        (at sample2 wp5)
        (at sample1 wp1)

        (associated_with uuv1 ship1)
        (associated_with uuv2 ship2)

        (not(sample_collected uuv1 sample1))
        (not(sample_collected uuv2 sample2))

        (memory_empty uuv1)
        (memory_empty uuv2)
    )

    (:goal
        (and
            (sample_on_ship uuv2 ship2 sample2)
            (sample_on_ship uuv1 ship1 sample1)

            (image_taken uuv1 wp3)
            (image_taken uuv1 wp2)

            (memory_empty uuv2)
            (memory_empty uuv1)

            (scan_taken uuv2 wp4)
            (scan_taken uuv2 wp6)
        )
    )
)