% {{{
function will_hit = decide(strategy, player_cards, dealer_card)
    switch strategy
    case 1
        will_hit = s1(player_cards, dealer_card);
    case 2
        will_hit = s2(player_cards, dealer_card);
    case 3
        will_hit = s3(player_cards, dealer_card);
    case 4
        will_hit = s4(player_cards, dealer_card);
    case 5
        will_hit = s5(player_cards, dealer_card);
    case 6
        will_hit = s6(player_cards, dealer_card);
    case 7
        will_hit = s7(player_cards, dealer_card);
    case 8
        will_hit = s8(player_cards, dealer_card);
    case 9
        will_hit = s9(player_cards, dealer_card);
    end
end
% }}}
%% Stands if total is between 12 and 21 {{{
function will_hit = s1(player_cards, dealer_card)
    total = get_total(player_cards);

    if (total <= 12)
        will_hit = true;
    else
        will_hit = false;
    end
end
% }}}
%% Stands if total is between 15 and 21 {{{
function will_hit = s2(player_cards, dealer_card)
    total = get_total(player_cards);

    if (total <= 15)
        will_hit = true;
    else
        will_hit = false;
    end
end
% }}}
%% Stands if total is between 17 and 21 {{{
function will_hit = s3(player_cards, dealer_card)
    total = get_total(player_cards);

    if (total <= 17)
        will_hit = true;
    else
        will_hit = false;
    end
end
% }}}
%% Stands if total is between 18 and 21 {{{
function will_hit = s4(player_cards, dealer_card)
    total = get_total(player_cards);

    if (total <= 18)
        will_hit = true;
    else
        will_hit = false;
    end
end
% }}}
%% Hits if dealer has ten {{{
function will_hit = s5(player_cards, dealer_card)
    total = get_total(player_cards);

    if (dealer_card >= 10 && total <= 14)
        will_hit = true;
    else
        if (total <= 18)
            will_hit = true;
        else
            will_hit = false;
        end
    end
end
% }}}
%% Based on the hypothesis that the dealer having cards between 7 and 9 makes
% it more likely for the dealer to bust
function will_hit = s6(player_cards, dealer_card)
    total = get_total(player_cards);
    if (total <= 18)
        will_hit = true;
    else
        will_hit = false;
    end

    if (dealer_card >= 7 && dealer_card <= 9)
        will_hit = false;
    end
end
%% Strategy 7
function will_hit = s7(player_cards, dealer_card)
    total = get_total(player_cards);
    % http://wizardofodds.com/games/blackjack/strategy/4-decks/

    will_hit = true;

    if (total >= 12 && (dealer_card >= 4 && dealer_card <= 6))
        will_hit = false;
    end

    if (total >= 13 && total <= 16 && (dealer_card >= 2 && dealer_card <= 6))
        will_hit = false;
    end

    if (total >= 17)
        will_hit = false;
    end

    if (total >= 19)
        will_hit = false;
    end
end
%% Strategy 8
function will_hit = s8(player_cards, dealer_card)
    soft_total = get_soft_total(player_cards);
    hard_total = get_hard_total(player_cards);
    % http://wizardofodds.com/games/blackjack/strategy/4-decks/

    % Always hit hard 11 or less
    if (hard_total <= 11)
        will_hit = true;
    elseif (soft_total <= 17)
        will_hit = true;
    elseif (hard_total >= 12 && (dealer_card >= 4 && dealer_card <= 6))
        will_hit = false;
    elseif (hard_total >= 13 && hard_total <= 16 && (dealer_card >= 2 && dealer_card <= 6))
        will_hit = false;
    elseif (hard_total >= 17)
        will_hit = false;
    elseif (soft_total >= 18)
        if (dealer_card >= 9 || dealer_card == 1)
            will_hit = true;
        else
            will_hit = false;
        end
    elseif (soft_total >= 19)
        will_hit = false;
    else
        will_hit = false;
    end
end

function will_hit = s9(player_cards, dealer_card)
end
