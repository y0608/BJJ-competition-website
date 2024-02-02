class Event < ApplicationRecord
  after_create :create_brackets_and_weightclasses

  validates_presence_of :name, :start_at, :location, :game_type, :organizer_id
  validate :end_date_after_start_date
  validate :start_date_after_today

  enum game_type: { gi: 'Gi', no_gi: 'NoGi'}
  
  belongs_to :organizer, class_name: "User"
  has_many :brackets, dependent: :destroy
  has_many :weightclasses, through: :brackets
  has_many :matches, through: :brackets
  has_many :registrations, through: :brackets # only one registration per competitor per bracket(can have multiple for event(e.g AdultWhiteMale88 and AdultWhiteMaleOpen))

  def create_matches
    brackets.each do |bracket|
      bracket.create_matches
    end
  end

  private
  
  def end_date_after_start_date
    if end_at.present? && start_at.present? && end_at < start_at
      errors.add(:end_at, "must be after the start date") 
    end
  end

  def start_date_after_today
    if start_at.present? && start_at < Date.today
      errors.add(:start_at, "must be after today") 
    end
  end

  gi_weights_path = Rails.root.join(WEIGHT_CLASSES_CONFIG['gi_weights_path'])
  nogi_weights_path = Rails.root.join(WEIGHT_CLASSES_CONFIG['nogi_weights_path'])

  WEIGHT_CLASSES_DATA_GI = YAML.load_file(gi_weights_path).freeze
  WEIGHT_CLASSES_DATA_NOGI = YAML.load_file(nogi_weights_path).freeze
  BELTS = ['White', 'Blue', 'Purple', 'Brown', 'Black'].freeze

  def create_brackets_and_weightclasses
    weight_classes_data = (self.game_type == 'gi') ? WEIGHT_CLASSES_DATA_GI : WEIGHT_CLASSES_DATA_NOGI

    weight_classes_data.each do |age_group, genders|
      genders.each do |gender, weight_classes|
        BELTS.each do |belt|
          weight_classes.each do |weight_class, weight|
            next if age_group == 'Juvenile' && (belt == 'Brown' || belt == 'Black')

            bracket = brackets.create() # automatically creates bracket ties it to an event
            weightclass = bracket.create_weightclass(age: age_group, sex: gender, belt: belt, weight: weight)
          end
        end
      end
    end
  end
end