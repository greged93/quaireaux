//! Utilities for quaireaux standard library.
use array::ArrayTrait;
use option::OptionTrait;
use traits::TryInto;
use traits::Into;

/// Panic with a custom message.
/// # Arguments
/// * `msg` - The message to panic with. Must be a short string to fit in a felt.
fn panic_with(err: felt) {
    let mut data = ArrayTrait::new();
    data.append(err);
    panic(data);
}

/// Convert a `felt` to a `NonZero` type.
/// # Arguments
/// * `felt` - The `felt` to convert.
/// # Returns
/// * `Option::<NonZero::<felt>>` - The `felt` as a `NonZero` type.
/// * `Option::<NonZero::<felt>>::None` - If `felt` is 0.
fn to_non_zero(felt: felt) -> Option::<NonZero::<felt>> {
    let res = felt_is_zero(felt);
    match res {
        IsZeroResult::Zero(()) => Option::<NonZero::<felt>>::None(()),
        IsZeroResult::NonZero(val) => Option::<NonZero::<felt>>::Some(val),
    }
}


/// Force conversion from `felt` to `u128`.
fn unsafe_felt_to_u128(a: felt) -> u128 {
    a.try_into().unwrap()
}

/// Perform euclidean division on `felt` types.
fn unsafe_euclidean_div_no_remainder(a: felt, b: felt) -> felt {
    let a_u128 = unsafe_felt_to_u128(a);
    let b_u128 = unsafe_felt_to_u128(b);
    (a_u128 / b_u128).into()
}

fn unsafe_euclidean_div(a: felt, b: felt) -> (felt, felt) {
    let a_u128 = unsafe_felt_to_u128(a);
    let b_u128 = unsafe_felt_to_u128(b);
    ((a_u128 / b_u128).into(), (a_u128 % b_u128).into())
}

fn max(a: felt, b: felt) -> felt {
    if a > b {
        return a;
    } else {
        return b;
    }
}

// Function to count the number of digits in a number.
/// # Arguments
/// * `num` - The number to count the digits of.
/// * `base` - Base in which to count the digits.
/// # Returns
/// * `felt` - The number of digits in num of base
fn count_digits_of_base(num: felt, base: felt) -> felt {
    // Check if out of gas.
    // TODO: Remove when automatically handled by compiler.
    match get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = ArrayTrait::new();
            data.append('OOG');
            panic(data);
        }
    }

    match num {
        0 => 0,
        _ => {
            let quotient = unsafe_euclidean_div_no_remainder(num, base);
            count_digits_of_base(quotient, base) + 1
        }
    }
}

// Raise a number to a power.
/// * `base` - The number to raise.
/// * `exp` - The exponent.
/// # Returns
/// * `felt` - The result of base raised to the power of exp.
fn pow(base: felt, exp: felt) -> felt {
    // Check if out of gas.
    // TODO: Remove when automatically handled by compiler.
    match get_gas() {
        Option::Some(_) => {},
        Option::None(_) => {
            let mut data = ArrayTrait::new();
            data.append('OOG');
            panic(data);
        }
    }

    match exp {
        0 => 1,
        _ => base * pow(base, exp - 1),
    }
}
