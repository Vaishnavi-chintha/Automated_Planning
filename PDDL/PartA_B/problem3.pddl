(define (problem windfarm-mission-3)
    (:domain windfarm)
    (:objects
        ;Declaring the objects used in this problem
        uuv1 uuv2 - uuv
        wp1 wp2 wp3 wp4 wp5 wp6 - location
        ship1 ship2 - ship
        sample1 sample2 - sample
    )
    (:init
        (uuv_deployed uuv1);uuv1 is deployed at the start
        (at uuv1 wp2);uuv1 ia at wp2
        (at ship1 wp2);ship1 is at wp2
        (at ship2 wp5);ship2 is at wp5
        (uuv_docked uuv2 ship2);uuv2 starts docked at ship2
        (at uuv2 wp5);uuv2 is at wp5
        (connected ship1 wp2);ship1 is connected to wp2
        (connected wp2 ship1);wp2 is connected to ship1
        (connected ship2 wp5);ship2 is connected to wp5
        (connected wp5 ship2);wp5 is connected to ship2
        (connected wp1 wp2);waypoints are connected according to the figure
        (connected wp2 wp1)
        (connected wp2 wp3)
        (connected wp3 wp5)
        (connected wp5 wp3)
        (connected wp5 wp6)
        (connected wp6 wp4)
        (connected wp4 wp2)
        (connected wp2 wp4)
        (at sample2 wp5);sample2 is at wp5
        (at sample1 wp1);sample1 is at wp1
        (with uuv1 ship1);uuv1 is associated with ship1
        (with uuv2 ship2);uuv2 is associated with ship2
        (not(sample_collected uuv1 sample1));sample 1 is not with uuv1 
        (not(sample_collected uuv2 sample2));sample2 is not with uuv2
        (memory_empty uuv1);uuv1 memory is empty initially
        (memory_empty uuv2);uuv2 memory is empty initially
    )
    (:goal
        (and
            (sample_on_ship uuv2 ship2 sample2);sample2 should be on ship2
            (sample_on_ship uuv1 ship1 sample1);sample1 should be on ship1 
            (image_taken uuv1 wp3);Image should be taken at wp3 with uuv1
            (image_taken uuv1 wp2);Image should be taken at wp2 with uuv1
            (memory_empty uuv2);emptying the uuv2 memory so the last data part is transmitted
            (memory_empty uuv1);emptying the uuv2 memory so the last data part is transmitted
            (scan_taken uuv2 wp4);Scan should be taken at wp4 with uuv2
            (scan_taken uuv2 wp6);Scan should be taken at wp6 with uuv2
        )
    )
)