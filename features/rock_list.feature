Feature: Song list
  In order to have a great party
  I need some songs.

  Scenario: List songs
    Given the system knows about the following songs:
      | name  | style |
      | chase | italo |
      | motorhead | metal |
    When the client requests GET /songs
    Then the response should be JSON:
      """
      [
        { "name": "chase", "style": "italo" },
        { "name": "motorhead", "style": "metal" }
      ]
      """