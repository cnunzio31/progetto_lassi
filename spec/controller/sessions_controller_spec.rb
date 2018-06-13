require "rails_helper"

describe SessionsController, :type => :controller do
    before :each do
        @master1 = FactoryBot.create(:master1)
        sign_in @master1
    end

    describe "GET sessions" do
        it "created has a 200 status code" do
          get :showcreated
          expect(response.status).to eq(200)
        end

        it "render the created session list" do
            get :showcreated
            expect(response).to render_template(:showcreated)
        end

        it "active has a 200 status code" do
          get :showactive
          expect(response.status).to eq(200)
        end

        it "render the active session list" do
            get :showactive
            expect(response).to render_template(:showactive)
        end

        it "closed has a 200 status code" do
          get :showclosed
          expect(response.status).to eq(200)
        end

        it "render the closed session list" do
            get :showclosed
            expect(response).to render_template(:showclosed)
        end
    end

    describe "Create session" do
        it "render the form" do
            get :new
            expect(response).to render_template(:new)
        end

        it "creates the session 'Session1'" do
            post :create, params: {session: {master_id: @master1.id,
                 title: "Session1", location: "Roma",
                 description: "bella", version: "1"}}
            expect(response).to redirect_to("/sessions/1")
        end
    end
end
