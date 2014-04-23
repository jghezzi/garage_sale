class ItemsController < ApplicationController
	#GET '/items'
	def index
		@items = Item.all
		@rev = 0
		@items.each do |a| 
			if a.status == "SOLD"
				@rev += a.price
			end
		end
	end

	#GET '/items/new'
	def new
		@new_item = Item.new
	end

	#POST 'items'
	def create
		@new_item = Item.new(item_params)
		if @new_item.save
			redirect_to "/items"
		end
	end

	#GET 'items/:id'
	def show
		@item = Item.find(params[:id])
	end

	#GET '/items/:id/edit'
	def edit
		@item = Item.find(params[:id])
	end

	#PATCH / PUT 'items/:id'
	def update
		@item = Item.find(params[:id])
		@item.update_attributes(item_params)
		redirect_to "/items"
	end

	def destroy
		@delete_item = Item.find(params[:id])
		@delete_item.delete
		redirect_to "/items"
	end

	private

	def item_params
		params.require(:item).permit(:name, :description, :price, :status)
	end	

end
