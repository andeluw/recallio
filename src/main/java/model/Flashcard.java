package model;

import java.sql.Timestamp;

public class Flashcard {
  private int flashcardId;
  private int deckId;
  private String flashcardTitle;
  private String flashcardDetail;
  private Timestamp createdAt;
  private Timestamp updatedAt;
  private int userId;

  public int getFlashcardId() {
    return flashcardId;
  }

  public void setFlashcardId(int flashcardId) {
    this.flashcardId = flashcardId;
  }

  public int getDeckId() {
    return deckId;
  }

  public void setDeckId(int deckId) {
    this.deckId = deckId;
  }

  public String getFlashcardTitle() {
    return flashcardTitle;
  }

  public void setFlashcardTitle(String flashcardTitle) {
    this.flashcardTitle = flashcardTitle;
  }

  public String getFlashcardDetail() {
    return flashcardDetail;
  }

  public void setFlashcardDetail(String flashcardDetail) {
    this.flashcardDetail = flashcardDetail;
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

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }
}
