class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @figures = Figure.all
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params[:title][:name].empty?
      if !!params[:figure][:title_ids]
        params[:figure][:title_ids] << Title.create(params[:title]).id
      else
        params[:figure][:title_ids] = []
        params[:figure][:title_ids] << Title.create(params[:title]).id
      end
    end
    @figure.title_ids = params[:figure][:title_ids]

    if !params[:landmark][:name].empty?
      if !!params[:figure][:landmark_ids]
        params[:figure][:landmark_ids] << Landmark.create(params[:landmark]).id
      else
        params[:figure][:landmark_ids] = []
        params[:figure][:landmark_ids] << Landmark.create(params[:landmark]).id
      end
    end
    @figure.landmark_ids = params[:figure][:landmark_ids]

    @figure.save

    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if !params[:title][:name].empty?
      if !!params[:figure][:title_ids]
        params[:figure][:title_ids] << Title.create(params[:title]).id
      else
        params[:figure][:title_ids] = []
        params[:figure][:title_ids] << Title.create(params[:title]).id
      end
    end
    @figure.title_ids = params[:figure][:title_ids]

    if !params[:landmark][:name].empty?
      if !!params[:figure][:landmark_ids]
        params[:figure][:landmark_ids] << Landmark.create(params[:landmark]).id
      else
        params[:figure][:landmark_ids] = []
        params[:figure][:landmark_ids] << Landmark.create(params[:landmark]).id
      end
    end
    @figure.landmark_ids = params[:figure][:landmark_ids]

    @figure.save

    redirect to "/figures/#{@figure.id}"
  end
end
