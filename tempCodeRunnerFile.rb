def display_feedback(guess, code)
  feedback = "\n- -\n- -\n\n"
  comparison_result = compare(guess, code)

  comparison_result[0][0].times { feedback.sub!('-', '●') }
  comparison_result[1].times { feedback.sub!('-', '○') }

  @winner = 'Player' if comparison_result[0][0] == 4

  puts feedback
end