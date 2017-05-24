class NotesController < ApplicationController
  
  before_filter set_note: [:update, :destroy, :show]
  
  def index
    #TODO: colocar filters
    @notes = current_user.notes + current_user.guest_notes
    render :json => @notes.to_json(:include => [:users, :tags]) #inclui todos records associados user e tags
  end

  def show
    render :json => @note.to_json(:include => [:users, :tags]) 
  end

  def create

    @note = Note.new(note_params.merge(user: current_user))

    if @note.save
      render json: {message: "Nota criada com suceeso!"}, status: :created
    else
      render json: {message: "Falha ao criar nota!"}, status: :unprocessable_entity
    end 
  end

  def update
    if @note.update(note_params)
      render json: {message: "Nota atualizada com suceeso!"}, status: :ok
    else
      render json: {message: "Falha ao atualizar nota!"}, status: :unprocessable_entity
    end 

  end

  def destroy
    @note.destroy
   render json: {message: "Nota removida com suceeso!"}, status: :ok
  end

  private

  def set_note
    @note = Note.find params[:id]
  end

  def note_params
    params.require[:note].permit[:title, :body]
  end  


  
end
