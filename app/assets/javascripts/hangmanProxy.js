/**
 * Created by Ilya on 4/12/14.
 */
zenBuilder.HangmanProxy = {
    guessLetter: function (letter){
        var url = "/hangman/guessletter/" + letter;
        $.ajax(url,{
            "success": function (data){
                zenBuilder.HangmanView.updateView(data,letter);
            },
            "error": function (data){
                alert("An error occurred.");
            }
        })
    }
}
