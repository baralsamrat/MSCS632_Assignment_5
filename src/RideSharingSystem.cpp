#include <iostream>
#include <vector>
#include <memory>
#include <string>
using namespace std;

/*-------------------- Base Class: Ride --------------------*/
class Ride {
protected:
    int rideID;
    string pickupLocation;
    string dropoffLocation;
    double distance;  // miles

public:
    Ride(int id, const string& pickup, const string& dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist) {}

    // Virtual method to calculate fare; overridden by derived classes.
    virtual double fare() const {
        // Default calculation: $1 per mile
        return distance * 1.0;
    }

    // Virtual method to print ride details.
    virtual void rideDetails() const {
        cout << "Ride ID: " << rideID
             << " | From: " << pickupLocation
             << " to " << dropoffLocation
             << " | Fare: $" << fare() << endl;
    }

    virtual ~Ride() {}
};

/*-------------------- Derived Class: StandardRide --------------------*/
class StandardRide : public Ride {
public:
    StandardRide(int id, const string& pickup, const string& dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        // Standard ride rate: $1 per mile
        return distance * 1.0;
    }
};

/*-------------------- Derived Class: PremiumRide --------------------*/
class PremiumRide : public Ride {
public:
    PremiumRide(int id, const string& pickup, const string& dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        // Premium ride rate: $2 per mile
        return distance * 2.0;
    }
};

/*-------------------- Driver Class --------------------*/
class Driver {
private:
    int driverID;
    string name;
    double rating;
    vector<shared_ptr<Ride>> assignedRides;  // Encapsulated

public:
    Driver(int id, const string& name, double rating)
        : driverID(id), name(name), rating(rating) {}

    // Only way to modify assignedRides.
    void addRide(shared_ptr<Ride> ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        cout << "Driver ID: " << driverID << " | Name: " << name
             << " | Rating: " << rating << endl;
    }

    void showAssignedRides() const {
        for (const auto &ride : assignedRides) {
            ride->rideDetails();
        }
    }
};

/*-------------------- Rider Class --------------------*/
class Rider {
private:
    int riderID;
    string name;
    vector<shared_ptr<Ride>> requestedRides;  // Encapsulated list

public:
    Rider(int id, const string& name)
        : riderID(id), name(name) {}

    void requestRide(shared_ptr<Ride> ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        for (const auto &ride : requestedRides) {
            ride->rideDetails();
        }
    }
};

/*-------------------- Main Function to Demonstrate System Functionality --------------------*/
int main() {
    // Polymorphism demonstrated via a vector of base class pointers
    vector<shared_ptr<Ride>> rides;
    rides.push_back(make_shared<StandardRide>(1, "Central Park", "Times Square", 5));
    rides.push_back(make_shared<PremiumRide>(2, "Wall Street", "Brooklyn Bridge", 10));

    // Create and populate Driver
    Driver driver(101, "Alice Johnson", 4.8);
    driver.addRide(rides[0]);
    driver.addRide(rides[1]);

    // Create and populate Rider
    Rider rider(201, "Bob Smith");
    rider.requestRide(rides[0]);
    rider.requestRide(rides[1]);

    // Display the system information
    cout << "Driver Information:" << endl;
    driver.getDriverInfo();
    cout << "\nDriver's Assigned Rides:" << endl;
    driver.showAssignedRides();

    cout << "\nRider's Ride History:" << endl;
    rider.viewRides();

    return 0;
}
