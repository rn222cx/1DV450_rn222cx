class Api::V1::UsersController < Api::V1::BaseController
     # before_filter :restrict_access
     # respond_to :json
      include ActiveHashRelation

      def index
        users = User.all

        render(
            json: ActiveModel::ArraySerializer.new(
                users,
                each_serializer: Api::V1::UserSerializer,
                root: 'users',
            )
        )
      end

      def show
        user = User.find(params[:id])

        render(json: Api::V1::UserSerializer.new(user).to_json)
      end

      # def create
      #   respond_with User.create(params[:users])
      # end
      #
      # def update
      #   respond_with User.update(params[:id], params[:users])
      # end
      #
      # def destroy
      #   respond_with User.destroy(params[:id])
      # end

      # private
      #
      # def restrict_access
      #   authenticate_or_request_with_http_token do |token, options|
      #     ApiKey.exists?(access_token: token)
      #   end
      # end
      #
      # private
      #
      # def user_params
      #   params.require(:user).permit(:email, :password, :password_confirmation)
      # end

end