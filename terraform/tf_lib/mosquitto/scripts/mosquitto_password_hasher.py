#pylint: skip-file
# Based on: https://shantanoo-desai.github.io/posts/technology/mosquitto_ansible_passgen
import sys
import passlib.hash

SALT_SIZE = 12
ITERATIONS = 101

def mosquitto_passwd(passwd: str) -> str:
    """Hash a password for Mosquitto using PBKDF2-SHA512.

    Args:
        passwd (str): The plaintext password to hash.

    Returns:
        str: The hashed password string.
    """
    hasher = passlib.hash.pbkdf2_sha512.using(salt_size=SALT_SIZE, rounds=ITERATIONS)
    digest = hasher.hash(passwd)
    digest = digest.replace("pbkdf2-sha512", "7")
    digest = digest.replace(".", "+")
    digest = digest + "=="

    return digest

def main():
    """Main function to hash a password provided as a command-line argument."""
    if len(sys.argv) != 2:
        print(f"Usage: python3 {sys.argv[0]} <unhashed_password>", file=sys.stderr)
        sys.exit(1)

    unhashed_password = sys.argv[1]

    print(mosquitto_passwd(unhashed_password), file=sys.stdout, end="")

if __name__ == "__main__":
    main()
