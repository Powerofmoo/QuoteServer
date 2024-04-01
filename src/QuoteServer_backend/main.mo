import Array "mo:base/Array";
import Random "mo:base/Random";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

actor QuoteServer {
    // Initialize the internal structure 
    private stable var quotes: [Text] = [];

    // public function that takes a string of quotes separated by newlines, splits them, and adds them to the internal array of quotes.
    public func addQuotes(input: Text): async () {
        // Split the input string into an array of quotes using the newline character as a delimiter.
        let i = Text.split(input, #text "//");
        let newQuotes = Iter.toArray<Text>(i);
        quotes := Array.append(quotes, newQuotes);
    };

    // public function to return a random quote from the array.
    public func randomQuote(): async ?Text {
        // Check if the quotes array is empty and return `null` if true.
        if (Array.size(quotes) == 0) {
            return null;
        };
        // Generate a random index to select a quote from the array. The `Random.randNat` function is used here, requiring a natural number as the maximum value.
        let blob = await Random.blob();
        let hugeNumber = Random.rangeFrom(32, blob);
        let index = hugeNumber % Array.size(quotes);
        return ?quotes[index];
    };

    // public function to find and return a random quote containing a specific emoji.
    public func emojiQuote(emoji: Text): async ?Text {
        // Filter the quotes array to include only those quotes that contain the specified emoji.
        let emojiQuotes = Array.filter<Text>(quotes, func (q) : Bool {
            Text.contains(q, #text emoji)
        });
        // Check if the filtered array of emoji quotes is empty and return `null` if true.
        if (Array.size(emojiQuotes) == 0) {
            return null;
        };
        // Generate a random index to select a quote from the filtered array of emoji quotes.
        let blob = await Random.blob();
        let hugeNumber = Random.rangeFrom(32, blob);
        let index = hugeNumber % Array.size(emojiQuotes); 
        return ?emojiQuotes[index];
    };
}
