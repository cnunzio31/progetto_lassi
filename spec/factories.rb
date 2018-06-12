FactoryBot.define do
    factory :session1, class: Session do
        title "Session1"
        status "2" #active
        session_type "1.0"
        description "Sessione di prova 1"
        location "Roma"
    end
    factory :session2, class: Session do
        title "Session2"
        status "2" #active
        session_type "1.0"
        description "Sessione di prova 2"
        location "Milano"
    end
    factory :master1, class: User do
        roles_mask "1"
        username "master1"
        email "master1@test.com"
        password "password"
    end
    factory :master2, class: User do
        roles_mask "1"
        username "master2"
        email "master2@test.com"
        password "password"
    end
    factory :player1, class: User do
        roles_mask "2"
        username "player1"
        email "player1@test.com"
        password "password"
    end
    factory :player2, class: User do
        roles_mask "2"
        username "player2"
        email "player2@test.com"
        password "password"
    end
    factory :match1, class: Match do
        title "Match1"
        status "false"
    end
    factory :match2, class: Match do
        title "Match2"
        status "true"
    end
    factory :match3, class: Match do
        title "Match3"
        status "true"
    end
end
