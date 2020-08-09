#![feature(proc_macro_hygiene, decl_macro)]

use rocket::config::{Config, Environment};

let config = Config::build(Environment::Staging)
    .address("127.0.0.1")
    .port(80)
    .workers(12)
    .unwrap();

#[macro_use]
extern crate rocket;
// extern crate parquet;
extern crate serde;
use serde::{Deserialize, Serialize};
use std::{thread, time};

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
    let ten_millis = time::Duration::from_millis(10);

    thread::sleep(ten_millis);
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
