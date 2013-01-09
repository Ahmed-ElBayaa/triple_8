class Classified < ActiveRecord::Base

	default_scope order:'created_at DESC'
	
	KINDS = [ I18n.t('models.classified.wanted'),
			 I18n.t('models.classified.for_sale') ]
	MAX_ATTACHMENTS_NO = 3

	has_many :attachments, dependent: :destroy
	
	belongs_to :main_category, class_name: 'Category'
	belongs_to :sub_category, class_name: 'Category'
	belongs_to :country, foreign_key: 'location_id'
	belongs_to :user

	accepts_nested_attributes_for :attachments, allow_destroy: true

	attr_protected :user_id
	
	before_save :set_identifier

	validates :title, :kind, :user_id, :main_category_id,
				:sub_category_id, :price, presence: true
	validates :title, uniqueness: :true
	validates :kind, inclusion: KINDS
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validate :categories_validations
	validate :attachments_validations

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.title.parameterize+"#{self.id}#{Random.rand(999)}"
	end

	def attachments_validations
		if self.attachments.count > MAX_ATTACHMENTS_NO
			self.errors.add(:base, I18n.t(
				"models.classified.errors.max_attachments_no_exceeds"))
		end
	end

	def categories_validations
		if self.main_category and self.main_category.main_category?
			unless self.main_category.include_sub_category? self.sub_category
				errors.add(:base, I18n.t(
						"models.classified.errors.invalid_sub_category"))
			end
		else
			errors.add(:base, I18n.t(
				"models.classified.errors.invalid_main_category"))
		end
	end

	def complete_attachments_number
      i = MAX_ATTACHMENTS_NO - self.attachments.count
      i.times {self.attachments.build}
    end

end
