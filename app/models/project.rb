class Project < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :sponsors, through: :transactions, class_name: "User", source: :user
  has_many :tiers
  accepts_nested_attributes_for :tiers
  has_many :transactions
  has_attached_file :projectpicture, styles: { medium: "400x250>", thumb: "100x100>" }, default_url: ActionController::Base.helpers.asset_path('assets/defaultprojectimage.png')

  def sum_raised
    total = 0
    self.transactions.each do |pledge|
      total += pledge.dollar_amount if pledge.dollar_amount
    end
    total
  end

  def percentage_raised
    if self.goal != 0
      ( (self.sum_raised.to_f / self.goal) * 100 ).to_i
    else
      0
    end
  end

  def active
    (self.percentage_raised < 100) && (self.end_date >= DateTime.now)
  end

  def number_of_backers
    a = self.transactions.select{|transaction| !transaction.dollar_amount.nil?}
    a.uniq! { |p| p.user_id }
    a.count
  end

  def number_of_transactions
    self.transactions.select{|transaction| !transaction.dollar_amount.nil?}.size
  end

end

