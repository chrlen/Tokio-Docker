#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use]
extern crate rocket;
extern crate parquet;
extern crate serde;
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
struct Point {
    x: f64,
    y: f64,
}

#[get("/<name>/<age>")]
fn hello(name: String, age: u8) -> String {
    format!("Hello, {} year old named {}!", age, name)
}

#[get("/<name>/<age>")]
fn hello_again(name: String, age: u8) -> String {
    format!("Hello, {} year old named {}!", age, name)
}

#[get("/<x>/<y>")]
fn give_point(x: f64, y: f64) -> String {
    let point = Point { x, y };
    serde_json::to_string(&point).unwrap()
}

fn main() {
    rocket::ignite()
        .mount("/hello_again", routes![hello_again])
        .mount("/give_point", routes![give_point])
        .mount("/hello", routes![hello])
        .launch();
}
