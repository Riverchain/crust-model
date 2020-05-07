use std::io;


fn main() {
    let mut delta_time = diffusion_number(5 as f32, 5 as f32, 1 as f32);
    // Delta T section

    println!("The calculated time step is= {} seconds. Due to our records the finer the time step is, the more accurate the model performs. However, very small steps would lead your machine ends up with a memory crash.", delta_time);
    // REGION A. Asking user for making a decision upon time step's length.
    loop {
        println!("Please input a number less than");

        let mut delta_time_user_input = String::new();

        io::stdin()
            .read_line(&mut delta_time_user_input)
            .expect("Failed to read line");

        let delta_time_user_input_converted_to_f32: f32 = match delta_time_user_input.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        if delta_time_user_input_converted_to_f32 <= delta_time {
            println!("Appropriate time step has been chosen ✓");
        } else {
            println!("Chose an smaller time step ↺");
            break;
        }
    }
    // End of REGION A
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

fn diffusion_number (ldc: f32, delta_t: f32, delta_x: f32) -> f32 {
    ldc*delta_t/(f32::powi(delta_x,2))
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