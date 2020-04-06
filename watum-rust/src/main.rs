use std::env;
use std::fs;
use std::result::Result;
use std::io;

// The first guessing game section copied from online rust-book.
// fn main() {
//     println!("Guess the number!");
//     println!("Please input your guess.");
//     let mut guess = String::new();
//     io::stdin().read_line(&mut guess)
//         .expect("Failed to read line");
//     println!("You guessed: {}", guess);
// }

// Test println functionality.
// fn main() {
//     let x = 5;
//     let y = 10;
//
//     println!("x = {} and y = {}", x, y);
// }


use rand::Rng;
use std::cmp::Ordering;
fn main() {
    println!("Guess a number between 1 to 5");

    let secret_number =
        rand::thread_rng()
            .gen_range(1, 600);

    let comparing_phrase: String = secret_number.to_string();
    println!("The secret number is: {}", comparing_phrase);
    println!("Please input your guess.");
    let mut guess = String::new();
    io::stdin().read_line(&mut guess)
        .expect("Failed to read line");
    println!("You guessed: {}", guess);


    match guess.cmp(&comparing_phrase) {
        Ordering::Less => println!("Too small!"),
        Ordering::Greater => println!("Too big!"),
        Ordering::Equal => println!("You win!"),
    }
}
