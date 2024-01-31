class Event < ApplicationRecord
  after_create :create_brackets_and_weightclasses

  validates_presence_of :name, :start_at, :location, :game_type, :organizer_id
  
  enum game_type: { gi: 'Gi', no_gi: 'NoGi'}
  
  belongs_to :organizer, class_name: "User"
  has_many :brackets, dependent: :destroy
  has_many :weightclasses, through: :brackets
  has_many :registrations, through: :brackets
  # has_many :matches, through: :brackets

  # gi_weights_path = Rails.root.join('lib', 'weight_classes_gi.yml')
  # nogi_weights_path = Rails.root.join('lib', 'weight_classes_nogi.yml')
  gi_weights_path = Rails.root.join(WEIGHT_CLASSES_CONFIG['gi_weights_path'])
  nogi_weights_path = Rails.root.join(WEIGHT_CLASSES_CONFIG['nogi_weights_path'])

  WEIGHT_CLASSES_DATA_GI = YAML.load_file(gi_weights_path).freeze
  WEIGHT_CLASSES_DATA_NOGI = YAML.load_file(nogi_weights_path).freeze
  BELTS = ['White', 'Blue', 'Purple', 'Brown', 'Black'].freeze

  private
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