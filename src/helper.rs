use bcrypt::{hash, DEFAULT_COST};
use regex::Regex;

pub(crate) fn is_valid_email(email: &str) -> bool {
    let email_regex = Regex::new(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").unwrap();

    email_regex.is_match(email)
}

pub(crate) fn hash_password(password: &str) -> String {
    hash(password, DEFAULT_COST).unwrap()
}
