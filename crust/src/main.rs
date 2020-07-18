fn main() {
    let ldc = ChooseLDC::Fischer;
    
}


enum ChooseLDC {
    Fischer,
    Qiasi,
    Noori,
    Fucker,
}

struct project_specification {
    project_name: String,
    project_author: String,
    project_owner: String,
    project_contractor: String,
    project_date: String,
    project_location: String,
    project_email: String,
    project_website: String,
    project_status: bool,
}
