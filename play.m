%% Plays game for NUM_GAMES amount of times {{{
function play(strategy)
    money = Const.STARTING_BALANCE;
    player_busts = 0;
    dealer_busts = 0;

    % Keeps track of total number of [WIN, DRAW, LOSE]
    results = [0, 0, 0];
    blackjack = 0;

    % Repeat game for certain amount of times
    for i = 1:Const.NUM_GAMES
        res = game(strategy, money);
        money = res(1);
        player_busts = player_busts + res(2);
        dealer_busts = dealer_busts + res(3);
        % Update total counts
        switch res(4)
        case Const.BLACKJACK
            results = results + [1, 0, 0];
            blackjack = blackjack + 1;
        case Const.WIN
            results = results + [1, 0, 0];
        case Const.DRAW
            results = results + [0, 1, 0];
        case Const.LOSE
            results = results + [0, 0, 1];
        end
    end

    % After
    fprintf('Strategy %d: %.2f\n', strategy, money);
    fprintf('  [%d, %d, %d]\n', results(1), results(2), results(3));
    fprintf('  Blackjack: %d\n', blackjack);
    fprintf('  Player Busts: %f\n', player_busts / Const.NUM_GAMES);
    fprintf('  Dealer Busts: %f\n', dealer_busts / Const.NUM_GAMES);
end
% }}}
%% Plays one game {{{
function after_game_state = game(strategy, money)
    % Pay wager
    money = money - Const.WAGER;
    is_player_bust = false;
    is_dealer_bust = false;

    % Deal cards to both player and dealer
    player_cards = [hit(), hit()];
    dealer_cards = [hit()];

    while (true)
        % Make decision
        will_hit = decide(strategy, player_cards, dealer_cards(1));

        % Get another card if it decides to hit
        if (will_hit == false)
            break;
        else
            player_cards = [player_cards, hit()];
        end
    end

    % Note: dealer gets dealt with his second card in this function
    res = result(player_cards, dealer_cards);

    % Get wager back and get 1.5 times more of the wager
    if (res(1) == Const.BLACKJACK)
        money = money + (2.5 * Const.WAGER);
    % Get however much the wager was
    elseif (res(1) == Const.WIN)
        money = money + (2 * Const.WAGER);
    elseif (res(1) == Const.DRAW)
        % Get wager back
        money = money + Const.WAGER;
    end

    is_player_bust = res(2);
    is_dealer_bust = res(3);

    after_game_state = [money, is_player_bust, is_dealer_bust, res(1)];
end
% }}}
%% Draws one random card {{{
% It is assumed that there is an infinite number of decks. In other words, the
% probability is uniformly distributed at all times.
function card = hit()
    card = ceil(rand() * 13);
end
% }}}
%% Compare the player's cards and dealer's cards {{{
function result = result(player_cards, dealer_cards)
    % Get the second card for dealer
    while (get_total(dealer_cards) < 17)
        dealer_cards = [dealer_cards, hit()];
    end

    player_total = get_total(player_cards);
    dealer_total = get_total(dealer_cards);

    is_player_bust = false;
    is_dealer_bust = false;

    if (is_blackjack(player_cards))
        result = Const.BLACKJACK;
    elseif (player_total > 21)
        result = Const.LOSE;
        is_player_bust = true;
    else
        if (dealer_total > 21)
            result = Const.WIN;
            is_dealer_bust = true;
        elseif (player_total == dealer_total)
            result = Const.DRAW;
        elseif (player_total > dealer_total)
            result = Const.WIN;
        else
            result = Const.LOSE;
        end
    end

    % Add busts information
    result = [result, is_player_bust, is_dealer_bust];

    % DEBUG
    %player_cards
    %player_total
    %dealer_cards
    %dealer_total
end
% }}}
%% Checks whether player's hand is a Blackjack {{{
function res = is_blackjack(player_cards)
    res = false;
    % Blackjack = total is 21 (Doesn't have to be A and 10-valued card
    if (get_total(player_cards) == 21)
        res = true;
    end

    % Blackjack = Ace and 10-valued card
    %if (length(player_cards) == 2)
    %    if (has(player_cards, 1))
    %        if (has(player_cards, 10) || has(player_cards, 11) || has(player_cards, 12) || has(player_cards, 13))
    %            res = true;
    %        end
    %    end
    %end
end
% }}}
%% Determines whether the vector contains the given number {{{
function t = has(vec, num)
    t = false;
    if (sum(vec == num) > 0)
        t = true;
    end
end
% }}}
