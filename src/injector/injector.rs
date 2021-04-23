
use mysql::*;
// use mysql::prelude::*;

fn main(){

// let url = "mysql://root:password@localhost:3308/db_name";

// let pool = Pool::new(url);

// let mut conn = pool.get_conn();

let opts = OptsBuilder::new()
    .user(Some("foo"))
    .db_name(Some("bar"));

let conn = Conn::new(opts);

//Let's create a table for payments.
//conn.query_drop(
//    r"CREATE TEMPORARY TABLE payment (
//        customer_id int not null,
//        amount int not null,
//        account_name text
//    )")?;
}