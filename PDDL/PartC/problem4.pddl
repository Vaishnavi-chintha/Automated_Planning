(define (problem windfarm-mission-4)
    (:domain windfarm)

    (:objects
        uuv1 uuv2 - uuv
        wp1 wp2 wp3 wp4 wp5 wp6 - location
        ship1 ship2 - ship
        sample1 sample2 - sample
        engineer1 engineer2 - engineer
        bay1 bay2 control_center1 control_center2 - location

    )

    ; You have a brave engineer to assist in deploying the robot in the North Sea.
    ; Add locations on the ship: the bay and the control centre. The engineer can walk between
    ; these two locations.
    ; The UUV can only be deployed or return to the ship if the engineer is at the bay.
    ; The UUV can transmit images and scan data only if the engineer is in the control centre.
    ; The first UUV starts deployed at waypoint 2. 
    ; The second UUV starts from the secondary ship. Mission Goals: 
    ; Save an image at waypoint 3
    ; Save a sonar scan at waypoint 4.
    ; Save an image at waypoint 2.
    ; Save a sonar scan at waypoint 6.
    ; Collect a sample from waypoint 5.
    ; Collect a sample from waypoint 1

    (:init
        (uuv_deployed uuv1);uuv1 is deployed at the start
        (at uuv1 wp2);uuv1 ia at wp2

        (at ship1 wp2);ship1 is at wp2

        (uuv_docked uuv2 ship2);uuv2 starts docked at ship2
        (uuv_deployed uuv2);uuv2 gets deployed
        (at uuv2 wp5);uuv2 is at wp5

        (at ship2 wp5);ship2 is at wp5

        (engineer_at engineer1 control_center1);engineer1 is at control center1 
        (engineer_at engineer2 bay2);engineer2 is at bay2

        (at_ship bay1 ship1);bay1 is on ship1
        (at_ship bay2 ship2);bay2 is on ship2

        (at_ship control_center1 ship1);controlcenter1 is on ship1
        (at_ship control_center2 ship2);controlcenter2 is on ship2

        (connected ship1 wp2);ship1 is connected to wp2
        (connected wp2 ship1);wp2 is connected to ship1

        (connected ship2 wp5);ship2 is connected to wp5
        (connected wp5 ship2);wp5 is connected to ship2

        (connected bay1 control_center1);The bay and control center are connected so enginner can walk
        (connected control_center1 bay1)

        (connected bay2 control_center2);The bay and control center are connected so enginner can walk
        (connected control_center2 bay2)

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

            ; (image_taken uuv1 wp3);Image should be taken at wp3 with uuv1
            ; (image_taken uuv1 wp2);Image should be taken at wp2 with uuv1

            ; (memory_empty uuv2);emptying the uuv2 memory so the last data part is transmitted
            ; (memory_empty uuv1);emptying the uuv2 memory so the last data part is transmitted

            ; (scan_taken uuv2 wp4);Scan should be taken at wp4 with uuv2
            ; (scan_taken uuv2 wp6);Scan should be taken at wp6 with uuv2
        )
    )
)