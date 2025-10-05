// Re-export the monero-rust FFI functions.
pub use monero_rust::{generate_mnemonic, generate_address, free_string};

// Additional plugin-specific FFI functions could go here.  For now, we just 
// re-export everything.
