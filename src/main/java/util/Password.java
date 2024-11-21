package util;

import org.mindrot.jbcrypt.BCrypt;

public class Password {
  public static String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt(10));
  }

  public static boolean checkPassword(String hashedPassword, String plainPassword) {
    return BCrypt.checkpw(plainPassword, hashedPassword);
  }
}