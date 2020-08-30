#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use]
extern crate rocket;
use rocket::config::{Config, Environment};
// extern crate parquet;
extern crate serde;
use serde::{Deserialize, Serialize};
use std::{thread, time};

#[derive(Serialize, Deserialize, Debug)]
struct Point {
    x: f64,
    y: f64,
}

#[get("/")]
fn index() -> String {
    "Index".to_string()
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
    let config = Config::build(Environment::Staging)
        .address("0.0.0.0")
        .port(10001)
        .workers(11)
        .unwrap();
    let app = rocket::custom(config);
    app.mount("/hello_again", routes![hello_again])
        .mount("/give_point", routes![give_point])
        .mount("/", routes![index])
        .mount("/hello", routes![hello])
        .launch();

    //rocket::ignite()
    //    .mount("/hello_again", routes![hello_again])
    //    .mount("/give_point", routes![give_point])
    //    .mount("/hello", routes![hello])
    //    .launch();
}
