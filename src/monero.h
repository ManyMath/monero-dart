#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>

/**
 * Frees a C string allocated by this library
 *
 * # Safety
 * Must only be called on strings allocated by this library's functions
 * Must not be called more than once on the same pointer
 */
void free_string(char *ptr);

/**
 * Generates a Monero address from a mnemonic
 *
 * # Arguments
 * * `mnemonic` - C string containing the mnemonic phrase
 * * `network` - Network type (0=Mainnet, 1=Testnet, 2=Stagenet)
 * * `account` - Account index
 * * `index` - Subaddress index (0 for primary address)
 *
 * # Returns
 * Pointer to C string containing address (caller must free)
 * Returns null on error
 */
char *generate_address(const char *mnemonic, uint8_t network, uint32_t account, uint32_t index);

/**
 * Generates a mnemonic in the specified language
 *
 * # Arguments
 * * `language` - Language code (0=Chinese, 1=English, 2=Dutch, etc.)
 *
 * # Returns
 * Pointer to C string containing mnemonic (caller must free)
 * Returns null on error
 */
char *generate_mnemonic(uint8_t language);
