(define (problem windfarm-mission-1)
    (:domain windfarm)

    (:objects
        ;Declaring the objects used in this problem
        uuv1 - uuv
        wp1 wp2 wp3 wp4 - location
        ship1 - ship
    )
    ; The UUV begins its journey from the ship.
    ; Use the map in Figure 3 to configure connections and paths between waypoints.
    ; Mission Goals:
    ; Save an image at waypoint 3.
    ; Save a sonar scan at waypoint 4
    (:init
        (uuv_docked uuv1 ship1);uuv1 starts docked at ship1
        (at ship1 wp1);the ship is at wp1
        (connected wp1 wp2);waypoints are connected according to the figure
        (connected wp2 wp1)
        (connected wp2 wp3)
        (connected wp3 wp4)
        (connected wp4 wp3)
        (connected wp4 wp1)
        (memory_empty uuv1);uuv memory is empty initially
        (with uuv1 ship1);uuv1 is associated with ship1

    )

    (:goal
        (and
            (image_taken uuv1 wp3);Image should be taken at wp1 with uuv1

            (scan_taken uuv1 wp4);Scan should be taken at wp4 with uuv1

            (memory_empty uuv1);emptying the uuv memory so the last data part is transmitted
        )
    )
)