class Article < ActiveRecord::Base

	include AASM
	
	belongs_to :user
	has_many :comment

	has_many :has_tag
	has_many :tags , through: :has_tag
	
	validates :title , { presence: true }
	validates :body , { presence: true , length: {minimum: 25} }
	before_create :set_visits_count

	has_attached_file :cover, :styles => { :medium => "800x600>", :thumb => "400x300>" }, :default_url => "images11.png"
	validates_attachment :cover, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }


	after_create :set_tags

	def tags=(value)	
		@tags = value
	end

	def update_visits_count
		self.update( visits_count: self.visits_count + 1 )	
	end


	#scope: metodos de clase - funciones anonimas
	scope :publicados, ->{ where(state:"published") }
	scope :ultimos, ->{	order("created_at DESC") }
	scope :selecciona10, ->{ limit(10) }

  	aasm column: "state" do
    	state :in_draft, :initial => true
    	state :published
   

    	event :publish do
      		transitions :from => :in_draft, :to => :published
    	end

    	event :unpublish do
      		transitions :from => :published, :to => :in_draft
    	end
    end

	private

	def set_tags
		unless @tags.nil?
			@tags.each do |tag_id|
				HasTag.create(article_id: self.id , tag_id: tag_id)
			end
		end
	end

	def set_visits_count
		self.visits_count ||= 0
	end

end
