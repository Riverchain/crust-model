use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    println!("{:?}", args);
}

struct RiverSpecification {
    river_length: f64, // in SI Meters .
    river_observatory_stations: i64, // Dimensionless Number.
    river_name: String,
    river_country: Stringacebook,
    river_region: String,
    river_other_name: String,
    river_local_name: String,
    river_first_station_name: String,
    river_start_point_location: LocationForGIS,
    river_end_point_location: LocationForGIS,
    river_station_location: LocationForGIS,
}

struct LocationForGIS {
    lat: f64,
    long: f64,
}

struct ProjectSpecification {
    project_name: String,
    project_author1: String,
    project_author2: String,
    project_author3: String,
    project_author4: String,
    project_author5: String,
    project_author6: String,
    project_author7: String,
    project_author8: String,
    project_author9: String,
    project_author10: String,
    project_author11: String,
    project_author12: String,
    project_author_others: String,
    project_owner: String,
    project_sponsor: String,
    project_contractor: String,
    project_date: String,
    project_location: String,
    project_email1: String,
    project_email2: String,
    project_email3: String,
    project_email4: String,
    project_email5: String,
    project_email6: String,
    project_email7: String,
    project_email8: String,
    project_email9: String,
    project_website: String,
    project_status: bool,
}

enum ProjectStatus {
    is_in_engineering_phase,
    construction_phase,
    under_decision,
    finished,
    just_started,
    unknown_status,
    our_staff_are_off_for_holiday,
    waiting_for_approval,
    waiting_for_costs_payment,
    something_else,
}