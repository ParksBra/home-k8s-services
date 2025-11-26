#pylint: skip-file
# Based on: https://shantanoo-desai.github.io/posts/technology/mosquitto_ansible_passgen

SALT_SIZE = 12
ITERATIONS = 101

def mosquitto_passwd(passwd):
  try:
    import passlib.hash
  except Exception as e:
    raise AnsibleError('mosquitto_passlib custom filter requires the passlib pip package installed') from e

  hasher = passlib.hash.pbkdf2_sha512.using(salt_size=SALT_SIZE, rounds=ITERATIONS)
  digest = hasher.hash(passwd)
  digest = digest.replace("pbkdf2-sha512", "7")
  digest = digest.replace(".", "+")
  digest = digest + "=="

  return digest


class FilterModule(object):
  def filters(self):
    return {
      'mosquitto_passwd': mosquitto_passwd,
    }
