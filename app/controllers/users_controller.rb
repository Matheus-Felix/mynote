class UsersController < ApplicationController
  
  before_filter set_user: [:add_note, :remove_note]

  def add_note
  	@note = current_user.notes.find params[:note_id] # compartilhar note 1- currente user (eu dou permissão) 2- procuro em minhas próprias notas 3- o id da nota
  	@user.guest_notes << @note # o usuário convidado recebe a nota compartilhada

  	#NoteMailer.new_note_permission(@note, @user).deliver_now
  	render json: {message: "Compartilhamento bem sucedido!"}, status: :ok
  end

  def remove_note
  	@note = current_user.notes.find params[:note_id] 
  	@user.guest_notes.delete(@note.id)

  	#NoteMailer.new_note_permission(@note, @user).deliver_now
  	render json: {message: "Permissão revogada com sucesso!"}, status: :ok

  end

  private

  	def set_user
  	  @user = User.find params[:id]
  	 end

end
