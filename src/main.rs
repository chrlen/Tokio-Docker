#![feature(proc_macro_hygiene, decl_macro)]

#[macro_use]
extern crate rocket;
use rocket::config::{Config, Environment};

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

// Sleep and return serialized dummy object to simulate operation
#[get("/<x>/<y>")]
fn build_point(x: f64, y: f64) -> String {
    let ten_millis = time::Duration::from_millis(10);
    thread::sleep(ten_millis);

    let point = Point { x, y };
    serde_json::to_string(&point).unwrap()
}

fn main() {
    let config = Config::build(Environment::Staging)
        .address("127.0.0.1")
        .port(8080)
        .workers(11)
        .unwrap();

    let app = rocket::custom(config);

    app.mount("/build_point", routes![build_point])
        .mount("/", routes![index])
        .launch();
}
