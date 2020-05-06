fn main() {
    let delta_time = max_time_step_calculator(5 as f32,5 as f32);
    println!(delta_time);
}

fn simple_watum (){
    /*
    This small function, calculates a single-point pollution source injection into a prismatic open channel problem. This is intended to show how reliable the mathematical scheme is by reducing the mathematical errors of truncation and distribution.
    */
    let channel_length :f32 = 10_000 as f32; // The length is equal to 10 thousands meters.
    let initial_concentration :f32 = 1 as f32; // This variable defines the initial computational cell dye concentration in ppm.
    let delta_x:i32 = 1;
    //let time_step = max_time_step_calculator(delta_x)*0.5;
}

fn max_time_step_calculator(ldc:f32,delta_x:f32){

}

fn diffusion_number (ldc: f32, delta_t: f32, delta_x: f32){
    ldc*delta_t/(f32::powi(delta_x,2));
}

fn dx_2015_disley( b: f64, y: f64, z: f64, s: f64, flow: f64, u: f64 ) {

    /*
    Function Description and authors list.
    "Disley et al. (2015)" Longitudinal dispersion coefficient Disley. T., Gharabaghi. B., Mahboubi. A. and McBean. A. (2015).
    Paper's title: "Predictive equation for longitudinal dispersion coefficient."
    Published @ HYDROLOGICAL PROCESSES 29, 161-172.
    Use meter and cubic meter as your input values' dimensions.
    */
    
}