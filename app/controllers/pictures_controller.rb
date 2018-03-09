class PicturesController < ApplicationController
  before_action:set_picture, only:[:edit, :update, :destroy]
  before_action:get_picture_list, only:[:index, :confirm, :create]

  def index
    # インスタ投稿保持
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end

  end

  #編集画面
  def edit
  end

  #編集処理
  def update
    if @picture.update(picture_params)
      #成功の場合
      redirect_to pictures_path, notice: 'つぶやきの編集が完了しました'
    else
      #失敗の場合
      render 'edit'
    end
  end

  #削除処理
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice: 'つぶやきの削除が完了しました'
  end

  #新規作成処理
  def create

    @picture = Picture.new(picture_params)

    unless params[:cache].nil?
      # 画像ファイル設定処理があるなら
      @picture.image.retrieve_from_cache! params[:cache][:image]
      @picture.save!
    end

    if @picture.save
      ##メール送信機能
      ContactMailer.contact_mail(@picture).deliver
      redirect_to pictures_path, notice: '新規のつぶやきが完了しました'
    else
      render confirm_pictures_path
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    render:index if @picture.invalid?
  end

  # def show
  #
  # end

private
  def picture_params
    params.require(:picture).permit(:content, :user_id, :image)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def get_picture_list
    @list = Picture.all
  end

end
