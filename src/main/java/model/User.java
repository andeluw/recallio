package model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class User {
  private int userId;
  private String username;
  private String password;
  private Timestamp createdAt;
  private List<Deck> decks;

  public User() {
    decks = new ArrayList<Deck>();
  }

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Timestamp createdAt) {
    this.createdAt = createdAt;
  }

  public List<Deck> getDecks() {
    return decks;
  }

  public void setDecks(List<Deck> decks) {
    this.decks = decks;
  }
}