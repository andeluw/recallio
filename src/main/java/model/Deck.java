package model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Deck {
  private int deckId;
  private String deckName;
  private String deckType;
  private String deckDescription;
  private String deckCategory;
  private int userId;
  private Timestamp createdAt;
  private Timestamp updatedAt;
  private List<Flashcard> flashcards;

  public Deck() {
    flashcards = new ArrayList<>();
  }

  public int getDeckId() {
    return deckId;
  }

  public void setDeckId(int deckId) {
    this.deckId = deckId;
  }

  public String getDeckName() {
    return deckName;
  }

  public void setDeckName(String deckName) {
    this.deckName = deckName;
  }

  public String getDeckType() {
    return deckType;
  }

  public void setDeckType(String deckType) {
    this.deckType = deckType;
  }

  public String getDeckDescription() {
    return deckDescription;
  }

  public void setDeckDescription(String deckDescription) {
    this.deckDescription = deckDescription;
  }

  public String getDeckCategory() {
    return deckCategory;
  }

  public void setDeckCategory(String deckCategory) {
    this.deckCategory = deckCategory;
  }

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  public Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Timestamp createdAt) {
    this.createdAt = createdAt;
  }

  public Timestamp getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(Timestamp updatedAt) {
    this.updatedAt = updatedAt;
  }

  public List<Flashcard> getFlashcards() {
    return flashcards;
  }

  public void setFlashcards(List<Flashcard> flashcards) {
    this.flashcards = flashcards;
  }
}
