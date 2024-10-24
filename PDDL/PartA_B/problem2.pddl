(define (problem windfarm-mission-2)
    (:domain windfarm)
    (:objects
        ;Declaring the objects used in this problem
        uuv1 - uuv
        wp1 wp2 wp3 wp4 wp5 - location
        ship1 - ship
        sample1 - sample
    )
    (:init
        (uuv_docked uuv1 ship1);uuv1 starts docked at ship1
        (at ship1 wp1);the ship is at wp1
        (connected wp1 wp2);waypoints are connected according to the figure
        (connected wp2 wp3)
        (connected wp4 wp3)
        (connected wp1 wp4)
        (connected wp3 wp5)
        (connected wp5 wp1)
        (connected wp1 ship1);wp1 is connected to ship1 so uuv can return to ship
        (at sample1 wp1);the sample is at wp1 
        (memory_empty uuv1);uuv memory is empty initially
        (with uuv1 ship1);uuv1 is associated with ship1
    )

    (:goal
        (and

            (sample_on_ship uuv1 ship1 sample1);the first sample should be on the ship 
            (image_taken uuv1 wp5);Image shoul dbe taken at wp5 with uuv1
            (scan_taken uuv1 wp3);Scan should be taken at wp3 with uuv1
            (memory_empty uuv1);emptying the uuv memory so the last data part is transmitted
        )
    )
)