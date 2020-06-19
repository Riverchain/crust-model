use std::io;
use std::intrinsics::sqrtf32;


fn main() {
    struct project_specification {
        project_name: String,
        author: String,
        date: String,
        company: String,
        river_name: String,
        region: String,
    }

    let mut mississippi_project = project_specification {
        project_name: String::from("Mississippi River"),
        author: String,
        date: String,
        company: String,
        river_name: String,
        region: String,
    };

    mississippi_project.author = String::from("Mostafa");

    // Max time step calculation
    let mut delta_time = max_time_step_calculator(5 as f32, 5 as f32);
    // Delta T section

    println!("The calculated time step is= {} seconds. Due to our records the finer the time step is, the more accurate the model performs. However, very small steps would lead your machine ends up with a memory crash.", delta_time);
    // REGION A: delta_t selection.
    loop {
        println!("Please input a number between {} to {}", 0.001 ,delta_time);

        let mut delta_time_user_input = String::new();

        io::stdin()
            .read_line(&mut delta_time_user_input)
            .expect("Failed to read line");

        let delta_time_user_input_converted_to_f32: f32 = match delta_time_user_input.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        if delta_time_user_input_converted_to_f32 <= delta_time && delta_time_user_input_converted_to_f32 !=0 as f32 && delta_time_user_input_converted_to_f32 >= 0 as f32{
            println!("Appropriate time step has been chosen ✓");
            break;
        } else {
            println!("Chose an smaller time step ↺");
        }
    }
    // End of REGION A: delta_t selection.
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

fn max_time_step_calculator(ldc:f32,delta_x:f32) -> f32 {
     0.5 * delta_x.powi(2) * ldc.powi(-1)
}


fn mathematical_diffusion_number(ldc: f32, delta_t: f32, delta_x: f32) -> f32 {
    ldc*delta_t/(f32::powi(delta_x,2))
}

fn dx_2015_disley(b: f32, y: f32, z: f32, s: f32, flow: f32, u: f32 ) -> f32 {

    /* Function description
    "Disley et al. (2015)" Longitudinal dispersion coefficient Disley. T., Gharabaghi. B., Mahboubi. A. and McBean. A. (2015).
    Paper's title: "Predictive equation for longitudinal dispersion coefficient."
    Published @ HYDROLOGICAL PROCESSES 29, 161-172.
    Use meter and cubic meter as your input values' dimensions.
    */
    let a= y * (b + z * y);
    let T= b + 2 * z * y;
    let p= b + 2 * y * sqrt(1+ powi(z,2));
    let r= a/p;
    let EARTH_GRAVITY_ACCELERATION:f32 = 9.807; // meters/s*s
    let g= 9.81;
    let w= a/y;
    let ustar= sqrtf32(g * r * s);
    y * ustar * 3.563 * ((u /  (sqrt(g * y))) .^ -0.4117) .* ((w  ./  y) .^ 0.6776) *
        ((u/ustar) .^ 1.0132);
}

fn _first_word(s: &String) -> usize {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return i;
        }
    }

    s.len()
}