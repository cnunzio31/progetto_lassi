FactoryBot.define do
    factory :session1, class: Session do
        title "Session1"
        status "2" #active
        session_type "1.0"
        description "Sessione di prova 1"
        location "Roma"
        version "1"
    end
    factory :master1, class: User do
        roles_mask "1"
        username "master1"
        email "master1@test.com"
        password "password"
    end
    factory :player1, class: User do
        roles_mask "2"
        username "player1"
        email "player1@test.com"
        password "password"
    end
    factory :match1, class: Match do
        title "Match1"
        status "false"
        data "18/06/18"
    end
    factory :partecipationmatch1, class: Partecipationsmatch do
        session_id ""
        match_id ""
        player_id ""
    end
end
