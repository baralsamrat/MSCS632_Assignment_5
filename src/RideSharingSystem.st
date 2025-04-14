"-------------------- Ride Class --------------------"
Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

Ride >> initializeWithID: anID pickup: aPickup dropoff: aDropoff distance: aDistance
    rideID := anID.
    pickupLocation := aPickup.
    dropoffLocation := aDropoff.
    distance := aDistance.

Ride >> fare
    "Default fare: $1 per mile"
    ^ distance * 1.

Ride >> rideDetails
    ^ 'Ride ID: ', rideID asString,
      ' from ', pickupLocation,
      ' to ', dropoffLocation,
      ' | Fare: $', (self fare) asString.

"-------------------- StandardRide Subclass --------------------"
Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

StandardRide >> fare
    "Standard ride rate: $1 per mile"
    ^ distance * 1.

"-------------------- PremiumRide Subclass --------------------"
Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

PremiumRide >> fare
    "Premium ride rate: $2 per mile"
    ^ distance * 2.

"-------------------- Driver Class --------------------"
Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

Driver >> initializeWithID: anID name: aName rating: aRating
    driverID := anID.
    name := aName.
    rating := aRating.
    assignedRides := OrderedCollection new.

Driver >> addRide: aRide
    "Only allow modification of assignedRides via this method"
    assignedRides add: aRide.

Driver >> getDriverInfo
    ^ 'Driver ID: ', driverID asString,
      ' | Name: ', name,
      ' | Rating: ', rating asString.

Driver >> showAssignedRides
    ^ assignedRides collect: [:ride | ride rideDetails].

"-------------------- Rider Class --------------------"
Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    poolDictionaries: ''
    category: 'RideSharing'.

Rider >> initializeWithID: anID name: aName
    riderID := anID.
    name := aName.
    requestedRides := OrderedCollection new.

Rider >> requestRide: aRide
    requestedRides add: aRide.

Rider >> viewRides
    ^ requestedRides collect: [:ride | ride rideDetails].

"-------------------- Example Usage --------------------"
| rides driver rider |
rides := OrderedCollection new.
rides add: (StandardRide new initializeWithID: 1 pickup: 'Central Park' dropoff: 'Times Square' distance: 5).
rides add: (PremiumRide new initializeWithID: 2 pickup: 'Wall Street' dropoff: 'Brooklyn Bridge' distance: 10).

driver := Driver new initializeWithID: 101 name: 'Alice Johnson' rating: 4.8.
driver addRide: rides first.
driver addRide: rides last.

rider := Rider new initializeWithID: 201 name: 'Bob Smith'.
rider requestRide: rides first.
rider requestRide: rides last.

"Display information in the Transcript"
Transcript show: 'Driver Information: ', driver getDriverInfo; cr.
Transcript show: 'Driver Assigned Rides: ', (driver showAssignedRides) asString; cr.
Transcript show: 'Rider Ride History: ', (rider viewRides) asString; cr.
